//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <XCDYouTubeKit/XCDYouTubeVideoPlayerViewController.h>

@interface XCDYouTubeVideoPlayerViewControllerTestCase : XCTestCase
@end

@implementation XCDYouTubeVideoPlayerViewControllerTestCase

- (void) testWrongInitializer
{
	XCTAssertThrowsSpecificNamed([[XCDYouTubeVideoPlayerViewController alloc] initWithContentURL:nil], NSException, NSGenericException);
}

@end
