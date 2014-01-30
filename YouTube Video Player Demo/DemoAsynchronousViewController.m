//
//  DemoAsynchronousViewController.m
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 26.09.13.
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "DemoAsynchronousViewController.h"

@implementation DemoAsynchronousViewController

- (IBAction) play:(id)sender
{
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [XCDYouTubeVideoPlayerViewController new];
	[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
	
	// https://developers.google.com/youtube/2.0/developers_guide_protocol_video_feeds#Standard_feeds
	NSURL *url = [NSURL URLWithString:@"https://gdata.youtube.com/feeds/api/standardfeeds/most_popular?v=2&alt=json&time=today&max-results=1"];
	[NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		id json = [NSJSONSerialization JSONObjectWithData:data ?: [NSData new] options:0 error:NULL];
		NSString *videoIdentifier = [[[json valueForKeyPath:@"feed.entry.media$group.yt$videoid.$t"] lastObject] description];
		videoPlayerViewController.videoIdentifier = videoIdentifier;
	}];
}

@end
