//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "AppDelegate.h"

#import "ContextLogFormatter.h"

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

static DDLogLevel LogLevelForEnvironmentVariable(NSString *levelEnvironment, DDLogLevel defaultLogLevel)
{
	NSString *logLevelString = [[[NSProcessInfo processInfo] environment] objectForKey:levelEnvironment];
	return logLevelString ? strtoul(logLevelString.UTF8String, NULL, 0) : defaultLogLevel;
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"VideoIdentifier": @"EdeVaT-zZt4" }];
	
	DDTTYLogger *ttyLogger = [DDTTYLogger sharedInstance];
	DDLogLevel defaultLogLevel = LogLevelForEnvironmentVariable(@"DefaultLogLevel", DDLogLevelInfo);
	DDLogLevel youTubeLogLevel = LogLevelForEnvironmentVariable(@"XCDYouTubeLogLevel", DDLogLevelWarning);
	ttyLogger.logFormatter = [[ContextLogFormatter alloc] initWithLevels:@{ @((NSInteger)0xced70676) : @(youTubeLogLevel) } defaultLevel:defaultLogLevel];
	ttyLogger.colorsEnabled = YES;
	[DDLog addLogger:ttyLogger];
	 
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
