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
	XCTAssertTrue(operation.isAsynchronous);
}

- (void) testIsConcurrent
{
	XCDYouTubeVideoOperation *operation = [[XCDYouTubeVideoOperation alloc] initWithVideoIdentifier:@"" languageIdentifier:nil];
	XCTAssertTrue(operation.isConcurrent);
}

- (void) testStartingOnMainThread
{
	XCDYouTubeVideoOperation *operation = [[XCDYouTubeVideoOperation alloc] initWithVideoIdentifier:@"" languageIdentifier:nil];
	[self keyValueObservingExpectationForObject:operation keyPath:@"isFinished" handler:^BOOL(id observedObject, NSDictionary *change)
	{
		XCTAssertNil([observedObject video]);
		XCTAssertNotNil([observedObject error]);
		return YES;
	}];
	
	XCTAssertTrue([NSThread isMainThread]);
	[operation start];
	
	[self waitForExpectationsWithTimeout:5 handler:nil];
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

- (void) testCancelingOperation
{
	XCDYouTubeVideoOperation *operation = [[XCDYouTubeVideoOperation alloc] initWithVideoIdentifier:@"" languageIdentifier:nil];
	[self keyValueObservingExpectationForObject:operation keyPath:@"isFinished" handler:^BOOL(id observedObject, NSDictionary *change)
	{
		XCTAssertNil([observedObject video]);
		XCTAssertNil([observedObject error]);
		return YES;
	}];
	[operation start];
	[operation cancel];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void) testCancelingOperationAfterDelay
{
	XCDYouTubeVideoOperation *operation = [[XCDYouTubeVideoOperation alloc] initWithVideoIdentifier:@"" languageIdentifier:nil];
	[self keyValueObservingExpectationForObject:operation keyPath:@"isFinished" handler:^BOOL(id observedObject, NSDictionary *change)
	{
		XCTAssertNil([observedObject video]);
		XCTAssertNil([observedObject error]);
		return YES;
	}];
	__weak XCTestExpectation *videoExpectation = [self keyValueObservingExpectationForObject:operation keyPath:@"video" handler:^BOOL(id observedObject, NSDictionary *change)
	{
		XCTFail();
		return NO;
	}];
	__weak XCTestExpectation *errorExpectation = [self keyValueObservingExpectationForObject:operation keyPath:@"error" handler:^BOOL(id observedObject, NSDictionary *change)
	{
		XCTFail();
		return NO;
	}];
	[operation start];
	[operation performSelector:@selector(cancel) withObject:nil afterDelay:0.2];
	[videoExpectation performSelector:@selector(fulfill) withObject:nil afterDelay:0.4];
	[errorExpectation performSelector:@selector(fulfill) withObject:nil afterDelay:0.4];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
