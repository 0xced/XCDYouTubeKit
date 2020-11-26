//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeKitTestCase.h"

#import <XCDYouTubeKit/XCDYouTubeClient.h>
#import "XCDYouTubeVideo+Private.h"

@interface XCDYouTubeProtectedVideosTestCase : XCDYouTubeKitTestCase
extern NSArray <NSHTTPCookie *>* XCDYouTubeProtectedVideosCookies(void);
@end

@implementation XCDYouTubeProtectedVideosTestCase

NSArray <NSHTTPCookie *>* XCDYouTubeProtectedVideosCookies()
{
	NSURL *cookieURL = [[NSBundle bundleForClass:[XCDYouTubeProtectedVideosTestCase class]]URLForResource:@"UserCookieData" withExtension:nil subdirectory:@"Cookies"];
	
	NSCAssert(cookieURL != nil, @"Cookie data could not be found!");
	NSData *cookieData = [NSData dataWithContentsOfURL:cookieURL];
	NSCAssert(cookieData != nil, @"Cookie data could not be found!");
	NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingFromData:cookieData error:nil];
	unArchiver.requiresSecureCoding = NO;
	NSSet *codingClasses = [NSSet setWithArray:@[ [NSArray classForCoder],[NSHTTPCookie classForCoder] ]];
	NSArray <NSHTTPCookie *>*cookies = [unArchiver decodeObjectOfClasses:codingClasses forKey:NSKeyedArchiveRootObjectKey];
	NSCAssert(cookies.count != 0, @"No cookies found!");
	return cookies;
}

- (void)tearDown
{
	self.cookies = nil;
	[super tearDown];
}

- (void)setUpTestWithSelector:(SEL)selector
{
	if ([NSStringFromSelector(selector) containsString:@"Cookies"])
	{
		self.cookies = XCDYouTubeProtectedVideosCookies();
	}
	[super setUpTestWithSelector:selector];
}

