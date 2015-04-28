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
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"zKovmts2KSk" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.expirationDate);
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

- (void) testAgeRestrictedUnratedVideo
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"KGZzuVNwJHY" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.expirationDate);
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

- (void) testProtectedVEVOVideo1
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.expirationDate);
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

- (void) testProtectedVEVOVideo2
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
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

- (void) testProtectedVEVOVideo3
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Ntn1-SocNiY" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.expirationDate);
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

- (void) testProtectedVEVOIsPlayable
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"tg00YEETFzg" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNotNil(video.largeThumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:video.streamURLs[@(XCDYouTubeVideoQualityHD720)]];
		request.HTTPMethod = @"HEAD";
		[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
		{
			XCTAssertEqual([(NSHTTPURLResponse *)response statusCode], 200);
			[expectation fulfill];
		}];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testAgeRestrictedVEVOVideo
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"07FYdnEawAQ" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.expirationDate);
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
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
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
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
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

// Edit testProtectedVideoWithoutSignatureFunction.json by replacing `\"signature\",` with `\"signaturX\",`
- (void) testProtectedVideoWithoutSignatureFunction_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
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
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
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
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
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

// With Charles: Tools -> Black List... -> Add host:www.youtube.com and path:embed/* to simulate connection error on the web page
- (void) testAgeRestrictedVEVOVideoWithEmbedWebPageConnectionError_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"07FYdnEawAQ" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"Sign in to confirm your age");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
