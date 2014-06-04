//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "DemoFullScreenViewController.h"

@implementation DemoFullScreenViewController

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	self.videoIdentifierTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"VideoIdentifier"];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.view endEditing:YES];
}

- (IBAction) play:(id)sender
{
	[self.view endEditing:YES];
	
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:self.videoIdentifierTextField.text];
	videoPlayerViewController.moviePlayer.backgroundPlaybackEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlayVideoInBackground"];
	videoPlayerViewController.preferredVideoQualities = self.lowQualitySwitch.on ? @[ @(XCDYouTubeVideoQualitySmall240), @(XCDYouTubeVideoQualityMedium360) ] : nil;
	[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
	[self play:textField];
	return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
	[[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"VideoIdentifier"];
}

@end
