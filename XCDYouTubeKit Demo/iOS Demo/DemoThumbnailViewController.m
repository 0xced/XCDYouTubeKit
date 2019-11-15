//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "DemoThumbnailViewController.h"

#import <XCDYouTubeKit/XCDYouTubeKit.h>

#import <AVKit/AVKit.h>

#import "XCDYouTubeKit_iOS_Demo-Swift.h"

@interface DemoThumbnailViewController ()

@property (nonatomic, strong) XCDYouTubeVideo *video;

@end

@implementation DemoThumbnailViewController

- (IBAction) loadThumbnail:(id)sender
{
	NSString *videoIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"VideoIdentifier"];
	
	[[XCDYouTubeClient defaultClient]getVideoWithIdentifier:videoIdentifier completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error)
	{
		if (error) {
			[[Utilities shared]displayError:error originViewController:self];
			return;
		}
		
		[self displayThumbnailWithVideo:video];
		
	}];
}

- (IBAction) play:(id)sender
{
	[AVPlayerViewControllerManager shared].video = self.video;
	AVPlayerViewController *playerViewController = [AVPlayerViewControllerManager shared].controller;
	[self presentViewController:playerViewController animated:YES completion:nil];
	[playerViewController.player play];
}

- (void) displayThumbnailWithVideo:(XCDYouTubeVideo *)video
{
	self.video = video;
	self.titleLabel.text = video.title;
	NSURL *thumbnailURL = video.thumbnailURL;

	[[[NSURLSession sharedSession]dataTaskWithURL:thumbnailURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
	  {
		if (error) {
			[[Utilities shared]displayError:error originViewController:self];
			return;
		}
		
		[[NSOperationQueue mainQueue]addOperationWithBlock:^{
			self.thumbnailImageView.image = [UIImage imageWithData:data];
			[self.actionButton setTitle:NSLocalizedString(@"Play Video", nil) forState:UIControlStateNormal];
			[self.actionButton removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];
			[self.actionButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
		}];
		
	}] resume];
}

@end
