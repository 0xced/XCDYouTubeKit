//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <XCDYouTubeKit/XCDYouTubeClient.h>

#import "TRVSMonitor.h"
#import "VCR.h"
#import "VCRCassetteManager.h"

@interface XCTest (Private)
- (void) setUpTestWithSelector:(SEL)selector;
@end

@interface XCDYouTubeClientTestCase : XCTestCase
@property NSURL *cassetteURL;
@end

@implementation XCDYouTubeClientTestCase

- (void) setUpTestWithSelector:(SEL)selector
{
	[super setUpTestWithSelector:selector];
	
	NSString *cassettesDirectory = [[[NSProcessInfo processInfo] environment] objectForKey:@"VCR_CASSETTES_DIRECTORY"];
	if ([[NSFileManager defaultManager] fileExistsAtPath:cassettesDirectory])
	{
		self.cassetteURL = [NSURL fileURLWithPath:[[cassettesDirectory stringByAppendingPathComponent:NSStringFromSelector(selector)] stringByAppendingPathExtension:@"json"]];
		[[NSFileManager defaultManager] removeItemAtURL:self.cassetteURL error:NULL];
		[VCR setRecording:YES];
	}
	else
	{
		self.cassetteURL = [[NSBundle bundleForClass:self.class] URLForResource:NSStringFromSelector(selector) withExtension:@"json" subdirectory:@"Cassettes"];
		XCTAssertNotNil(self.cassetteURL);
		[VCR loadCassetteWithContentsOfURL:self.cassetteURL];
		[VCR setReplaying:YES];
	}
}

- (void) tearDown
{
	if ([VCR isRecording])
	{
		[VCR save:self.cassetteURL.path];
		if (![[NSFileManager defaultManager] fileExistsAtPath:self.cassetteURL.path])
			[@"[]" writeToURL:self.cassetteURL atomically:YES encoding:NSASCIIStringEncoding error:NULL];
	}
	
	[VCR stop];
	[[VCRCassetteManager defaultManager] setCurrentCassette:nil];
	
	[super tearDown];
}

- (void) testThatVideoIsAvailalbeOnDetailPageEventLabel
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"dQw4w9WgXcQ" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(video);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testThatVideoHasMetadata
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"9TTioMbNT9I" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
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

- (void) testProtectedVEVOVideo
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertTrue(video.streamURLs.count > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop) {
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		}];
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testRestrictedVideo
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"1kIsylLeHHU" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
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
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"BXnA9FjvLSU" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
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
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"tooShort" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
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
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:nil completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorInvalidVideoIdentifier);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testConnectionError
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"EdeVaT-zZt4" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorNetwork);
		NSError *underlyingError = error.userInfo[NSUnderlyingErrorKey];
		XCTAssertEqualObjects(underlyingError.domain, NSURLErrorDomain);
		XCTAssertEqual(underlyingError.code, NSURLErrorNotConnectedToInternet);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testUsingClientOnNonMainThread
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		XCTAssertFalse([NSThread isMainThread]);
		[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"EdeVaT-zZt4" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
			XCTAssertTrue([NSThread isMainThread]);
			[monitor signal];
		}];
	});
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testCancelingOperation
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	id<XCDYouTubeOperation> operation = [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"EdeVaT-zZt4" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTFail();
	}];
	[operation cancel];
	XCTAssertFalse([monitor waitWithTimeout:0.2]);
}

- (void) testNilCompletionHandler
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
	XCTAssertThrowsSpecificNamed([[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"EdeVaT-zZt4" completionHandler:nil], NSException, NSInvalidArgumentException);
#pragma clang diagnostic pop
}

@end
