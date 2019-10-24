//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "DemoInlineViewController.h"

#import <XCDYouTubeKit/XCDYouTubeKit.h>

#import <AVKit/AVKit.h>

#import "XCDYouTubeKit_iOS_Demo-Swift.h"

@implementation DemoInlineViewController

- (IBAction) load:(id)sender
{
	NSString *videoIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"VideoIdentifier"];
	
	AVPlayerViewController *playerViewController = [AVPlayerViewController new];
	playerViewController.view.frame = self.videoContainerView.bounds;
	[self addChildViewController:playerViewController];
	[self.videoContainerView addSubview:playerViewController.view];
	[playerViewController didMoveToParentViewController:self];
	
	__weak AVPlayerViewController *weakPlayerViewController = playerViewController;
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:videoIdentifier completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error) {
		if (video)
		{
			weakPlayerViewController.player = [AVPlayer playerWithURL:video.streamURL];
			if (self.shouldAutoplaySwitch.on)
				[weakPlayerViewController.player play];
		}
		else
		{
			[[Utilities shared]displayError:error originViewController:self];
		}
	}];
}

@end
