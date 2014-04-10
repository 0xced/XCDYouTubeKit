//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TRVSMonitor.h"
#import <XCDYouTubeKit/XCDYouTubeVideoPlayerViewController.h>
#import <XCDYouTubeKit/XCDYouTubeClient.h>
#import <XCDYouTubeKit/XCDYouTubeError.h>
#import <XCDYouTubeKit/XCDYouTubeVideo.h>

@interface XCDYouTubeClient_Tests : XCTestCase

@property TRVSMonitor *monitor;

@end

@implementation XCDYouTubeClient_Tests

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

- (void) testThatVideoIsAvailalbeOnDetailPageEventLabel
{
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"9bZkp7q19f0" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(video);
		[self.monitor signal];
	}];
	XCTAssertTrue([self.monitor waitWithTimeout:10]);
}

- (void) testThatGangnamStyleVideoHasMetadata
{
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"9bZkp7q19f0" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(error);
		XCTAssertEqualObjects(video.identifier, @"9bZkp7q19f0");
		XCTAssertEqualObjects(video.title, @"PSY - GANGNAM STYLE (\U0000ac15\U0000b0a8\U0000c2a4\U0000d0c0\U0000c77c) M/V");
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNotNil(video.largeThumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		[self.monitor signal];
	}];
	XCTAssertTrue([self.monitor waitWithTimeout:10]);
}

- (void) testRestrictedVideo
{
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"1kIsylLeHHU" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		[self.monitor signal];
	}];
	XCTAssertTrue([self.monitor waitWithTimeout:10]);
}

- (void) testRemovedVideo
{
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"BXnA9FjvLSU" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRemovedVideo);
		[self.monitor signal];
	}];
	XCTAssertTrue([self.monitor waitWithTimeout:10]);
}

- (void) testInvalidVideoIdentifier
{
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"tooShort" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorInvalidVideoIdentifier);
		[self.monitor signal];
	}];
	XCTAssertTrue([self.monitor waitWithTimeout:10]);
}

- (void) testNilVideoIdentifier
{
	[[XCDYouTubeClient new] getVideoWithIdentifier:nil completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorInvalidVideoIdentifier);
		[self.monitor signal];
	}];
	XCTAssertTrue([self.monitor waitWithTimeout:10]);
}

- (void) testWrongInitializer
{
	XCTAssertThrowsSpecificNamed([[XCDYouTubeVideoPlayerViewController alloc] initWithContentURL:nil], NSException, NSGenericException);
}

- (void) testUsingClientOnNonMainThread
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		XCTAssertFalse([NSThread isMainThread]);
		[[XCDYouTubeClient new] getVideoWithIdentifier:@"9bZkp7q19f0" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
			XCTAssertTrue([NSThread isMainThread]);
			[self.monitor signal];
		}];
	});
	XCTAssertTrue([self.monitor waitWithTimeout:10]);
}

- (void) testCancelingOperation
{
	id<XCDYouTubeOperation> operation = [[XCDYouTubeClient new] getVideoWithIdentifier:@"9bZkp7q19f0" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTFail();
	}];
	[operation cancel];
	XCTAssertFalse([self.monitor waitWithTimeout:1]);
}

- (void) testNilCompletionHandler
{
	XCTAssertThrowsSpecificNamed([[XCDYouTubeClient new] getVideoWithIdentifier:@"9bZkp7q19f0" completionHandler:nil], NSException, NSInvalidArgumentException);
}

@end
