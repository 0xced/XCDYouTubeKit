//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "AppDelegate.h"

#import <CocoaLumberjack/CocoaLumberjack.h>

@implementation AppDelegate

@synthesize window = _window;

- (instancetype) init
{
	if (!(self = [super init]))
		return nil;
	
	_playerEventLogger = [PlayerEventLogger new];
	_nowPlayingInfoCenterProvider = [NowPlayingInfoCenterProvider new];
	
	return self;
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"VideoIdentifier": @"EdeVaT-zZt4" }];
	
	DDTTYLogger *ttyLogger = [DDTTYLogger sharedInstance];
	ttyLogger.colorsEnabled = YES;
	char *logLevelString = getenv("DDTTYLoggerLevel");
	DDLogLevel logLevel = logLevelString ? strtoul(logLevelString, NULL, 0) : DDLogLevelWarning;
	[DDLog addLogger:ttyLogger withLevel:logLevel];
	 
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
	
	return YES;
}

@end
