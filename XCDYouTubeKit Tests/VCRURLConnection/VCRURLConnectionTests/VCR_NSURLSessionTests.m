//
// VCR_NSURLSessionTests.m
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

#import <Availability.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000 || __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090

#import <XCTest/XCTest.h>
#import "XCTestCase+VCR.h"
#import "VCR.h"
#import "VCRCassetteManager.h"

@interface VCR_NSURLSessionTests : XCTestCase
@property (nonatomic, strong) NSURLSession *sharedSession;
@property (nonatomic, strong) NSURLSession *defaultSession;
@property (nonatomic, strong) NSURLSession *ephemeralSession;
@end

@implementation VCR_NSURLSessionTests

- (void)setUp
{
    [super setUp];
    [VCR start];
    [[VCRCassetteManager defaultManager] setCurrentCassette:nil];
    self.sharedSession = [NSURLSession sharedSession];
    self.defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.ephemeralSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
}

- (void)testResponseIsRecordedWithSession:(NSURLSession *)session {
    NSURL *url = [NSURL URLWithString:@"http://www.iana.org/domains/reserved"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block BOOL completed = NO;
    __block NSData *receivedData;
    __block NSHTTPURLResponse *httpResponse;
    XCTestExpectation *expectation = [self expectationWithDescription:nil];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                completed = YES;
                                                receivedData = data;
                                                httpResponse = (NSHTTPURLResponse *)response;
                                                [expectation fulfill];
                                            }];
    [task resume];
    [self waitForExpectationsWithTimeout:60 handler:nil];
    
    VCRRecording *recording = [[[VCRCassetteManager defaultManager] currentCassette] recordingForRequest:request];
    XCTAssertEqual(recording.statusCode, httpResponse.statusCode, @"");
    XCTAssertEqualObjects(recording.data, receivedData, @"");
    XCTAssertEqualObjects(recording.method, request.HTTPMethod, @"");
    XCTAssertEqualObjects(recording.URI, [[request URL] absoluteString], @"");
    XCTAssert(recording.statusCode != 0, @"");
    XCTAssertNotNil(recording.headerFields);
}
              
- (void)testResponseIsRecordedForSharedSession {
    [self testResponseIsRecordedWithSession:self.sharedSession];
}

- (void)testResponseIsRecordedForDefaultSession {
    [self testResponseIsRecordedWithSession:self.defaultSession];
}
/*
- (void)testResponseIsRecordedForEphemeralSession {
    [self testResponseIsRecordedWithSession:self.ephemeralSession];
}
*/

// FIXME: need bundle id to test background session

- (void)testResponseIsReplayedWithSession:(NSURLSession *)session {
    NSString *uri = @"http://foo";
    id json = @{ @"method": @"GET", @"uri": uri, @"body": @"Foo Bar Baz" };
    VCRCassette *cassette = [[VCRCassette alloc] initWithJSON:@[ json ]];
    [[VCRCassetteManager defaultManager] setCurrentCassette:cassette];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:uri]];
    VCRRecording *recording = [[[VCRCassetteManager defaultManager] currentCassette] recordingForRequest:request];
    
    __block BOOL completed = NO;
    __block NSData *receivedData;
    __block NSHTTPURLResponse *httpResponse;
    XCTestExpectation *expectation = [self expectationWithDescription:nil];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                completed = YES;
                                                receivedData = data;
                                                httpResponse = (NSHTTPURLResponse *)response;
                                                [expectation fulfill];
                                            }];
    [task resume];
    
    [self waitForExpectationsWithTimeout:60 handler:nil];
    XCTAssertEqual(httpResponse.statusCode, recording.statusCode, @"");
    XCTAssertEqualObjects(receivedData, recording.data, @"");
}

- (void)testResponseIsReplayedForSharedSession {
    [self testResponseIsReplayedWithSession:self.sharedSession];
}

- (void)testResponseIsReplayedForDefaultSession {
    [self testResponseIsReplayedWithSession:self.defaultSession];
}

/*
- (void)testResponseIsReplayedForEphemeralSession {
    [self testResponseIsReplayedWithSession:self.ephemeralSession];
}
*/

@end

#endif
