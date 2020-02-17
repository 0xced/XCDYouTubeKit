//
//  XCDYouTubeVideoQueryOperationTestCase.m
//  XCDYouTubeKit Tests
//
//  Created by Soneé John on 2/17/20.
//  Copyright © 2020 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeKitTestCase.h"
#import <XCDYouTubeKit/XCDYouTubeVideoQueryOperation.h>
#import "XCDYouTubeVideo+Private.h"

@interface XCDYouTubeVideoQueryOperationTestCase : XCDYouTubeKitTestCase
extern XCDYouTubeVideo *XCDYouTubeVideoQueryOperationVideo(void);
@end

@implementation XCDYouTubeVideoQueryOperationTestCase

XCDYouTubeVideo *XCDYouTubeVideoQueryOperationVideo()
{
	return [[XCDYouTubeVideo alloc] initWithIdentifier:@"video1" info:@{ @"url_encoded_fmt_stream_map": @"url=http://www.youtube.com/video1.mp4&itag=123"} playerScript:nil response:nil error:NULL];
}

- (void) testWrongInitializer
{
	XCTAssertThrowsSpecificNamed([[XCDYouTubeVideoQueryOperation alloc] init], NSException, NSGenericException);
}

- (void) testIsAsynchronous
{
	XCDYouTubeVideoQueryOperation *operation = [[XCDYouTubeVideoQueryOperation alloc]initWithVideo:XCDYouTubeVideoQueryOperationVideo() cookies:nil];
	
	XCTAssertTrue(operation.isAsynchronous);
}

- (void) testStartingOperationOnMainThread
{
	[[NSOperationQueue mainQueue]addOperationWithBlock:^
	{
		XCDYouTubeVideoQueryOperation *operation = [[XCDYouTubeVideoQueryOperation alloc]initWithVideo:XCDYouTubeVideoQueryOperationVideo() cookies:nil];
		
		XCTAssertTrue([NSThread isMainThread]);
		XCTAssertThrows([operation start], @"`XCDYouTubeVideoQueryOperation` should not be started from the main queue.");
	}];
}

- (void) testStartingOperationOnBackgroundThread
{
	[[NSOperationQueue new]addOperationWithBlock:^
	{
		XCDYouTubeVideoQueryOperation *operation = [[XCDYouTubeVideoQueryOperation alloc]initWithVideo:XCDYouTubeVideoQueryOperationVideo() cookies:nil];
		
		XCTAssertFalse([NSThread isMainThread]);
		XCTAssertNoThrow([operation start]);
	}];
}

- (void) testCancelingOperationTwice
{
	XCDYouTubeVideoQueryOperation *operation = [[XCDYouTubeVideoQueryOperation alloc]initWithVideo:XCDYouTubeVideoQueryOperationVideo() cookies:nil];
	[self keyValueObservingExpectationForObject:operation keyPath:@"isFinished" handler:^BOOL(id observedObject, NSDictionary *change)
	{
		XCTAssertNil([observedObject streamURLs]);
		XCTAssertNil([observedObject error]);
		return YES;
	}];
	[operation cancel];
	[operation cancel];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void) testCancelingOperationAfterStart
{
	NSOperationQueue *queue = [NSOperationQueue new];
	XCDYouTubeVideoQueryOperation *operation = [[XCDYouTubeVideoQueryOperation alloc]initWithVideo:XCDYouTubeVideoQueryOperationVideo() cookies:nil];
	[self keyValueObservingExpectationForObject:operation keyPath:@"isFinished" handler:^BOOL(id observedObject, NSDictionary *change)
	{
		XCTAssertNil([observedObject streamURLs]);
		XCTAssertNil([observedObject error]);
		return YES;
	}];
	[queue addOperation:operation];
	[operation cancel];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void) testCancelingOperationBeforeStart
{
	XCDYouTubeVideoQueryOperation *operation = [[XCDYouTubeVideoQueryOperation alloc]initWithVideo:XCDYouTubeVideoQueryOperationVideo() cookies:nil];
		
	[self keyValueObservingExpectationForObject:operation keyPath:@"isFinished" handler:^BOOL(id observedObject, NSDictionary *change)
	{
		XCTAssertNil([observedObject streamURLs]);
		XCTAssertNil([observedObject error]);
		return YES;
	}];
	
	[[NSOperationQueue new]addOperationWithBlock:^
	{
		[operation cancel];
		[operation start];
	}];

	[self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testCancelingOperationAfterDelay
{
	NSOperationQueue *queue = [NSOperationQueue new];
	XCDYouTubeVideoQueryOperation *operation = [[XCDYouTubeVideoQueryOperation alloc]initWithVideo:XCDYouTubeVideoQueryOperationVideo() cookies:nil];
	[self keyValueObservingExpectationForObject:operation keyPath:@"isFinished" handler:^BOOL(id observedObject, NSDictionary *change)
	{
		XCTAssertNil([observedObject streamURLs]);
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
	[queue addOperation:operation];
	[operation performSelector:@selector(cancel) withObject:nil afterDelay:0.0];
	[videoExpectation performSelector:@selector(fulfill) withObject:nil afterDelay:0.2];
	[errorExpectation performSelector:@selector(fulfill) withObject:nil afterDelay:0.2];
	[self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
