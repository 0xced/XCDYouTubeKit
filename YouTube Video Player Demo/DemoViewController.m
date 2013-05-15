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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackStateDidChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerLoadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
	
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

- (void) viewDidLoad
{
	self.videoIdentifierTextField.superview.layer.cornerRadius = 10.f;
}

- (IBAction) playYouTubeVideo:(id)sender
{
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:self.videoIdentifierTextField.text];
	if (self.lowQualitySwitch.on)
		videoPlayerViewController.preferredVideoQuality = @[ @(XCDYouTubeVideoQualitySmall240), @(XCDYouTubeVideoQualityMedium360) ];
	[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
}

- (IBAction) playTrendingVideo:(id)sender
{
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [XCDYouTubeVideoPlayerViewController new];
	[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
	
	// https://developers.google.com/youtube/2.0/developers_guide_protocol_video_feeds#Standard_feeds
	NSURL *url = [NSURL URLWithString:@"https://gdata.youtube.com/feeds/api/standardfeeds/on_the_web?v=2&alt=json&max-results=1"];
	[NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		id json = [NSJSONSerialization JSONObjectWithData:data ?: [NSData new] options:0 error:NULL];
		NSString *videoIdentifier = [[[json valueForKeyPath:@"feed.entry.media$group.yt$videoid.$t"] lastObject] description];
		videoPlayerViewController.videoIdentifier = videoIdentifier;
	}];
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

@end
