//
//  XCDYouTubeVideoPlayerViewController.m
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoPlayerViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>

NSString *const XCDYouTubeVideoErrorDomain = @"XCDYouTubeVideoErrorDomain";
NSString *const XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey = @"error"; // documented in -[MPMoviePlayerController initWithContentURL:]

NSString *const XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification = @"XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification";
NSString *const XCDMetadataKeyTitle = @"Title";
NSString *const XCDMetadataKeySmallThumbnailURL = @"SmallThumbnailURL";
NSString *const XCDMetadataKeyMediumThumbnailURL = @"MediumThumbnailURL";
NSString *const XCDMetadataKeyLargeThumbnailURL = @"LargeThumbnailURL";

static NSDictionary *DictionaryWithQueryString(NSString *string, NSStringEncoding encoding)
{
	NSMutableDictionary *dictionary = [NSMutableDictionary new];
	NSArray *fields = [string componentsSeparatedByString:@"&"];
	for (NSString *field in fields)
	{
		NSArray *pair = [field componentsSeparatedByString:@"="];
		if (pair.count == 2)
		{
			NSString *key = pair[0];
			NSString *value = [pair[1] stringByReplacingPercentEscapesUsingEncoding:encoding];
			value = [value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
			dictionary[key] = value;
		}
	}
	return dictionary;
}

static NSString *ApplicationLanguageIdentifier(void)
{
	static NSString *applicationLanguageIdentifier;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		applicationLanguageIdentifier = @"en";
		NSArray *preferredLocalizations = [[NSBundle mainBundle] preferredLocalizations];
		if (preferredLocalizations.count > 0)
			applicationLanguageIdentifier = [NSLocale canonicalLanguageIdentifierFromString:preferredLocalizations[0]] ?: applicationLanguageIdentifier;
	});
	return applicationLanguageIdentifier;
}

@interface XCDYouTubeVideoPlayerViewController ()
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *connectionData;
@property (nonatomic, strong) NSMutableArray *elFields;
@property (nonatomic, assign, getter = isEmbedded) BOOL embedded;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@end

@implementation XCDYouTubeVideoPlayerViewController

static void *XCDYouTubeVideoPlayerViewControllerKey = &XCDYouTubeVideoPlayerViewControllerKey;

- (id) init
{
	return [self initWithVideoIdentifier:nil];
}

- (id) initWithContentURL:(NSURL *)contentURL
{
	@throw [NSException exceptionWithName:NSGenericException reason:@"Use the `initWithVideoIdentifier:` method instead." userInfo:nil];
}

- (id) initWithVideoIdentifier:(NSString *)videoIdentifier
{
	if (!(self = [super init]))
		return nil;
	
	self.preferredVideoQualities = nil;
	
	if (videoIdentifier)
		self.videoIdentifier = videoIdentifier;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillEnterFullscreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:self.moviePlayer];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillExitFullscreen:) name:MPMoviePlayerWillExitFullscreenNotification object:self.moviePlayer];
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) setVideoIdentifier:(NSString *)videoIdentifier
{
	if (![NSThread isMainThread])
	{
		[self performSelectorOnMainThread:_cmd withObject:videoIdentifier waitUntilDone:NO];
		return;
	}
	
	if ([videoIdentifier isEqual:self.videoIdentifier])
		return;
	
	_videoIdentifier = [videoIdentifier copy];
	
	self.elFields = [[NSMutableArray alloc] initWithArray:@[ @"embedded", @"detailpage", @"vevo", @"" ]];
	
	[self startVideoInfoRequest];
}

- (void) setPreferredVideoQualities:(NSArray *)preferredVideoQualities
{
	if (preferredVideoQualities)
	{
		_preferredVideoQualities = [preferredVideoQualities copy];
	}
	else
	{
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
			_preferredVideoQualities = @[ @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ];
		else
			_preferredVideoQualities = @[ @(XCDYouTubeVideoQualityHD1080), @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ];
	}
}

- (void) presentInView:(UIView *)view
{
	self.embedded = YES;
	
	self.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
	self.moviePlayer.view.frame = CGRectMake(0.f, 0.f, view.bounds.size.width, view.bounds.size.height);
	self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	if (![view.subviews containsObject:self.moviePlayer.view])
		[view addSubview:self.moviePlayer.view];
	objc_setAssociatedObject(view, XCDYouTubeVideoPlayerViewControllerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) startVideoInfoRequest
{
	NSString *elField = [self.elFields objectAtIndex:0];
	[self.elFields removeObjectAtIndex:0];
	if (elField.length > 0)
		elField = [@"&el=" stringByAppendingString:elField];
	
	NSURL *videoInfoURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/get_video_info?video_id=%@%@&ps=default&eurl=&gl=US&hl=%@", self.videoIdentifier ?: @"", elField, ApplicationLanguageIdentifier()]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:videoInfoURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
	[request setValue:ApplicationLanguageIdentifier() forHTTPHeaderField:@"Accept-Language"];
	[self.connection cancel];
	self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) finishWithError:(NSError *)error
{
	NSDictionary *userInfo = @{ MPMoviePlayerPlaybackDidFinishReasonUserInfoKey: @(MPMovieFinishReasonPlaybackError),
	                            XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey: error };
	[[NSNotificationCenter defaultCenter] postNotificationName:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer userInfo:userInfo];
	
	if (self.isEmbedded)
		[self.moviePlayer.view removeFromSuperview];
	else
		[self.presentingViewController dismissMoviePlayerViewControllerAnimated];
}

#pragma mark - UIViewController

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if (![self isBeingPresented])
		return;
	
	self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
	[self.moviePlayer play];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	if (![self isBeingDismissed])
		return;
	
	[self.connection cancel];
}

