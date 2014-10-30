//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "AppDelegate.h"

#import "PlayerEventLogger.h"

@interface AppDelegate ()

@property (nonatomic, strong) PlayerEventLogger *playerEventLogger;

@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"VideoIdentifier": @"EdeVaT-zZt4" }];
	
	NSString *category = [[NSUserDefaults standardUserDefaults] objectForKey:@"AudioSessionCategory"];
	if (category)
	{
		NSError *error = nil;
		BOOL success = [[AVAudioSession sharedInstance] setCategory:category error:&error];
		if (!success)
			NSLog(@"Audio Session Category error: %@", error);
	}
	
	UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
	navigationBarAppearance.titleTextAttributes = @{ UITextAttributeFont: [UIFont boldSystemFontOfSize:17] };
	UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
	UIBarButtonItem *settingsButtonItem = navigationController.topViewController.navigationItem.rightBarButtonItem;
	[settingsButtonItem setTitleTextAttributes:@{ UITextAttributeFont: [UIFont boldSystemFontOfSize:26] } forState:UIControlStateNormal];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerViewControllerDidReceiveVideo:) name:XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification object:nil];
	
	self.playerEventLogger = [PlayerEventLogger new];
	
	return YES;
}

#pragma mark - Notifications

- (void) videoPlayerViewControllerDidReceiveVideo:(NSNotification *)notification
{
	XCDYouTubeVideo *video = notification.userInfo[XCDYouTubeVideoUserInfoKey];
	NSString *title = video.title;
	if (title)
		[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = @{ MPMediaItemPropertyTitle: title };
	
	[NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:video.mediumThumbnailURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
	{
		if (data)
		{
			UIImage *image = [UIImage imageWithData:data];
			MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
			if (title && artwork)
				[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = @{ MPMediaItemPropertyTitle: title, MPMediaItemPropertyArtwork: artwork };
		}
	}];
}

@end
