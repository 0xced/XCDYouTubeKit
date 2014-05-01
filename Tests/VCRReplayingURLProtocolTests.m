//
//  VCRReplayingURLProtocolTests.m
//  VCRURLConnection
//
//  Created by Dustin Barker on 1/3/14.
//
//

#import <XCTest/XCTest.h>
#import "VCRReplayingURLProtocol.h"
#import "VCR.h"
#import "VCRRecording.h"
#import "VCRCassetteManager.h"

@interface VCRReplayingURLProtocolTests : XCTestCase

@end

@implementation VCRReplayingURLProtocolTests

- (void)testCanInitWithRequest {
    NSURL *url = [NSURL URLWithString:@"http://www.example.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    VCRRecording *recording = [[VCRRecording alloc] init];
    recording.URI = [url absoluteString];
    recording.method = request.HTTPMethod;
    [[[VCRCassetteManager defaultManager] currentCassette] addRecording:recording];
    
    [VCR start];
    
    XCTAssert([VCRReplayingURLProtocol canInitWithRequest:request], @"");
}

- (void)testCannotInitWithRequest {
    [VCR stop];
    NSURL *url = [NSURL URLWithString:@"http://www.example.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    XCTAssertFalse([VCRReplayingURLProtocol canInitWithRequest:request], @"");
}

@end
