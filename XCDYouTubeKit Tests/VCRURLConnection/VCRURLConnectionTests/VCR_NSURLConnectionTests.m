//
// VCRURLConnectionTests.m
//
// Copyright (c) 2012 Dustin Barker
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

#import "VCR_NSURLConnectionTests.h"
#import "XCTestCase+SRTAdditions.h"
#import "VCRCassetteManager.h"
#import "VCRCassette.h"
#import "VCRRequestKey.h"
#import "VCRRecording.h"
#import "VCR.h"

@interface VCRTestConnectionController : NSObject<NSURLConnectionDelegate>
- (void)sendRequest:(NSURLRequest *)request completion:(void (^)())completion;
@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSError *error;
@end

@implementation VCR_NSURLConnectionTests

- (void)setUp {
    [super setUp];
    [VCR start];
    [[VCRCassetteManager defaultManager] setCurrentCassette:nil];
}

- (void)tearDown {
    [VCR stop];
    [super tearDown];
}

- (void)testResponseIsRecorded {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.iana.org/domains/reserved"]];
    [self sendRequest:request];
    VCRRecording *recording = [[[VCRCassetteManager defaultManager] currentCassette] recordingForRequest:request];
    XCTAssertEqualObjects(recording.method, request.HTTPMethod, @"");
    XCTAssertEqualObjects(recording.URI, [[request URL] absoluteString], @"");
    XCTAssert(recording.statusCode != 0, @"");
    XCTAssertNotNil(recording.headerFields);
}

- (void)testResponseIsDelegated {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.iana.org/domains/reserved"]];
    VCRTestConnectionController *controller = [self sendRequest:request];
    VCRRecording *recording = [[[VCRCassetteManager defaultManager] currentCassette] recordingForRequest:request];
    XCTAssertEqualObjects(controller.data, recording.data, @"Received data should equal recorded data");
    XCTAssertEqual(controller.response.statusCode, recording.statusCode, @"");
}

- (void)testResponseIsReplayed {
    NSString *uri = @"http://foo";
    id json = @{ @"method": @"GET", @"uri": uri, @"body": @"Foo Bar Baz" };
    VCRCassette *cassette = [[VCRCassette alloc] initWithJSON:@[ json ]];
    [[VCRCassetteManager defaultManager] setCurrentCassette:cassette];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:uri]];
    VCRRecording *recording = [[[VCRCassetteManager defaultManager] currentCassette] recordingForRequest:request];
    VCRTestConnectionController *controller = [self sendRequest:request];
    XCTAssertEqualObjects(controller.data, recording.data, @"Received data should equal recorded data");
    XCTAssertEqual(controller.response.statusCode, recording.statusCode, @"");
}

- (void)testErrorIsRecorded {
    NSURL *url = [NSURL URLWithString:@"http://z/foo"]; // non-existent host
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self sendRequest:request];
    VCRRecording *recording = [[[VCRCassetteManager defaultManager] currentCassette] recordingForRequest:request];
    XCTAssertNotNil(recording);
    XCTAssertNotNil(recording.error, @"");
}

- (void)testErrorIsDelegated {
    NSURL *url = [NSURL URLWithString:@"http://z/foo"]; // non-existent host
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    VCRTestConnectionController *controller = [self sendRequest:request];
    VCRRecording *recording = [[[VCRCassetteManager defaultManager] currentCassette] recordingForRequest:request];
    XCTAssertEqualObjects(controller.data, recording.data, @"Received data should equal recorded data");
    XCTAssertEqual(controller.response.statusCode, recording.statusCode, @"");
    XCTAssertNotNil(controller.error, @"");
}

- (void)testErrorIsReplayed {
    NSString *uri = @"http://foo";
    id json = @{ @"method": @"get", @"uri": uri, @"status": @404 };
    VCRCassette *cassette = [[VCRCassette alloc] initWithJSON:@[ json ]];
    [[VCRCassetteManager defaultManager] setCurrentCassette:cassette];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:uri]];
    VCRRecording *recording = [[[VCRCassetteManager defaultManager] currentCassette] recordingForRequest:request];
    VCRTestConnectionController *controller = [self sendRequest:request];
    XCTAssertEqualObjects(controller.data, recording.data, @"Received data should equal recorded data");
    XCTAssertEqual(controller.response.statusCode, recording.statusCode, @"");
}

#pragma Helpers

- (VCRTestConnectionController *)sendRequest:(NSURLRequest *)request {
    XCTestExpectation *expectation = [self expectationWithDescription:nil];
    VCRTestConnectionController *controller = [[VCRTestConnectionController alloc] init];
    [controller sendRequest:request completion:^{
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:60 handler:nil];
    return controller;
}

@end


@implementation VCRTestConnectionController
{
    dispatch_block_t _completion;
}

- (void)sendRequest:(NSURLRequest *)request completion:(void (^)())completion {
    _completion = completion;
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    self.response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSMutableData *currentData = [NSMutableData dataWithData:self.data];
    [currentData appendData:data];
    self.data = currentData;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _completion();
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    _error = error;
    _completion();
}

@end