#pragma mark - NSURLConnectionDataDelegate / NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSUInteger capacity = response.expectedContentLength == NSURLResponseUnknownLength ? 0 : (NSUInteger)response.expectedContentLength;
	self.connectionData = [[NSMutableData alloc] initWithCapacity:capacity];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.connectionData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSError *error = nil;
	NSURL *videoURL = [self videoURLWithData:self.connectionData error:&error];
	if (videoURL)
		self.moviePlayer.contentURL = videoURL;
	else if (self.elFields.count > 0)
		[self startVideoInfoRequest];
	else
		[self finishWithError:error];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self finishWithError:error];
}

#pragma mark - Notifications

- (void) moviePlayerWillEnterFullscreen:(NSNotification *)notification
{
	UIApplication *application = [UIApplication sharedApplication];
	self.statusBarHidden = application.statusBarHidden;
	self.statusBarStyle = application.statusBarStyle;
}

- (void) moviePlayerWillExitFullscreen:(NSNotification *)notification
{
	UIApplication *application = [UIApplication sharedApplication];
	[application setStatusBarHidden:self.statusBarHidden withAnimation:UIStatusBarAnimationFade];
	[application setStatusBarStyle:self.statusBarStyle animated:YES];
}

#pragma mark - URL Parsing

- (NSURL *) videoURLWithData:(NSData *)data error:(NSError * __autoreleasing *)error
{
	NSString *videoQuery = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSStringEncoding queryEncoding = NSUTF8StringEncoding;
	NSDictionary *video = DictionaryWithQueryString(videoQuery, queryEncoding);
	NSMutableArray *streamQueries = [[video[@"url_encoded_fmt_stream_map"] componentsSeparatedByString:@","] mutableCopy];
	[streamQueries addObjectsFromArray:[video[@"adaptive_fmts"] componentsSeparatedByString:@","]];
	
	NSMutableDictionary *streamURLs = [NSMutableDictionary new];
	for (NSString *streamQuery in streamQueries)
	{
		NSDictionary *stream = DictionaryWithQueryString(streamQuery, queryEncoding);
		NSString *type = stream[@"type"];
		NSString *urlString = stream[@"url"];
		if (urlString && [AVURLAsset isPlayableExtendedMIMEType:type])
		{
			NSURL *streamURL = [NSURL URLWithString:urlString];
			NSString *signature = stream[@"sig"];
			if (signature)
				streamURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&signature=%@", urlString, signature]];
			
			if ([[DictionaryWithQueryString(streamURL.query, queryEncoding) allKeys] containsObject:@"signature"])
				streamURLs[@([stream[@"itag"] integerValue])] = streamURL;
		}
	}
	
	for (NSNumber *videoQuality in self.preferredVideoQualities)
	{
		NSURL *streamURL = streamURLs[videoQuality];
		if (streamURL)
		{
			NSString *title = video[@"title"];
			NSString *thumbnailSmall = video[@"thumbnail_url"];
			NSString *thumbnailMedium = video[@"iurlsd"] ?: video[@"iurl"];
			NSString *thumbnailLarge = video[@"iurlmaxres"];
			NSMutableDictionary *userInfo = [NSMutableDictionary new];
			if (title)
				userInfo[XCDMetadataKeyTitle] = title;
			if (thumbnailSmall)
				userInfo[XCDMetadataKeySmallThumbnailURL] = [NSURL URLWithString:thumbnailSmall];
			if (thumbnailMedium)
				userInfo[XCDMetadataKeyMediumThumbnailURL] = [NSURL URLWithString:thumbnailMedium];
			if (thumbnailLarge)
				userInfo[XCDMetadataKeyLargeThumbnailURL] = [NSURL URLWithString:thumbnailLarge];
			
			[[NSNotificationCenter defaultCenter] postNotificationName:XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification object:self userInfo:userInfo];
			return streamURL;
		}
	}
	
	if (error)
	{
		NSMutableDictionary *userInfo = [@{ NSURLErrorKey: self.connection.originalRequest.URL } mutableCopy];
		NSString *reason = video[@"reason"];
		if (reason)
		{
			reason = [reason stringByReplacingOccurrencesOfString:@"<br\\s*/?>" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, reason.length)];
			NSRange range;
			while ((range = [reason rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
				reason = [reason stringByReplacingCharactersInRange:range withString:@""];
			
			userInfo[NSLocalizedDescriptionKey] = reason;
		}
		
		NSInteger code = [video[@"errorcode"] integerValue];
		*error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:code userInfo:userInfo];
	}
	
	return nil;
}

@end
