//
//  XCDYouTubeVideoPlayerViewController.m
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoPlayerViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>

NSString *const XCDYouTubeVideoErrorDomain = @"XCDYouTubeVideoErrorDomain";
NSString *const XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey = @"XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey";

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
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
		_preferredVideoQualities = @[ @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ];
	else
		_preferredVideoQualities = @[ @(XCDYouTubeVideoQualityHD1080), @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ];
	
	if (videoIdentifier)
		self.videoIdentifier = videoIdentifier;
	
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

- (void) presentInView:(UIView *)view
{
	self.embedded = YES;
	
	UIApplication *application = [UIApplication sharedApplication];
	self.statusBarHidden = application.statusBarHidden;
	self.statusBarStyle = application.statusBarStyle;
	
	self.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
	self.moviePlayer.view.frame = CGRectMake(0.f, 0.f, view.bounds.size.width, view.bounds.size.height);
	self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[view addSubview:self.moviePlayer.view];
	objc_setAssociatedObject(view, XCDYouTubeVideoPlayerViewControllerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) startVideoInfoRequest
{
	NSString *elField = [self.elFields objectAtIndex:0];
	[self.elFields removeObjectAtIndex:0];
	if (elField.length > 0)
		elField = [@"&el=" stringByAppendingString:elField];
	
	NSURL *videoInfoURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/get_video_info?video_id=%@%@&ps=default&eurl=&gl=US&hl=en", self.videoIdentifier ?: @"", elField]];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:videoInfoURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
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
	
	if ([self isBeingPresented])
		self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	if ([self isBeingDismissed])
		[self.connection cancel];
}

#pragma mark - NSURLConnectionDataDelegate / NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSUInteger capacity = response.expectedContentLength == NSURLResponseUnknownLength ? 0 : response.expectedContentLength;
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
	{
		self.moviePlayer.contentURL = videoURL;
		[self.moviePlayer prepareToPlay];
	}
	else if (self.elFields.count > 0)
	{
		[self startVideoInfoRequest];
	}
	else
	{
		[self finishWithError:error];
	}
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self finishWithError:error];
}

#pragma mark - Notifications

- (void) moviePlayerWillExitFullscreen:(NSNotification *)notification
{
	UIApplication *application = [UIApplication sharedApplication];
	[application setStatusBarHidden:self.statusBarHidden withAnimation:UIStatusBarAnimationFade];
	[application setStatusBarStyle:self.statusBarStyle animated:YES];
}

#pragma mark - URL Parsing

- (NSURL *) videoURLWithData:(NSData *)data error:(NSError **)error
{
	NSString *videoQuery = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSStringEncoding queryEncoding = NSUTF8StringEncoding;
	NSDictionary *video = DictionaryWithQueryString(videoQuery, queryEncoding);
	NSArray *streamQueries = [video[@"url_encoded_fmt_stream_map"] componentsSeparatedByString:@","];
	
	NSMutableDictionary *streamURLs = [NSMutableDictionary new];
	for (NSString *streamQuery in streamQueries)
	{
		NSDictionary *stream = DictionaryWithQueryString(streamQuery, queryEncoding);
		NSString *type = stream[@"type"];
		if ([AVURLAsset isPlayableExtendedMIMEType:type])
		{
			NSURL *streamURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&signature=%@", stream[@"url"], stream[@"sig"]]];
			streamURLs[@([stream[@"itag"] integerValue])] = streamURL;
		}
	}
	
	for (NSNumber *videoQuality in self.preferredVideoQualities)
	{
		NSURL *streamURL = streamURLs[videoQuality];
		if (streamURL)
			return streamURL;
	}
	
	if (error)
	{
		NSMutableDictionary *userInfo = [@{ NSURLErrorKey: self.connection.originalRequest.URL } mutableCopy];
		NSString *reason = video[@"reason"];
		if (reason)
			userInfo[NSLocalizedDescriptionKey] = reason;
		
		NSInteger code = [video[@"errorcode"] integerValue];
		*error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:code userInfo:userInfo];
	}
	
	return nil;
}

@end
