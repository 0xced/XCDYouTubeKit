//
//  XCDYouTubeVideoPlayerViewController_Tests.m
//  XCDYouTubeVideoPlayerViewController Tests
//
//  Created by Cédric Luthi on 11.01.14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TRVSMonitor.h"
#import "XCDYouTubeVideoPlayerViewController.h"

@interface XCDYouTubeVideoPlayerViewController_Tests : XCTestCase

@property TRVSMonitor *monitor;

@end

@implementation XCDYouTubeVideoPlayerViewController_Tests

+ (void) initialize
{
	if (self != [XCDYouTubeVideoPlayerViewController_Tests class])
		return;
	
	// See http://stackoverflow.com/questions/21069515/avurlasset-isplayableextendedmimetype-behaves-differently-when-unit-tested/21081159#21081159
	setenv("IPHONE_SIMULATOR_CLASS", "N41", 0);
}

- (void) setUp
{
	[super setUp];
	self.monitor = [TRVSMonitor new];
}

- (void) tearDown
{
	self.monitor = nil;
	[super tearDown];
}

- (void) testThatGangnamStyleVideoHasURL
{
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"9bZkp7q19f0"];
	[videoPlayerViewController addObserver:self forKeyPath:@"moviePlayer.contentURL" options:(NSKeyValueObservingOptions)0 context:_cmd];
	[self.monitor waitWithTimeout:10];
	XCTAssertNotNil(videoPlayerViewController.moviePlayer.contentURL, @"");
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context == @selector(testThatGangnamStyleVideoHasURL))
	{
		[self.monitor signal];
		[object removeObserver:self forKeyPath:keyPath context:context];
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

@end
