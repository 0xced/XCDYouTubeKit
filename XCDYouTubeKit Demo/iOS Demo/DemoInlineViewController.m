//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "DemoInlineViewController.h"

#import <XCDYouTubeKit/XCDYouTubeKit.h>

#import <AVKit/AVKit.h>

#import "XCDYouTubeKit_iOS_Demo-Swift.h"

@implementation DemoInlineViewController


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[[AVPlayerViewControllerManager shared].controller.player pause];
}
- (IBAction) load:(id)sender
{
	NSString *videoIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"VideoIdentifier"];

	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:videoIdentifier completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error) {
		if (video)
		{
			[AVPlayerViewControllerManager shared].video = video;
			AVPlayerViewController *playerViewController = [AVPlayerViewControllerManager shared].controller;
			playerViewController.view.frame = self.videoContainerView.bounds;
			[self addChildViewController:playerViewController];
			[self.videoContainerView addSubview:playerViewController.view];
			[playerViewController didMoveToParentViewController:self];
			
			if (self.shouldAutoplaySwitch.on)
				[playerViewController.player play];
		}
		else
		{
			[[Utilities shared]displayError:error originViewController:self];
		}
	}];
}

@end