- (void) testAgeRestrictedVideoThatRequiresCookiesWithUserCookies
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"vhG9_yBJmVE" cookies:XCDYouTubeProtectedVideosCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertTrue(video.viewCount > 0);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURLs.firstObject);
		 XCTAssertTrue(video.streamURLs.count > 0);
		 XCTAssertTrue(video.duration > 0);
		 [video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		  {
			  XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound || [streamURL.query rangeOfString:@"sig="].location != NSNotFound);
		  }];
		 [expectation fulfill];
	 }];
	
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testAgeRestrictedVideoThatRequiresCookiesWithUserCookiesIsPlayable
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"vhG9_yBJmVE" cookies:XCDYouTubeProtectedVideosCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertTrue(video.viewCount > 0);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURLs.firstObject);
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
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		{
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound || [streamURL.query rangeOfString:@"sig="].location != NSNotFound);
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
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		{
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound || [streamURL.query rangeOfString:@"sig="].location != NSNotFound);
		}];
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testProtectedVEVOVideoWithInvalidCustomPattern
{
	//Although, this uses a valid regular expression (xxxxxxx) it does not match the signature function in `XCDYouTubePlayerScript`
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" cookies:nil customPatterns:@[@"xxxxxxx"] completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error)
	{
		XCTAssertNotNil(error);
		XCTAssertNil(video);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testProtectedVEVOVideoWithNilCustomPatternIsPlayable
{
	//If a nil array is passed then we should fallback to the hard-coded patterns
	
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" cookies:nil customPatterns:nil completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
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

- (void) testProtectedVEVOVideoWithEmptyCustomPatternIsPlayable
{
	//If an empty array is passed then we should fallback to the hard-coded patterns
	
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" cookies:nil customPatterns:@[] completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
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

- (void) testProtectedVEVOVideoWithInvalidCustomPatternIsPlayable
{
	//Although, this uses an invalid regular expression `{{{{{` the video should still be playable because we fallback to the hard-coded patterns in `XCDYouTubePlayerScript`.
	
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" cookies:nil customPatterns:@[@"{{{{{"] completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
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

- (void) testProtectedVEVOVideoWithValidCustomPatternIsPlayable
{
	//Here we're testing if pattern `\\b([a-zA-Z0-9$]{2})\\s*=\\s*function\\(\\s*a\\s*\\)\\s*\\{\\s*a\\s*=\\s*a\\.split\\(\\s*\"\"\\s*\\)` works, this pattern is valid as of Feb 5, 2020 and works for video id `rId6PKlDXeU`
	
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" cookies:nil customPatterns:@[@"\\b([a-zA-Z0-9$]{2})\\s*=\\s*function\\(\\s*a\\s*\\)\\s*\\{\\s*a\\s*=\\s*a\\.split\\(\\s*\"\"\\s*\\)"] completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
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

- (void) testProtectedVEVOVideo1
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		{
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound || [streamURL.query rangeOfString:@"sig="].location != NSNotFound);
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
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		{
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound || [streamURL.query rangeOfString:@"sig="].location != NSNotFound);
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
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		{
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound || [streamURL.query rangeOfString:@"sig="].location != NSNotFound);
		}];
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

// See testAlternativeSignatureValue.xml for Charles Proxy Setting
// Import: Charles Proxy > Tools > Rewrite
- (void) testAlternativeSignatureValue_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		{
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound || [streamURL.query rangeOfString:@"sig="].location != NSNotFound);
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
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
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

- (void) testAgeRestrictedVEVOVideoWithUserCookies
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"07FYdnEawAQ" cookies:XCDYouTubeProtectedVideosCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertTrue(video.viewCount > 0);
		XCTAssertNotNil(video.expirationDate);
		XCTAssertNotNil(video.thumbnailURLs.firstObject);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		{
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound || [streamURL.query rangeOfString:@"sig="].location != NSNotFound);
		}];
		[expectation fulfill];
	}];
	
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testAgeRestrictedVEVOVideoWithUserCookiesIsPlayable
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"07FYdnEawAQ" cookies:XCDYouTubeProtectedVideosCookies() completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertTrue(video.viewCount > 0);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURLs.firstObject);
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
		XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
		XCTAssertEqualObjects(error.localizedDescription, @"Video unavailable");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

// With Charles: Tools -> Black List... -> Add host:www.youtube.com and path:s/player/* to simulate connection error on the player script
- (void) testProtectedVideoWithPlayerScriptConnectionError_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
		XCTAssertEqualObjects(error.localizedDescription, @"Video unavailable");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

// Edit testProtectedVideoWithoutSignatureFunction.json by removing entire body for javascript URL and adding "XXXX"
- (void) testProtectedVideoWithoutSignatureFunction_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
		XCTAssertEqualObjects(error.localizedDescription, @"Video unavailable");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

// Edit testProtectedVideoWithoutJavaScriptPlayerURL.json by replacing `\"js\":` with `\"xs\":` and and `jsUrl` with `jsXUrl` 
- (void) testProtectedVideoWithoutJavaScriptPlayerURL_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
		XCTAssertEqualObjects(error.localizedDescription, @"Video unavailable");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

// Edit testProtectedVideoWithNonAnonymousJavaScriptPlayerFunction.json by replacing all `(function` with `(Xfunction`
// And replace `Xu=function` with `Xu=funXtion` and
//`decodeURIComponent` with `deXodeURIComponent`
- (void) testProtectedVideoWithNonAnonymousJavaScriptPlayerFunction_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
		XCTAssertEqualObjects(error.localizedDescription, @"Video unavailable");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

// With Charles: Tools -> Black List... -> Add host:www.youtube.com and path:embed/* to simulate connection error on the web page and replace and `jsUrl` with `jsXUrl` in testAgeRestrictedVEVOVideoWithEmbedWebPageConnectionError.json
- (void) testAgeRestrictedVEVOVideoWithEmbedWebPageConnectionError_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"07FYdnEawAQ" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	{
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
		XCTAssertEqualObjects(error.localizedDescription, @"This video may be inappropriate for some users.");
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5  handler:nil];
}

// See https://github.com/0xced/XCDYouTubeKit/issues/431
- (void) testAgeRestrictedVideo1
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"6kLq3WMV1nU" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(error);
		 XCTAssertNotNil(video.title);
		 XCTAssertTrue(video.viewCount > 0);
		 XCTAssertNotNil(video.expirationDate);
		 XCTAssertNotNil(video.thumbnailURLs.firstObject);
		 XCTAssertTrue(video.streamURLs.count > 0);
		 XCTAssertTrue(video.duration > 0);
		 [video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop)
		  {
			  XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound || [streamURL.query rangeOfString:@"sig="].location != NSNotFound);
		  }];
		 [expectation fulfill];
	 }];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

// See https://github.com/0xced/XCDYouTubeKit/issues/431
// Replace `assets` with `Xassets` and `jsUrl` with `jsXUrl` in testAgeRestrictedVideo1WithNoJavaScriptPlayerURL.json
- (void) testAgeRestrictedVideo1WithNoJavaScriptPlayerURL_offline
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"6kLq3WMV1nU" completionHandler:^(XCDYouTubeVideo *video, NSError *error)
	 {
		 XCTAssertNil(video);
		 XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		 XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
		 XCTAssertEqualObjects(error.localizedDescription, @"This video may be inappropriate for some users.");
		 [expectation fulfill];
	 }];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

@end
