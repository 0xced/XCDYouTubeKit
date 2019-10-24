//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "DemoAsynchronousViewController.h"

#import <XCDYouTubeKit/XCDYouTubeKit.h>

#import <AVKit/AVKit.h>

#import "XCDYouTubeKit_iOS_Demo-Swift.h"

@implementation DemoAsynchronousViewController

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	self.apiKeyTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"YouTubeAPIKey"];
}

- (IBAction) play:(id)sender
{
	NSString *apiKey = self.apiKeyTextField.text;
	[[NSUserDefaults standardUserDefaults] setObject:apiKey forKey:@"YouTubeAPIKey"];
		
	// https://developers.google.com/youtube/v3/docs/videos/list
	NSURL *mostPopularURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos?key=%@&chart=mostPopular&part=id", apiKey]];
	
	[[[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]]dataTaskWithURL:mostPopularURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
	  {
		if (error) {
			[[Utilities shared]displayError:error originViewController:self];
			return;
		}
		
		id json = [NSJSONSerialization JSONObjectWithData:data ?: [NSData new] options:0 error:NULL];
		NSString *videoIdentifier = [[[json valueForKeyPath:@"items.id"] firstObject] description];
		[self displayVideoIdentifier:videoIdentifier];
	}] resume];
}

- (void) displayVideoIdentifier:(NSString *)videoIdentifier
{
	
	[[XCDYouTubeClient defaultClient]getVideoWithIdentifier:videoIdentifier completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error)
	{
		if (error) {
			[[Utilities shared]displayError:error originViewController:self];
			return;
		}
		
		AVPlayerViewController *playerViewController = [AVPlayerViewController new];
		playerViewController.player = [AVPlayer playerWithURL:video.streamURL];
		[self presentViewController:playerViewController animated:YES completion:nil];
		[playerViewController.player play];
		
	}];
}

@end
