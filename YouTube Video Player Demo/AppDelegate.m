//
//  AppDelegate.m
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import "AppDelegate.h"

#import "DemoViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = [DemoViewController new];
	[self.window makeKeyAndVisible];
	return YES;
}

@end
