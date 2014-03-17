//
//  XCDYouTubeVideoClient.m
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Cédric Luthi on 17.03.14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoClient.h"

@implementation XCDYouTubeVideoClient

+ (instancetype) sharedClient
{
	static XCDYouTubeVideoClient *sharedClient;
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		sharedClient = [self new];
	});
	return sharedClient;
}

- (void) getYouTubeVideoWithIdentifier:(NSString *)videoIdentifier completionHandler:(void (^)(XCDYouTubeVideo *video, NSError *error))completionHandler
{
	
}

@end
