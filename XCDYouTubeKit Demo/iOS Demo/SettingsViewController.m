//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "SettingsViewController.h"

@import AVFoundation;

@interface SettingsViewController () <UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UILabel *audioSessionCategoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *versionLabel;

@end

@implementation SettingsViewController

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	if (@available(iOS 13.0, *)) {
		self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
	}
	
	self.audioSessionCategoryLabel.text = [[AVAudioSession sharedInstance] category];
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"ch.pitaya.xcdyoutubekit"];
	self.versionLabel.text = [NSString stringWithFormat:@"Version %@ (%@)", [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"], [bundle objectForInfoDictionaryKey:@"CFBundleVersion"]];
}

#pragma mark - Actions

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
