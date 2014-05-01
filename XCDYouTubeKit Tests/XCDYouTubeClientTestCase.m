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
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"dQw4w9WgXcQ" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(video);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testThatVideoHasMetadata
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient new] getVideoWithIdentifier:@"9TTioMbNT9I" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(error);
		XCTAssertEqualObjects(video.identifier, @"9TTioMbNT9I");
		XCTAssertEqualObjects(video.title, @"Super Mario Bros Theme Song on Wine Glasses and a Frying Pan (슈퍼 마리오 브라더스 - スーパーマリオブラザーズ - 超級瑪莉)");
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
