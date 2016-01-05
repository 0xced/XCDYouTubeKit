//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "AppDelegate.h"

@import AVFoundation;

#import <CocoaLumberjack/CocoaLumberjack.h>
#import <XCDYouTubeKit/XCDYouTubeKit.h>

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"VideoIdentifier": @"6v2L2UGZJAM" }];
	
	[DDLog addLogger:[DDASLLogger sharedInstance]];
}

- (IBAction) playVideo:(id)sender
{
	self.playerView.player = nil;
	
	[self.progressIndicator startAnimation:sender];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:[sender stringValue] completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		[self.progressIndicator stopAnimation:sender];
		
		if (video)
		{
			NSDictionary *streamURLs = video.streamURLs;
			NSURL *url = streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?: streamURLs[@(XCDYouTubeVideoQualityHD720)] ?: streamURLs[@(XCDYouTubeVideoQualityMedium360)] ?: streamURLs[@(XCDYouTubeVideoQualitySmall240)];
			AVPlayer *player = [AVPlayer playerWithURL:url];
			self.playerView.player = player;
			[player play];
		}
		else
		{
			[[NSAlert alertWithError:error] runModal];
		}
	}];
}

@end
