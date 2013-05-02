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
@end

@implementation DemoViewController

- (IBAction) playYouTubeVideo:(id)sender
{
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithYouTubeVideoIdentifier:self.videoIdentifierTextField.text];
	[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
}

@end
