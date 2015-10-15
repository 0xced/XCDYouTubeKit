//
// VCRCassetteTests.m
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

#import "VCRCassetteTests.h"
#import "VCRCassette.h"
#import "VCRCassette_Private.h"
#import "VCRRequestKey.h" // FIXME: don't import

@interface VCRCassetteTests ()
@property (nonatomic, strong) id recording1;
@property (nonatomic, strong) id recordings;
@property (nonatomic, strong) VCRCassette *cassette;
@end

@implementation VCRCassetteTests

- (void)setUp {
    [super setUp];
    self.recording1 = @{ @"method": @"get", @"uri": @"http://foo", @"body": @"Foo Bar Baz" };
    self.recordings = @[ self.recording1 ];
    self.cassette = [VCRCassette cassette];
}

- (void)tearDown {
    self.recording1 = nil;
    self.recordings = nil;
    self.cassette = nil;
    [super tearDown];
}

- (void)testInit {
    VCRCassette *cassette = [VCRCassette cassette];
    XCTAssertNotNil(cassette.responseDictionary, @"Must have response dictionary");
}

- (void)testInitWithData {
    id json = self.recordings;
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    VCRCassette *expectedCassette = [[VCRCassette alloc] initWithJSON:json];
    VCRCassette *cassette = [[VCRCassette alloc] initWithData:data];
    XCTAssertEqualObjects(cassette, expectedCassette, @"");
}

- (void)testInitWithJSON {
    NSURL *url = [NSURL URLWithString:[self.recording1 objectForKey:@"uri"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    VCRRecording *expectedRecording = [[VCRRecording alloc] initWithJSON:self.recording1];
    VCRCassette *cassette = [[VCRCassette alloc] initWithJSON:self.recordings];
    VCRRecording *actualRecording = [cassette recordingForRequest:request];
    XCTAssertEqualObjects(actualRecording, expectedRecording, @"Should get expected recording");
}

- (void)testInitWithNilJSON {
    XCTAssertThrows((void) [[VCRCassette alloc] initWithJSON:nil], @"Cannot init with nil json");
}

- (void)testInitWithNilData {
    XCTAssertThrows((void) [[VCRCassette alloc] initWithData:nil], @"Cannot init with nil data");
}

- (void)testInitWithInvalidData {
    NSString *invalidJSON = @"{";
    NSData *data = [invalidJSON dataUsingEncoding:NSUTF8StringEncoding];
    XCTAssertThrows((void) [[VCRCassette alloc] initWithData:data], @"Cannot init with invalid data");
}

// FIXME: test with image data

- (void)testIsEqual {
    VCRCassette *cassette1 = [[VCRCassette alloc] initWithJSON:self.recordings];
    VCRCassette *cassette2 = [[VCRCassette alloc] initWithJSON:self.recordings];
    XCTAssertEqualObjects(cassette1, cassette2, @"Cassettes should be equal");
}

- (void)testRecordingForRequest {
    NSString *path = @"http://foo";
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    id json = @{ @"method": @"GET", @"uri": path, @"body": @"Foo Bar Baz" };
    VCRRecording *recording = [[VCRRecording alloc] initWithJSON:json];
    
    VCRCassette *cassette = self.cassette;
    [cassette addRecording:recording];
    XCTAssertEqualObjects([cassette recordingForRequest:request], recording, @"");
    
    // can retrieve with equivalent mutable request
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url];
    XCTAssertEqualObjects([cassette recordingForRequest:request1], recording, @"");
}

- (void)testKeyOrderingForJson {
    id json = @{ @"method": @"get", @"uri": @"http://foo", @"body": @"GET Foo Bar Baz" };
    VCRRecording *recording = [[VCRRecording alloc] initWithJSON:json];
    id result = [recording JSON];
    NSArray *keys = @[@"body", @"headers", @"method", @"status", @"uri"];
    XCTAssertEqualObjects([result allKeys], keys, @"Cassette JSON keys should be ordered");
}

- (void)testData {
    VCRCassette *cassette = [[VCRCassette alloc] initWithJSON:self.recordings];
    NSData *data = [cassette data];
    XCTAssertTrue(data != nil && [data length] > 0, @"Did not serialize to data");
}

@end
