//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeKitTestCase.h"

#import <XCDYouTubeKit/XCDYouTubeVideoPlayerViewController.h>
#import <XCDYouTubeKit/XCDYouTubeError.h>

@interface XCDYouTubeVideoPlayerViewControllerTestCase : XCDYouTubeKitTestCase
@end

@implementation XCDYouTubeVideoPlayerViewControllerTestCase

- (void) testWrongInitializer
{
	XCTAssertThrowsSpecificNamed([[XCDYouTubeVideoPlayerViewController alloc] initWithContentURL:nil], NSException, NSGenericException);
}

- (void) testVideoNotification
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"EdeVaT-zZt4"];
	[[NSNotificationCenter defaultCenter] addObserverForName:XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification object:videoPlayerViewController queue:nil usingBlock:^(NSNotification *notification) {
		XCTAssertNotNil(notification.userInfo[XCDYouTubeVideoUserInfoKey]);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testAsynchronousVideoNotification
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [XCDYouTubeVideoPlayerViewController new];
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		videoPlayerViewController.videoIdentifier = @"EdeVaT-zZt4";
	}];
	[[NSNotificationCenter defaultCenter] addObserverForName:XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification object:videoPlayerViewController queue:nil usingBlock:^(NSNotification *notification) {
		XCTAssertNotNil(notification.userInfo[XCDYouTubeVideoUserInfoKey]);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testNoStreamAvailableErrorNotification
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"EdeVaT-zZt4"];
	videoPlayerViewController.preferredVideoQualities = @[];
	[[NSNotificationCenter defaultCenter] addObserverForName:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer queue:nil usingBlock:^(NSNotification *notification) {
		NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
		MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
		XCTAssertEqual(finishReason, MPMovieFinishReasonPlaybackError);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testRestrictedPlaybackErrorNotification
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"1kIsylLeHHU"];
	[[NSNotificationCenter defaultCenter] addObserverForName:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer queue:nil usingBlock:^(NSNotification *notification) {
		NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
		MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
		XCTAssertEqual(finishReason, MPMovieFinishReasonPlaybackError);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

@end
