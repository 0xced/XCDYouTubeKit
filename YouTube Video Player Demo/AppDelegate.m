//
//  AppDelegate.m
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"VideoIdentifier": @"9bZkp7q19f0" }];
	
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	[defaultCenter addObserver:self selector:@selector(videoPlayerViewControllerDidReceiveMetadata:) name:XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification object:nil];
	[defaultCenter addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
	[defaultCenter addObserver:self selector:@selector(moviePlayerPlaybackStateDidChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
	[defaultCenter addObserver:self selector:@selector(moviePlayerLoadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
	
	UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
	navigationBarAppearance.titleTextAttributes = @{ UITextAttributeFont: [UIFont boldSystemFontOfSize:17] };
	UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
	UIBarButtonItem *settingsButtonItem = navigationController.topViewController.navigationItem.rightBarButtonItem;
	[settingsButtonItem setTitleTextAttributes:@{ UITextAttributeFont: [UIFont boldSystemFontOfSize:26] } forState:UIControlStateNormal];
	
	return YES;
}

#pragma mark - Notifications

- (void) moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
	MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
	NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
	NSString *reason = @"Unknown";
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
	NSLog(@"Finish Reason: %@%@", reason, error ? [@"\n" stringByAppendingString:[error description]] : @"");
}

- (void) moviePlayerPlaybackStateDidChange:(NSNotification *)notification
{
	MPMoviePlayerController *moviePlayerController = notification.object;
	NSString *playbackState = @"Unknown";
	switch (moviePlayerController.playbackState)
	{
		case MPMoviePlaybackStateStopped:
			playbackState = @"Stopped";
			break;
		case MPMoviePlaybackStatePlaying:
			playbackState = @"Playing";
			break;
		case MPMoviePlaybackStatePaused:
			playbackState = @"Paused";
			break;
		case MPMoviePlaybackStateInterrupted:
			playbackState = @"Interrupted";
			break;
		case MPMoviePlaybackStateSeekingForward:
			playbackState = @"Seeking Forward";
			break;
		case MPMoviePlaybackStateSeekingBackward:
			playbackState = @"Seeking Backward";
			break;
	}
	NSLog(@"Playback State: %@", playbackState);
}

- (void) moviePlayerLoadStateDidChange:(NSNotification *)notification
{
	MPMoviePlayerController *moviePlayerController = notification.object;
	
	NSMutableString *loadState = [NSMutableString new];
	MPMovieLoadState state = moviePlayerController.loadState;
	if (state & MPMovieLoadStatePlayable)
		[loadState appendString:@" | Playable"];
	if (state & MPMovieLoadStatePlaythroughOK)
		[loadState appendString:@" | Playthrough OK"];
	if (state & MPMovieLoadStateStalled)
		[loadState appendString:@" | Stalled"];
	
	NSLog(@"Load State: %@", loadState.length > 0 ? [loadState substringFromIndex:3] : @"N/A");
}

- (void) videoPlayerViewControllerDidReceiveMetadata:(NSNotification *)notification
{
	NSLog(@"Metadata: %@", notification.userInfo);
}

@end
