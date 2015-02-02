//
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import "MPMoviePlayerController+BackgroundPlayback.h"

#import <objc/runtime.h>

#ifndef NSFoundationVersionNumber_iOS_7_0
#define NSFoundationVersionNumber_iOS_7_0 1047.2
#endif

@implementation MPMoviePlayerController (BackgroundPlayback)

+ (void) load
{
	// On iOS 7, working with playerLayer.player as documented in Technical Q&A QA1668 works fine.
	// On iOS 5 and 6, setting playerLayer.player to nil is not enough for background playback when locking the device, the `PlayVideoInBackground` user default must be used instead.
	if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_0)
		return;
	
	dispatch_async(dispatch_get_main_queue(), ^{
		// Register for these notifications as early as possible in order to be called before -[MPAVController _applicationWillResignActive:] which calls `_pausePlaybackIfNecessary`.
		NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
		[defaultCenter addObserver:self selector:@selector(backgroundPlayback_moviePlayerNowPlayingMovieDidChange:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
		[defaultCenter addObserver:self selector:@selector(backgroundPlayback_moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
		[defaultCenter addObserver:self selector:@selector(backgroundPlayback_applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
		[defaultCenter addObserver:self selector:@selector(backgroundPlayback_applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
	});
}

static const void * const BackgroundPlaybackEnabledKey = &BackgroundPlaybackEnabledKey;

- (BOOL) isBackgroundPlaybackEnabled
{
	return [objc_getAssociatedObject(self, BackgroundPlaybackEnabledKey) boolValue];
}

- (void) setBackgroundPlaybackEnabled:(BOOL)backgroundPlaybackEnabled
{
	if (backgroundPlaybackEnabled)
	{
		NSArray *backgroundModes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIBackgroundModes"];
		if (!backgroundModes || ([backgroundModes isKindOfClass:[NSArray class]] && ![backgroundModes containsObject:@"audio"]))
			NSLog(@"ERROR: The `UIBackgroundModes` array in the application Info.plist file must contain the `audio` element for background playback.");
	}
	
	objc_setAssociatedObject(self, BackgroundPlaybackEnabledKey, @(backgroundPlaybackEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static __weak MPMoviePlayerController *currentMoviePlayerController;

+ (void) backgroundPlayback_moviePlayerNowPlayingMovieDidChange:(NSNotification *)notification
{
	currentMoviePlayerController = notification.object;
}

+ (void) backgroundPlayback_moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
	currentMoviePlayerController = nil;
}

__attribute__((overloadable))
static AVPlayerLayer * PlayerLayer(void)
{
	// When an inline movie player controller goes fullscreen, its view is somehow transferred to the key window.
	return PlayerLayer(currentMoviePlayerController.view) ?: PlayerLayer([[UIApplication sharedApplication] keyWindow]);
}

// Since MPMoviePlayerController doesn't expose its AVFoundation internals, traversing its subviews is the least worst solution to access its AVPlayerLayer.
// See Technical Q&A QA1668 - Playing media while in the background using AV Foundation on iOS https://developer.apple.com/library/ios/qa/qa1668/_index.html
__attribute__((overloadable))
static AVPlayerLayer * PlayerLayer(UIView *view)
{
	AVPlayerLayer *playerLayer = nil;
	if ([view.layer isKindOfClass:[AVPlayerLayer class]])
	{
		playerLayer = (AVPlayerLayer *)view.layer;
	}
	else
	{
		for (UIView *subview in view.subviews)
		{
			playerLayer = PlayerLayer(subview);
			if (playerLayer)
				break;
		}
	}
	return playerLayer;
}

static const void * const PlayerKey = &PlayerKey;

+ (void) backgroundPlayback_applicationWillResignActive:(NSNotification *)notification
{
	if (!currentMoviePlayerController)
		return;
	
	AVPlayerLayer *playerLayer = PlayerLayer();
	objc_setAssociatedObject(currentMoviePlayerController, PlayerKey, playerLayer.player, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	if (currentMoviePlayerController.isBackgroundPlaybackEnabled)
	{
		if (![[[AVAudioSession sharedInstance] category] isEqualToString:AVAudioSessionCategoryPlayback])
			NSLog(@"ERROR: The audio session category must be `AVAudioSessionCategoryPlayback` when background playback is enabled.");
		
		playerLayer.player = nil;
	}
}

+ (void) backgroundPlayback_applicationDidBecomeActive:(NSNotification *)notification
{
	AVPlayerLayer *playerLayer = PlayerLayer();
	playerLayer.player = objc_getAssociatedObject(currentMoviePlayerController, PlayerKey);
}

@end
