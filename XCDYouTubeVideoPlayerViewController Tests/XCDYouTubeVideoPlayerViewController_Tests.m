//
//  XCDYouTubeVideoPlayerViewController_Tests.m
//  XCDYouTubeVideoPlayerViewController Tests
//
//  Created by Cédric Luthi on 11.01.14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TRVSMonitor.h"
#import <XCDYouTubeVideoPlayerViewController/XCDYouTubeVideoPlayerViewController.h>
#import <XCDYouTubeVideoPlayerViewController/XCDYouTubeClient.h>
#import <XCDYouTubeVideoPlayerViewController/XCDYouTubeError.h>
#import <XCDYouTubeVideoPlayerViewController/XCDYouTubeVideo.h>

@interface XCDYouTubeVideoPlayerViewController_Tests : XCTestCase

@property TRVSMonitor *monitor;

@end

@interface NSURLRequest (Private)
+ (void) setAllowsAnyHTTPSCertificate:(BOOL)allowsAnyHTTPSCertificate forHost:(NSString *)host;
@end

@implementation XCDYouTubeVideoPlayerViewController_Tests

+ (void) initialize
{
	if (self != [XCDYouTubeVideoPlayerViewController_Tests class])
		return;
	
	// The connections to YouTube over https fail with a certificate error when running the unit tests but work fine inside an app environment
	// Error Domain=NSURLErrorDomain Code=-1202 "The certificate for this server is invalid. You might be connecting to a server that is pretending to be “www.youtube.com” which could put your confidential information at risk."
	[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"www.youtube.com"];
}

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

@end
