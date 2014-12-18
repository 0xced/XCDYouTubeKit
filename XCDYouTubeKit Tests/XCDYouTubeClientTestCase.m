//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeKitTestCase.h"

#import <XCDYouTubeKit/XCDYouTubeClient.h>

@interface XCDYouTubeClientTestCase : XCDYouTubeKitTestCase
@end

@implementation XCDYouTubeClientTestCase

- (void) testThatVideoIsAvailalbeOnDetailPageEventLabel
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"dQw4w9WgXcQ" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testThatVideoHasMetadata
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"9TTioMbNT9I" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertEqualObjects(video.identifier, @"9TTioMbNT9I");
		XCTAssertEqualObjects(video.title, @"Super Mario Bros Theme Song on Wine Glasses and a Frying Pan (슈퍼 마리오 브라더스 - スーパーマリオブラザーズ - 超級瑪莉)");
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNotNil(video.largeThumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testMobileRestrictedVideo
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"JHaA9bKi-xs" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNotNil(video.largeThumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop) {
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		}];
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testLiveVideo_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"xrM34fdmloc" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNil(video.expirationDate);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNotNil(video.largeThumbnailURL);
		XCTAssertEqual(video.streamURLs.count, 1U);
		XCTAssertTrue(video.duration > 0);
		XCTAssertNotNil(video.streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming]);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void) testDVRVideo
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"H7iQ4sAf0OE" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNil(video.expirationDate);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNotNil(video.largeThumbnailURL);
		XCTAssertEqual(video.streamURLs.count, 1U);
		XCTAssertTrue(video.duration > 0);
		XCTAssertNotNil(video.streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming]);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testRestrictedVideo
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"1kIsylLeHHU" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video is currently unavailable. We are working to bring it back.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testRemovedVideo
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"BXnA9FjvLSU" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRemovedVideo);
		XCTAssertEqualObjects(error.localizedDescription, @"\"9/11 The F...\" This video is no longer available due to a copyright claim by Digital Rights Group Ltd.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testGeoblockedVideo
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"vwkFTztnl7Y" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"The uploader has not made this video available in your country.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testInvalidVideoIdentifier
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"tooShort" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorInvalidVideoIdentifier);
		XCTAssertEqualObjects(error.localizedDescription, @"Invalid parameters.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testNonExistentVideoIdentifier
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"xxxxxxxxxxx" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRemovedVideo);
		XCTAssertEqualObjects(error.localizedDescription, @"This video does not exist.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testFrenchClient
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[[XCDYouTubeClient alloc] initWithLanguageIdentifier:@"fr"] getVideoWithIdentifier:@"xxxxxxxxxxx" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRemovedVideo);
		XCTAssertEqualObjects(error.localizedDescription, @"Cette vidéo n'existe pas.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testNilVideoIdentifier
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:nil completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorInvalidVideoIdentifier);
		XCTAssertEqualObjects(error.localizedDescription, @"Invalid parameters.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testSpaceVideoIdentifier
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@" " completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorInvalidVideoIdentifier);
		XCTAssertEqualObjects(error.localizedDescription, @"Invalid parameters.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

// Disable internet connection before running
- (void) testConnectionError_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"EdeVaT-zZt4" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorNetwork);
		XCTAssertEqualObjects(error.localizedDescription, @"The Internet connection appears to be offline.");
		NSError *underlyingError = error.userInfo[NSUnderlyingErrorKey];
		XCTAssertEqualObjects(underlyingError.domain, NSURLErrorDomain);
		XCTAssertEqual(underlyingError.code, NSURLErrorNotConnectedToInternet);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void) testUsingClientOnNonMainThread
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		XCTAssertFalse([NSThread isMainThread]);
		[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"EdeVaT-zZt4" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
		{
			XCTAssertTrue([NSThread isMainThread]);
			[expectation fulfill];
		}];
	});
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testCancelingOperation
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	id<XCDYouTubeOperation> operation = [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"EdeVaT-zZt4" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTFail();
	}];
	[expectation performSelector:@selector(fulfill) withObject:nil afterDelay:0.2];
	[operation cancel];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void) testNilCompletionHandler
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
	XCTAssertThrowsSpecificNamed([[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"EdeVaT-zZt4" completionHandler:nil], NSException, NSInvalidArgumentException);
#pragma clang diagnostic pop
}

@end
