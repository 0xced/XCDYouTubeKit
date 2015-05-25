//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "DemoAsynchronousViewController.h"

@implementation DemoAsynchronousViewController

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	self.apiKeyTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"YouTubeAPIKey"];
}

- (IBAction) play:(id)sender
{
	NSString *apiKey = self.apiKeyTextField.text;
	NSURL *mostPopularURL;
	NSString *videoIdentifierKeyPath;
	if (apiKey.length > 0)
	{
		// https://developers.google.com/youtube/v3/docs/videos/list
		mostPopularURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos?key=%@&chart=mostPopular&part=id", apiKey]];
		videoIdentifierKeyPath = @"items.id";
		[[NSUserDefaults standardUserDefaults] setObject:apiKey forKey:@"YouTubeAPIKey"];
	}
	else
	{
		// https://developers.google.com/youtube/2.0/developers_guide_protocol_video_feeds#Standard_feeds
		mostPopularURL = [NSURL URLWithString:@"https://gdata.youtube.com/feeds/api/standardfeeds/most_popular?v=2&alt=json&time=today&max-results=1"];
		videoIdentifierKeyPath = @"feed.entry.media$group.yt$videoid.$t";
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"YouTubeAPIKey"];
	}
	
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [XCDYouTubeVideoPlayerViewController new];
	videoPlayerViewController.moviePlayer.backgroundPlaybackEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlayVideoInBackground"];
	[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
	
	[NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:mostPopularURL] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
	{
		id json = [NSJSONSerialization JSONObjectWithData:data ?: [NSData new] options:0 error:NULL];
		NSString *videoIdentifier = [[[json valueForKeyPath:videoIdentifierKeyPath] firstObject] description];
		videoPlayerViewController.videoIdentifier = videoIdentifier;
	}];
}

@end
