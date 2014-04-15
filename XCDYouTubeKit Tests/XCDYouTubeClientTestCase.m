//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <XCDYouTubeKit/XCDYouTubeClient.h>

#import "TRVSMonitor.h"

@interface XCDYouTubeClientTestCase : XCTestCase
@end

@implementation XCDYouTubeClientTestCase

- (void) testThatVideoIsAvailalbeOnDetailPageEventLabel
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"9bZkp7q19f0" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(video);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testThatGangnamStyleVideoHasMetadata
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"9bZkp7q19f0" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(error);
		XCTAssertEqualObjects(video.identifier, @"9bZkp7q19f0");
		XCTAssertEqualObjects(video.title, @"PSY - GANGNAM STYLE (\U0000ac15\U0000b0a8\U0000c2a4\U0000d0c0\U0000c77c) M/V");
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNotNil(video.largeThumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testRestrictedVideo
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"1kIsylLeHHU" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testRemovedVideo
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"BXnA9FjvLSU" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRemovedVideo);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testInvalidVideoIdentifier
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"tooShort" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorInvalidVideoIdentifier);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testNilVideoIdentifier
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient new] getVideoWithIdentifier:nil completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorInvalidVideoIdentifier);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testUsingClientOnNonMainThread
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		XCTAssertFalse([NSThread isMainThread]);
		[[XCDYouTubeClient new] getVideoWithIdentifier:@"9bZkp7q19f0" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
			XCTAssertTrue([NSThread isMainThread]);
			[monitor signal];
		}];
	});
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testCancelingOperation
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	id<XCDYouTubeOperation> operation = [[XCDYouTubeClient new] getVideoWithIdentifier:@"9bZkp7q19f0" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTFail();
	}];
	[operation cancel];
	XCTAssertFalse([monitor waitWithTimeout:1]);
}

- (void) testNilCompletionHandler
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
	XCTAssertThrowsSpecificNamed([[XCDYouTubeClient new] getVideoWithIdentifier:@"9bZkp7q19f0" completionHandler:nil], NSException, NSInvalidArgumentException);
#pragma clang diagnostic pop
}

@end
