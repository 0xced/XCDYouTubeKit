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

@implementation XCDYouTubeVideoPlayerViewController

- (id) initWithYouTubeVideoIdentifier:(NSString *)videoIdentifier
{
	if (!(self = [super initWithContentURL:nil]))
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
	_videoIdentifier = videoIdentifier;
	
	NSURL *videoInfoURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/get_video_info?video_id=%@", videoIdentifier]];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:videoInfoURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		if (_videoIdentifier && ![_videoIdentifier isEqual:videoIdentifier])
			return;
		
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
		
		NSURL *streamURL = nil;
		for (NSNumber *videoQuality in self.preferredVideoQuality)
		{
			streamURL = streamURLs[videoQuality];
			if (streamURL)
			{
				[self performSelectorOnMainThread:@selector(setStreamURL:) withObject:streamURL waitUntilDone:NO];
				break;
			}
		}
		
		if (!streamURL)
			[self performSelectorOnMainThread:@selector(dismiss) withObject:nil waitUntilDone:NO];
	}];
}

- (void) setStreamURL:(NSURL *)streamURL
{
	self.moviePlayer.contentURL = streamURL;
}

- (void) dismiss
{
	[self.presentingViewController dismissMoviePlayerViewControllerAnimated];
}

@end
