//
//  XCDYouTubeVideoPlayerViewController.m
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoPlayerViewController.h"

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
@end

@implementation XCDYouTubeVideoPlayerViewController

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
		_preferredVideoQuality = @[ @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ];
	else
		_preferredVideoQuality = @[ @(XCDYouTubeVideoQualityHD1080), @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ];
	
	if (videoIdentifier)
		self.videoIdentifier = videoIdentifier;
	
	return self;
}

- (void) setVideoIdentifier:(NSString *)videoIdentifier
{
	if (![NSThread isMainThread])
	{
		[self performSelectorOnMainThread:_cmd withObject:videoIdentifier waitUntilDone:NO];
		return;
	}
	
	_videoIdentifier = videoIdentifier;
	
	self.elFields = [[NSMutableArray alloc] initWithArray:@[ @"embedded", @"detailpage", @"vevo", @"" ]];
	
	[self startVideoInfoRequest];
}

- (void) startVideoInfoRequest
{
	NSString *elField = [self.elFields objectAtIndex:0];
	[self.elFields removeObjectAtIndex:0];
	if (elField.length > 0)
		elField = [@"&el=" stringByAppendingString:elField];
	
	NSURL *videoInfoURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/get_video_info?video_id=%@%@&ps=default&eurl=&gl=US&hl=en", self.videoIdentifier, elField]];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:videoInfoURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
	[self.connection cancel];
	self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) finishWithPlaybackError
{
	NSDictionary *userInfo = @{ MPMoviePlayerPlaybackDidFinishReasonUserInfoKey: @(MPMovieFinishReasonPlaybackError) };
	[[NSNotificationCenter defaultCenter] postNotificationName:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer userInfo:userInfo];
	
	[self.presentingViewController dismissMoviePlayerViewControllerAnimated];
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
	NSURL *videoURL = [self videoURLWithData:self.connectionData];
	if (videoURL)
		self.moviePlayer.contentURL = videoURL;
	else if (self.elFields.count > 0)
		[self startVideoInfoRequest];
	else
		[self finishWithPlaybackError];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self finishWithPlaybackError];
}

#pragma mark - URL Parsing

- (NSURL *) videoURLWithData:(NSData *)data
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
		if ([type hasPrefix:@"video/mp4"] || [type hasPrefix:@"video/3gpp"])
		{
			NSURL *streamURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&signature=%@", stream[@"url"], stream[@"sig"]]];
			streamURLs[@([stream[@"itag"] integerValue])] = streamURL;
		}
	}
	
	for (NSNumber *videoQuality in self.preferredVideoQuality)
	{
		NSURL *streamURL = streamURLs[videoQuality];
		if (streamURL)
			return streamURL;
	}
	
	return nil;
}

@end
