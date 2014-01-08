//
//  SettingsViewController.m
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 31.12.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import "SettingsViewController.h"

#import <AVFoundation/AVFoundation.h>

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
	NSError *error = nil;
	BOOL success = [[AVAudioSession sharedInstance] setCategory:category error:&error];
	if (success)
		self.audioSessionCategoryLabel.text = [[AVAudioSession sharedInstance] category];
	else
		NSLog(@"Audio Session Category error: %@", error);
}

- (IBAction) done:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
