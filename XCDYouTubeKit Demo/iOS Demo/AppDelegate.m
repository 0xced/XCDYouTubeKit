//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "AppDelegate.h"

#import "PlayerEventLogger.h"
#import "NowPlayingInfoCenterProvider.h"

@interface AppDelegate ()

@property (nonatomic, strong) PlayerEventLogger *playerEventLogger;
@property (nonatomic, strong) NowPlayingInfoCenterProvider *nowPlayingInfoCenterProvider;

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
	
	self.playerEventLogger = [PlayerEventLogger new];
	self.nowPlayingInfoCenterProvider = [NowPlayingInfoCenterProvider new];
	
	return YES;
}

@end
