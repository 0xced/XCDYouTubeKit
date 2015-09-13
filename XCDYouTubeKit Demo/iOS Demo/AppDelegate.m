//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "AppDelegate.h"

#import "ContextLogFormatter.h"
#import <XCDLumberjackNSLogger/XCDLumberjackNSLogger.h>

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

static void InitializeLoggers(void)
{
	DDTTYLogger *ttyLogger = [DDTTYLogger sharedInstance];
	DDLogLevel defaultLogLevel = LogLevelForEnvironmentVariable(@"DefaultLogLevel", DDLogLevelInfo);
	DDLogLevel youTubeLogLevel = LogLevelForEnvironmentVariable(@"XCDYouTubeLogLevel", DDLogLevelWarning);
	ttyLogger.logFormatter = [[ContextLogFormatter alloc] initWithLevels:@{ @((NSInteger)0xced70676) : @(youTubeLogLevel) } defaultLevel:defaultLogLevel];
	ttyLogger.colorsEnabled = YES;
	[DDLog addLogger:ttyLogger];
	
	NSString *bonjourServiceName = [[NSUserDefaults standardUserDefaults] objectForKey:@"NSLoggerBonjourServiceName"];
	XCDLumberjackNSLogger *logger = [[XCDLumberjackNSLogger alloc] initWithBonjourServiceName:bonjourServiceName];
	logger.tags = @{ @0: @"Movie Player", @((NSInteger)0xced70676) : @"XCDYouTubeKit" };
	[DDLog addLogger:logger];
}

static void InitializeUserDefaults(void)
{
	[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"VideoIdentifier": @"EdeVaT-zZt4" }];
}

static void InitializeAudioSession(void)
{
	NSString *category = [[NSUserDefaults standardUserDefaults] objectForKey:@"AudioSessionCategory"];
	if (category)
	{
		NSError *error = nil;
		BOOL success = [[AVAudioSession sharedInstance] setCategory:category error:&error];
		if (!success)
			NSLog(@"Audio Session Category error: %@", error);
	}
}

static void InitializeAppearance(UINavigationController *rootViewController)
{
	UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
	navigationBarAppearance.titleTextAttributes = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:17] };
	UIBarButtonItem *settingsButtonItem = rootViewController.topViewController.navigationItem.rightBarButtonItem;
	[settingsButtonItem setTitleTextAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:26] } forState:UIControlStateNormal];
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	InitializeLoggers();
	InitializeUserDefaults();
	InitializeAudioSession();
	InitializeAppearance((UINavigationController *)self.window.rootViewController);
	return YES;
}

@end
