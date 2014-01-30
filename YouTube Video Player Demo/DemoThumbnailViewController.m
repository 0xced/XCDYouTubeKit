//
//  DemoThumbnailViewController.m
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 26.09.13.
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "DemoThumbnailViewController.h"

@interface DemoThumbnailViewController ()

@property (nonatomic, strong) XCDYouTubeVideoPlayerViewController *videoPlayerViewController;

@end

@implementation DemoThumbnailViewController

- (IBAction) loadThumbnail:(id)sender
{
	self.videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"VpZmIiIXuZ0"];
	
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	[defaultCenter addObserver:self selector:@selector(videoPlayerViewControllerDidReceiveMetadata:) name:XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification object:self.videoPlayerViewController];
	[defaultCenter addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.videoPlayerViewController.moviePlayer];
}

- (IBAction) play:(id)sender
{
	[self.videoPlayerViewController presentInView:self.videoContainerView];
	[self.videoPlayerViewController.moviePlayer play];
}

#pragma mark - Notifications

- (void) videoPlayerViewControllerDidReceiveMetadata:(NSNotification *)notification
{
	self.titleLabel.text = notification.userInfo[XCDMetadataKeyTitle];
	
	NSURL *thumbnailURL = notification.userInfo[XCDMetadataKeyMediumThumbnailURL] ?: notification.userInfo[XCDMetadataKeySmallThumbnailURL];
	[NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:thumbnailURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		self.thumbnailImageView.image = [UIImage imageWithData:data];
		
		[self.actionButton setTitle:NSLocalizedString(@"Play Video", nil) forState:UIControlStateNormal];
		[self.actionButton removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];
		[self.actionButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
	}];
}

- (void) moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
	NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
	if (error)
	{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:error.localizedDescription delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
		[alertView show];
	}
}

@end
