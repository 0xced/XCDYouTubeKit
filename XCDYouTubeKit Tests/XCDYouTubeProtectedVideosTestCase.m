//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeKitTestCase.h"

#import <XCDYouTubeKit/XCDYouTubeClient.h>

@interface XCDYouTubeProtectedVideosTestCase : XCDYouTubeKitTestCase
extern NSArray <NSHTTPCookie *>* XCDYouTubeProtectedVideosAdultUserCookies(void);
extern NSArray <NSHTTPCookie *>* XCDYouTubeProtectedVideosMinorUserCookies(void);
@end

@implementation XCDYouTubeProtectedVideosTestCase

NSArray <NSHTTPCookie *>* XCDYouTubeProtectedVideosMinorUserCookies()
{
	NSURL *cookieURL = [[NSBundle bundleForClass:[XCDYouTubeProtectedVideosTestCase class]]URLForResource:@"minorUserCookieData" withExtension:nil subdirectory:@"Cookies"];
	
	NSCAssert(cookieURL != nil, @"Cookie data could not be found!");
	NSData *cookieData = [NSData dataWithContentsOfURL:cookieURL];
	NSCAssert(cookieData != nil, @"Cookie data could not be found!");
	NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:cookieData];
	unArchiver.requiresSecureCoding = NO;
	NSSet *codingClasses = [NSSet setWithArray:@[ [NSArray classForCoder],[NSHTTPCookie classForCoder] ]];
	NSArray <NSHTTPCookie *>*cookies = [unArchiver decodeObjectOfClasses:codingClasses forKey:NSKeyedArchiveRootObjectKey];
	NSCAssert(cookies.count != 0, @"No cookies found!");
	return cookies;
}

NSArray <NSHTTPCookie *>* XCDYouTubeProtectedVideosAdultUserCookies()
{
	NSURL *cookieURL = [[NSBundle bundleForClass:[XCDYouTubeProtectedVideosTestCase class]]URLForResource:@"adultUserCookieData" withExtension:nil subdirectory:@"Cookies"];
	
	NSCAssert(cookieURL != nil, @"Cookie data could not be found!");
	NSData *cookieData = [NSData dataWithContentsOfURL:cookieURL];
	NSCAssert(cookieData != nil, @"Cookie data could not be found!");
	NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:cookieData];
	unArchiver.requiresSecureCoding = NO;
	NSSet *codingClasses = [NSSet setWithArray:@[ [NSArray classForCoder],[NSHTTPCookie classForCoder] ]];
	NSArray <NSHTTPCookie *>*cookies = [unArchiver decodeObjectOfClasses:codingClasses forKey:NSKeyedArchiveRootObjectKey];
	NSCAssert(cookies.count != 0, @"No cookies found!");
	return cookies;
}

- (void) testAgeRestrictedVideoThatRequiresCookiesWithAdultUserCookies_online
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"vhG9_yBJmVE" cookies:XCDYouTubeProtectedVideosAdultUserCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURL);
		 XCTAssertTrue(video.streamURLs.count > 0);
		 XCTAssertTrue(video.duration > 0);
		 [video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		  {
			  XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		  }];
		 [expectation fulfill];
	 }];
	
	[self waitForExpectationsWithTimeout:30 handler:nil];
}

- (void) testAgeRestrictedVideoThatRequiresCookiesWithAdultUserCookiesIsPlayable_online
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"vhG9_yBJmVE" cookies:XCDYouTubeProtectedVideosAdultUserCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURL);
		 XCTAssertTrue(video.streamURLs.count > 0);
		 XCTAssertTrue(video.duration > 0);
		 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:video.streamURLs[@(XCDYouTubeVideoQualityMedium360)]];
		 request.HTTPMethod = @"HEAD";
		 NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError)
		 {
			XCTAssertEqual([(NSHTTPURLResponse *)response statusCode], 200);
			[expectation fulfill];
		}];
		 
		[dataTask resume];
	 }];
	
	[self waitForExpectationsWithTimeout:30 handler:nil];
}

- (void) testAgeRestrictedVideoThatRequiresCookiesWithMinorUserCookies_online
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"vhG9_yBJmVE" cookies:XCDYouTubeProtectedVideosMinorUserCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURL);
		 XCTAssertTrue(video.streamURLs.count > 0);
		 XCTAssertTrue(video.duration > 0);
		 [video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		  {
			  XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		  }];
		 [expectation fulfill];
	 }];
	
	[self waitForExpectationsWithTimeout:30 handler:nil];
}

- (void) testAgeRestrictedVideoThatRequiresCookiesWithMinortUserCookiesIsPlayable_online
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"vhG9_yBJmVE" cookies:XCDYouTubeProtectedVideosMinorUserCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURL);
		 XCTAssertTrue(video.streamURLs.count > 0);
		 XCTAssertTrue(video.duration > 0);
		 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:video.streamURLs[@(XCDYouTubeVideoQualityMedium360)]];
		 request.HTTPMethod = @"HEAD";
		 NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError)
		 {
			XCTAssertEqual([(NSHTTPURLResponse *)response statusCode], 200);
			[expectation fulfill];
		}];
		 
		[dataTask resume];
	 }];
	
	[self waitForExpectationsWithTimeout:30 handler:nil];
}

