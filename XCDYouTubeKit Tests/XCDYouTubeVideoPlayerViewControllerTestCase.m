//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
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
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"EdeVaT-zZt4"];
	[[NSNotificationCenter defaultCenter] addObserverForName:XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification object:videoPlayerViewController queue:nil usingBlock:^(NSNotification *notification)
	{
		XCTAssertNotNil(notification.userInfo[XCDYouTubeVideoUserInfoKey]);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testAsynchronousVideoNotification
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [XCDYouTubeVideoPlayerViewController new];
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		videoPlayerViewController.videoIdentifier = @"EdeVaT-zZt4";
	}];
	[[NSNotificationCenter defaultCenter] addObserverForName:XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification object:videoPlayerViewController queue:nil usingBlock:^(NSNotification *notification)
	{
		XCTAssertNotNil(notification.userInfo[XCDYouTubeVideoUserInfoKey]);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testNoStreamAvailableErrorNotification
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"EdeVaT-zZt4"];
	videoPlayerViewController.preferredVideoQualities = @[];
	[[NSNotificationCenter defaultCenter] addObserverForName:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer queue:nil usingBlock:^(NSNotification *notification)
	{
		NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
		MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
		XCTAssertEqual(finishReason, MPMovieFinishReasonPlaybackError);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testRestrictedPlaybackErrorNotification
{
	__weak XCTestExpectation *expectation = [self expectationWithDescription:@""];
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"1kIsylLeHHU"];
	[[NSNotificationCenter defaultCenter] addObserverForName:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer queue:nil usingBlock:^(NSNotification *notification)
	{
		NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
		MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
		XCTAssertEqual(finishReason, MPMovieFinishReasonPlaybackError);
		XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
		XCTAssertEqual(error.code, XCDYouTubeErrorRestrictedPlayback);
		[expectation fulfill];
	}];
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testPresentInView
{
	UIView *view = [UIView new];
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"EdeVaT-zZt4"];
	XCTAssertNil(videoPlayerViewController.moviePlayer.view.superview);
	[videoPlayerViewController presentInView:view];
	XCTAssertEqualObjects(videoPlayerViewController.moviePlayer.view.superview, view);
	XCTAssertEqual(videoPlayerViewController.moviePlayer.controlStyle, MPMovieControlStyleEmbedded);
	XCTAssertFalse(videoPlayerViewController.moviePlayer.currentPlaybackRate > 0.0f);
}

@end
