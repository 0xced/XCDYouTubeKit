//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeKitTestCase.h"

#import <XCDYouTubeKit/XCDYouTubeVideoOperation.h>

@interface XCDYouTubeVideoOperationTestCase : XCDYouTubeKitTestCase
@end

@implementation XCDYouTubeVideoOperationTestCase

- (void) testWrongInitializer
{
	XCTAssertThrowsSpecificNamed([[XCDYouTubeVideoOperation alloc] init], NSException, NSGenericException);
}

- (void) testIsAsynchronous
{
	XCDYouTubeVideoOperation *operation = [[XCDYouTubeVideoOperation alloc] initWithVideoIdentifier:@"" languageIdentifier:nil];
	XCTAssertFalse(operation.isAsynchronous);
}

- (void) testIsConcurrent
{
	XCDYouTubeVideoOperation *operation = [[XCDYouTubeVideoOperation alloc] initWithVideoIdentifier:@"" languageIdentifier:nil];
	XCTAssertFalse(operation.isConcurrent);
}

- (void) testStartingOnMainThread
{
	XCDYouTubeVideoOperation *operation = [[XCDYouTubeVideoOperation alloc] initWithVideoIdentifier:@"" languageIdentifier:nil];
	XCTAssertTrue([NSThread isMainThread]);
	XCTAssertThrowsSpecificNamed([operation start], NSException, NSGenericException);
}

- (void) testStartingOnBackgroundThread
{
	XCDYouTubeVideoOperation *operation = [[XCDYouTubeVideoOperation alloc] initWithVideoIdentifier:@"" languageIdentifier:nil];
	[self keyValueObservingExpectationForObject:operation keyPath:@"isFinished" handler:^BOOL(id observedObject, NSDictionary *change)
	{
		XCTAssertNil([observedObject video]);
		XCTAssertNotNil([observedObject error]);
		return YES;
	}];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		XCTAssertFalse([NSThread isMainThread]);
		[operation start];
	});
	[self waitForExpectationsWithTimeout:5 handler:nil];
}

@end