- (void) testAgeRestrictedVideoThatRequiresCookiesWithoutCookies
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"vhG9_yBJmVE" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNotNil(error);
		 XCTAssertNil(video);
		 [expectation fulfill];
	 }];
	
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testAgeRestrictedVideo
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"zKovmts2KSk" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURL);
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
		XCTAssertNotNil(video.thumbnailURL);
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
		XCTAssertNotNil(video.thumbnailURL);
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
		XCTAssertNotNil(video.thumbnailURL);
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
		XCTAssertNotNil(video.thumbnailURL);
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
		XCTAssertNotNil(video.thumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:video.streamURLs[@(XCDYouTubeVideoQualityMedium360)]];
		request.HTTPMethod = @"HEAD";
		NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError)
		{
			XCTAssertEqual([(NSHTTPURLResponse *)response statusCode], 200);
			[expectation fulfill];
		}];
		[dataTask resume];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testDASHAudioWithRateBypassIsPlayable
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"tg00YEETFzg" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		NSURL *dashAudioURL = video.streamURLs[@140];
		XCTAssertTrue([dashAudioURL.query containsString:@"ratebypass=yes"]);
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:dashAudioURL];
		request.HTTPMethod = @"HEAD";
		NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError)
		{
			XCTAssertEqual([(NSHTTPURLResponse *)response statusCode], 200);
			[expectation fulfill];
		}];
		[dataTask resume];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testAgeRestrictedVEVOVideoWithAdultUserCookies_online
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"07FYdnEawAQ" cookies:XCDYouTubeProtectedVideosAdultUserCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		{
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		}];
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:30 handler:nil];
}

- (void) testAgeRestrictedVEVOVideoWithAdultUserCookiesIsPlayable_online
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"07FYdnEawAQ" cookies:XCDYouTubeProtectedVideosAdultUserCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURL);
		 XCTAssertTrue(video.streamURLs.count > 0);
		 XCTAssertTrue(video.duration > 0);
		 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:video.streamURLs[@(XCDYouTubeVideoQualityMedium360)]];
		 request.HTTPMethod = @"HEAD";
		 NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError)
		 {
			XCTAssertEqual([(NSHTTPURLResponse *)response statusCode], 200);
			[expectation fulfill];
		}];
		 
		[dataTask resume];
	 }];
	
	[self waitForExpectationsWithTimeout:30 handler:nil];
}

- (void) testAgeRestrictedVEVOVideoWithMinorUserCookies_online
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"07FYdnEawAQ" cookies:XCDYouTubeProtectedVideosMinorUserCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURL);
		 XCTAssertTrue(video.streamURLs.count > 0);
		 XCTAssertTrue(video.duration > 0);
		 [video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		  {
			  XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		  }];
		 [expectation fulfill];
	 }];
	
	[self waitForExpectationsWithTimeout:30 handler:nil];
}

- (void) testAgeRestrictedVEVOVideoWithMinorUserCookiesIsPlayable_online
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"07FYdnEawAQ" cookies:XCDYouTubeProtectedVideosMinorUserCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURL);
		 XCTAssertTrue(video.streamURLs.count > 0);
		 XCTAssertTrue(video.duration > 0);
		 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:video.streamURLs[@(XCDYouTubeVideoQualityMedium360)]];
		 request.HTTPMethod = @"HEAD";
		 NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError)
		 {
			XCTAssertEqual([(NSHTTPURLResponse *)response statusCode], 200);
			[expectation fulfill];
		}];
		 
		[dataTask resume];
	 }];
	
	[self waitForExpectationsWithTimeout:30 handler:nil];
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
		XCTAssertEqualObjects(error.localizedDescription, @"This video is unavailable.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

// With Charles: Tools -> Black List... -> Add host:www.youtube.com and path:yts/* to simulate connection error on the player script
- (void) testProtectedVideoWithPlayerScriptConnectionError_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video is unavailable.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

// Edit testProtectedVideoWithoutSignatureFunction.json by replacing `c&&d.set(b,encodeURIComponent(` with `c&&d.Xset(b,encodeURIComponent(`
- (void) testProtectedVideoWithoutSignatureFunction_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video is unavailable.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

// Edit testProtectedVideoWithBrokenSignatureFunction.json by returning null in the signature function
//Replace `(function(g){var window` with `(function(g){return void 0!==a};{var window`
- (void) testProtectedVideoWithBrokenSignatureFunction_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video is unavailable.");
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
		XCTAssertEqualObjects(error.localizedDescription, @"This video is unavailable.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

// Edit testProtectedVideoWithNonAnonymousJavaScriptPlayerFunction.json by replacing `"(function()` with `"(xunction()`
- (void) testProtectedVideoWithNonAnonymousJavaScriptPlayerFunction_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video is unavailable.");
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

// See https://github.com/0xced/XCDYouTubeKit/issues/431
- (void) testAgeRestrictedVideo1
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"6kLq3WMV1nU" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURL);
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

// See https://github.com/0xced/XCDYouTubeKit/issues/431
// Remove \\/yts\\/jsbin\\/player_ias-vfl61X81T\\/en_US\\/base.js\ from testAgeRestrictedVideo1WithNoJavaScriptPlayerURL.json
- (void) testAgeRestrictedVideo1WithNoJavaScriptPlayerURL_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"6kLq3WMV1nU" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
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
