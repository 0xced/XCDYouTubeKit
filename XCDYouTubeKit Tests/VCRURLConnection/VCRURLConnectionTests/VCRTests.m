//
//  VCRTests.m
//  VCRURLConnection
//
//  Created by Dustin Barker on 1/3/14.
//
//

#import <XCTest/XCTest.h>
#import "VCR.h"

@interface VCRTests : XCTestCase

@end

@implementation VCRTests

- (void)testStartReplaying {
    [VCR setReplaying:YES];
    XCTAssert([VCR isReplaying], @"");
}

- (void)testStopReplaying {
    [VCR setReplaying:NO];
    XCTAssertFalse([VCR isReplaying], @"");
}

- (void)testStartRecording {
    [VCR setRecording:YES];
    XCTAssert([VCR isRecording], @"");
}

- (void)testStopRecording {
    [VCR setRecording:NO];
    XCTAssertFalse([VCR isRecording], @"");
}

- (void)testStart {
    [VCR start];
    XCTAssert([VCR isRecording], @"");
    XCTAssert([VCR isReplaying], @"");
}

- (void)testStop {
    [VCR stop];
    XCTAssertFalse([VCR isRecording], @"");
    XCTAssertFalse([VCR isReplaying], @"");
}

@end
