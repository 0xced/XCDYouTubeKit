//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "MoviePlayerOverlayViewProvider.h"

#import "MPMoviePlayerController+OverlayView.h"

@implementation MoviePlayerOverlayViewProvider

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
		[defaultCenter addObserver:self selector:@selector(videoPlayerViewControllerDidReceiveVideo:) name:XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification object:nil];
	else
		[defaultCenter removeObserver:self name:XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification object:nil];
}

- (void) videoPlayerViewControllerDidReceiveVideo:(NSNotification *)notification
{
	XCDYouTubeVideo *video = notification.userInfo[XCDYouTubeVideoUserInfoKey];
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = notification.object;
	
	const CGFloat horizontalMargin = 10;
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(horizontalMargin, 0, CGRectGetWidth(videoPlayerViewController.moviePlayer.view.frame) - (2 * horizontalMargin), 50)];
	label.text = video.title;
	label.font = [UIFont boldSystemFontOfSize:18];
	label.minimumFontSize = 12;
	label.adjustsFontSizeToFitWidth = YES;
	label.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
	label.textAlignment = NSTextAlignmentCenter;
	label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	label.numberOfLines = 2;
	label.shadowColor = UIColor.blackColor;
	label.shadowOffset = CGSizeMake(1, 1);
	
	videoPlayerViewController.moviePlayer.overlayView_xcd = label;
}

@end
