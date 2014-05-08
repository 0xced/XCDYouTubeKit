//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UISwitch *playVideoInBackgroundSwitch;
@property (nonatomic, weak) IBOutlet UILabel *audioSessionCategoryLabel;

@end

@implementation SettingsViewController

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	self.playVideoInBackgroundSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"PlayVideoInBackground"];
	self.audioSessionCategoryLabel.text = [[AVAudioSession sharedInstance] category];
}

#pragma mark - Actions

- (IBAction) togglePlayVideoInBackground:(UISwitch *)sender
{
	/* Background video playback (i.e. audio playback since the video is not visible in background) requires:
	 *  1. The `UIBackgroundModes` array (Required background modes) in the application Info.plist file must contain the `audio` element (App plays audio or streams audio/video using AirPlay).
	 *  2. The audio session category must be set to `AVAudioSessionCategoryPlayback`
	 *  3. The undocumented `PlayVideoInBackground` user default used by the MediaPlayer framework must be true.
	 *
	 * - Audio playback works when locking the device on both iOS 6 and iOS 7. (Untested on iOS 5)
	 * - Audio playback works when quitting the app on iOS 6 only but stops on iOS 7. (Untested on iOS 5)
	 */
	[[NSUserDefaults standardUserDefaults] setBool:self.playVideoInBackgroundSwitch.on forKey:@"PlayVideoInBackground"];
}

- (IBAction) selectAudioSessionCategory:(UIButton *)sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Audio Session Category", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Solo Ambient", nil), NSLocalizedString(@"Playback", nil), nil];
	[actionSheet showFromRect:[sender frame] inView:[sender superview] animated:YES];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == actionSheet.cancelButtonIndex)
		return;
	
	NSString *category = @[AVAudioSessionCategorySoloAmbient, AVAudioSessionCategoryPlayback][buttonIndex];
	[[NSUserDefaults standardUserDefaults] setObject:category forKey:@"AudioSessionCategory"];
	
	NSError *error = nil;
	BOOL success = [[AVAudioSession sharedInstance] setCategory:category error:&error];
	if (success)
		self.audioSessionCategoryLabel.text = [[AVAudioSession sharedInstance] category];
	else
		NSLog(@"Audio Session Category error: %@", error);
}

- (IBAction) done:(id)sender
{
	[[NSUserDefaults standardUserDefaults] synchronize];
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
