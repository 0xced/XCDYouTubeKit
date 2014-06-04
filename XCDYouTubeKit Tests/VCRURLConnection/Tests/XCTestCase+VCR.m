//
// XCTestCase+VCR.m
//
// Copyright (c) 2013 Dustin Barker
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "XCTestCase+VCR.h"
#import "XCTestCase+SRTAdditions.h"
#import "VCRCassetteManager.h"
#import "VCRCassette.h"
#import "VCRRecording.h"

@implementation XCTestCase (VCR)

- (void)recordRequest:(NSURLRequest *)request
         requestBlock:(void(^)())requestBlock
       predicateBlock:(BOOL(^)())predicateBlock
           completion:(void(^)(VCRRecording *recording))completion {
    
    // request has not been recorded yet
    VCRCassette *cassette = [[VCRCassetteManager defaultManager] currentCassette];
    XCTAssertNil([cassette recordingForRequest:request], @"Should not have recording for request yet");
    
    // make and record request
    requestBlock(request);
    
    // wait for request to finish
    [self runCurrentRunLoopUntilTestPasses:predicateBlock timeout:60 * 60];
    
    VCRRecording *recording = [[[VCRCassetteManager defaultManager] currentCassette] recordingForRequest:request];
    completion(recording);
}

- (void)testRecording:(VCRRecording *)recording forRequest:(NSURLRequest *)request {
    XCTAssertNotNil(recording);
    XCTAssertEqualObjects(recording.method, request.HTTPMethod, @"");
    XCTAssertEqualObjects(recording.URI, [[request URL] absoluteString], @"");
    XCTAssert(recording.statusCode != 0, @"");
    XCTAssertNotNil(recording.headerFields);
}

- (void)testDelegate:(id<VCRTestDelegate>)delegate forRecording:(VCRRecording *)recording {
    XCTAssertEqualObjects(delegate.data, recording.data, @"Recorded data should equal recorded data");
    XCTAssertEqualObjects(delegate.data, recording.data, @"Received data should equal recorded data");
    XCTAssertEqual(delegate.response.statusCode, recording.statusCode, @"");
}

- (void)replayJSON:(id)json
      requestBlock:(void(^)(NSURLRequest *request))requestBlock
    predicateBlock:(BOOL(^)())predicateBlock
        completion:(void(^)(VCRRecording *))completion {

    VCRCassette *cassette = [[VCRCassette alloc] initWithJSON:@[ json ]];
    [[VCRCassetteManager defaultManager] setCurrentCassette:cassette];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:json[@"uri"]]];
    
    // cassette has recording for request
    VCRRecording *recording = [cassette recordingForRequest:request];
    XCTAssertNotNil(recording, @"Should have recorded response");
    
    requestBlock(request);
    
    // wait for request to finish
    [self runCurrentRunLoopUntilTestPasses:predicateBlock timeout:60 * 60];
    
    completion(recording);
}

@end
