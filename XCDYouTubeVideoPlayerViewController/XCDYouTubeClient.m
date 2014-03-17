//
//  XCDYouTubeClient.m
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Cédric Luthi on 17.03.14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeClient.h"

@implementation XCDYouTubeClient

+ (instancetype) sharedClient
{
	static XCDYouTubeClient *sharedClient;
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		sharedClient = [self new];
	});
	return sharedClient;
}

- (id<XCDYouTubeOperation>) getVideoWithIdentifier:(NSString *)videoIdentifier completionHandler:(void (^)(XCDYouTubeVideo *video, NSError *error))completionHandler
{
	return nil;
}

@end
