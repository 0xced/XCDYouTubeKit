//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <XCDYouTubeKit/XCDYouTubeVideoOperation.h>

@interface XCDYouTubeVideoOperationTestCase : XCTestCase
@end

@implementation XCDYouTubeVideoOperationTestCase

- (void) testWrongInitializer
{
	XCTAssertThrowsSpecificNamed([[XCDYouTubeVideoOperation alloc] init], NSException, NSGenericException);
}

- (void) testIsConcurrent
{
	XCDYouTubeVideoOperation *operation = [[XCDYouTubeVideoOperation alloc] initWithVideoIdentifier:nil languageIdentifier:nil];
	XCTAssertTrue(operation.isConcurrent);
}

@end
