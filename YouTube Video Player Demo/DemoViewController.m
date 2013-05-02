//
//  ViewController.m
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import "DemoViewController.h"

#import "XCDYouTubeVideoPlayerViewController.h"

@interface DemoViewController ()
@property (nonatomic, weak) IBOutlet UITextField *videoIdentifierTextField;
@property (nonatomic, weak) IBOutlet UISwitch *lowQualitySwitch;
@end

@implementation DemoViewController

- (IBAction) playYouTubeVideo:(id)sender
{
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithYouTubeVideoIdentifier:self.videoIdentifierTextField.text];
	if (self.lowQualitySwitch.on)
		videoPlayerViewController.preferredVideoQuality = @[ @(XCDYouTubeVideoQualitySmall240), @(XCDYouTubeVideoQualityMedium360) ];
	[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
}

@end
