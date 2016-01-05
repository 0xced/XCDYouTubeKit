//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "PlayerEventLogger.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
@import MediaPlayer;

@implementation PlayerEventLogger

- (instancetype) init
{
	if (!(self = [super init]))
		return nil;
	
	self.enabled = YES;
	
	return self;
}

- (void) setEnabled:(BOOL)enabled
{
	if (_enabled == enabled)
		return;
	
	_enabled = enabled;
	
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	if (enabled)
	{
		[defaultCenter addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
		[defaultCenter addObserver:self selector:@selector(moviePlayerPlaybackStateDidChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
		[defaultCenter addObserver:self selector:@selector(moviePlayerLoadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
		[defaultCenter addObserver:self selector:@selector(moviePlayerNowPlayingMovieDidChange:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
	}
	else
	{
		[defaultCenter removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
		[defaultCenter removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
		[defaultCenter removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
		[defaultCenter removeObserver:self name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
	}
}

- (void) moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
	MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
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
	DDLogInfo(@"Finish Reason: %@", reason);
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
	DDLogInfo(@"Playback State: %@", playbackState);
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
	
	DDLogInfo(@"Load State: %@", loadState.length > 0 ? [loadState substringFromIndex:3] : @"N/A");
}

- (void) moviePlayerNowPlayingMovieDidChange:(NSNotification *)notification
{
	MPMoviePlayerController *moviePlayerController = notification.object;
	DDLogInfo(@"Now Playing %@", moviePlayerController.contentURL);
}

@end
