//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeKitTestCase.h"

#import <XCDYouTubeKit/XCDYouTubeClient.h>

@interface XCDYouTubeProtectedVideosTestCase : XCDYouTubeKitTestCase
@end

@implementation XCDYouTubeProtectedVideosTestCase

- (void) testAgeRestrictedVideo
{
	XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"zKovmts2KSk" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
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

- (void) testProtectedVEVOVideo
{
	XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNotNil(video.largeThumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		{
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		}];
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testAgeRestrictedVEVOVideo
{
	XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"07FYdnEawAQ" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
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

- (void) testProtectedVideoWithDollarSignature
{
	XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNil(video.largeThumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		{
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		}];
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testProtectedVideoWithJavaScriptFunctionsInVarScope
{
	XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Ntn1-SocNiY" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNotNil(video.largeThumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		{
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		}];
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

// With Charles
//   * Enable SSL proxying for *.youtube.com
//   * Tools -> Black List... -> Add host:www.youtube.com and path:watch to simulate connection error on the web page
- (void) testProtectedVideoWithWebPageConnectionError_offline
{
	XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video contains content from WMG. It is restricted from playback on certain sites. Watch on YouTube");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

// With Charles: Tools -> Black List... -> Add `s.ytimg.com` to simulate connection error on the player script
- (void) testProtectedVideoWithPlayerScriptConnectionError_offline
{
	XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video contains content from WMG. It is restricted from playback on certain sites. Watch on YouTube");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

// Edit testProtectedVideoWithoutSignatureFunction.json by replacing `signature=` with `signaturX=`
- (void) testProtectedVideoWithoutSignatureFunction_offline
{
	XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video contains content from WMG. It is restricted from playback on certain sites. Watch on YouTube");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

// Edit testProtectedVideoWithBrokenSignatureFunction.json by returning null in the signature function
- (void) testProtectedVideoWithBrokenSignatureFunction_offline
{
	XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video contains content from WMG. It is restricted from playback on certain sites. Watch on YouTube");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

// Edit testProtectedVideoWithoutJavaScriptPlayerURL.json by replacing `\"js\":` with `\"xs\":`
- (void) testProtectedVideoWithoutJavaScriptPlayerURL_offline
{
	XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video contains content from WMG. It is restricted from playback on certain sites. Watch on YouTube");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
