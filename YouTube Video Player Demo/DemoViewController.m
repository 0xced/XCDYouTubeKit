//
//  ViewController.m
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import "DemoViewController.h"

#import "XCDYouTubeVideoPlayerViewController.h"

@interface DemoViewController () <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *videoIdentifierTextField;
@property (nonatomic, weak) IBOutlet UISwitch *lowQualitySwitch;
@end

@implementation DemoViewController

- (id) initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
	if (!(self = [super initWithNibName:nibName bundle:nibBundle]))
		return nil;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *) title
{
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

- (IBAction) playYouTubeVideo:(id)sender
{
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:self.videoIdentifierTextField.text];
	if (self.lowQualitySwitch.on)
		videoPlayerViewController.preferredVideoQuality = @[ @(XCDYouTubeVideoQualitySmall240), @(XCDYouTubeVideoQualityMedium360) ];
	[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
	[self playYouTubeVideo:textField];
	return YES;
}

#pragma mark - Notifications

- (void) moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
	MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
	NSString *reason = @"Unknown Reason";
	switch (finishReason)
	{
		case MPMovieFinishReasonPlaybackEnded:
			reason = @"Playback Ended";
			break;
		case MPMovieFinishReasonPlaybackError:
			reason = @"Playback Error";
			break;
		case MPMovieFinishReasonUserExited:
			reason = @"User Exited";
			break;
	}
	NSLog(@"moviePlayerPlaybackDidFinish: %@", reason);
}

@end
