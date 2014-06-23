//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeKitTestCase.h"

#import <XCDYouTubeKit/XCDYouTubeClient.h>

@interface NSURLRequest (Private)
+ (void) setAllowsAnyHTTPSCertificate:(BOOL)allowsAnyHTTPSCertificate forHost:(NSString *)host;
@end

@interface XCDYouTubeProtectedVideosTestCase : XCDYouTubeKitTestCase
@end

@implementation XCDYouTubeProtectedVideosTestCase

- (void) setUp
{
	[super setUp];
	
	if (NSProcessInfo.processInfo.environment[@"VCR_CASSETTES_DIRECTORY"])
		[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"www.youtube.com"];
}

- (void) tearDown
{
	[super tearDown];
	
	if (NSProcessInfo.processInfo.environment[@"VCR_CASSETTES_DIRECTORY"])
		[NSURLRequest setAllowsAnyHTTPSCertificate:NO forHost:@"www.youtube.com"];
}

- (void) testProtectedVEVOVideo
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
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
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testProtectedVideoWithDollarSignature
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNil(video.largeThumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop) {
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		}];
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

// With Charles
//   * Enable SSL proxying for *.youtube.com
//   * Tools -> Black List... -> Add host:www.youtube.com and path:watch to simulate connection error on the web page
- (void) testProtectedVideoWithWebPageConnectionError
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video contains content from WMG. It is restricted from playback on certain sites. Watch on YouTube");
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

// With Charles: Tools -> Black List... -> Add `s.ytimg.com` to simulate connection error on the player script
- (void) testProtectedVideoWithPlayerScriptConnectionError
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video contains content from WMG. It is restricted from playback on certain sites. Watch on YouTube");
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

// Edit testProtectedVideoWithoutSignatureFunction.json by replacing `signature=` with `signaturX=`
- (void) testProtectedVideoWithoutSignatureFunction
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(video);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		XCTAssertEqualObjects(error.localizedDescription, @"This video contains content from WMG. It is restricted from playback on certain sites. Watch on YouTube");
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

@end
