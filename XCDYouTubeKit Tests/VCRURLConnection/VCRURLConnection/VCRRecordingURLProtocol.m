//
// VCRRecordingURLProtocol.m
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

#import "VCRRecordingURLProtocol.h"
#import "VCRRecording.h"
#import "VCRCassette.h"
#import "VCRCassetteManager.h"
#import "VCR.h"

static NSString * const VCRIsRecordingRequestKey = @"VCR_recording";

@interface VCRRecordingURLProtocol ()
@property (nonatomic, strong) VCRRecording *recording;
@end

@implementation VCRRecordingURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    BOOL isAlreadyRecordingRequest = [[self propertyForKey:VCRIsRecordingRequestKey inRequest:request] boolValue];
    BOOL isHTTP = [request.URL.scheme isEqualToString:@"https"] || [request.URL.scheme isEqualToString:@"http"];
    return [VCR isRecording] && !isAlreadyRecordingRequest && isHTTP;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
	for (NSHTTPCookie *cookie in [VCR cookies]) {
		[[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookie:cookie];
	}
    return request;
}

- (id)initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id<NSURLProtocolClient >)client {
    return [super initWithRequest:request cachedResponse:nil client:client];
}

- (void)startLoading {
    NSURLRequest *request = self.request;
    VCRRecording *recording = [[VCRRecording alloc] init];
    recording.method = request.HTTPMethod;
    recording.URI = [[request URL] absoluteString];
    self.recording = recording;
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    [[self class] setProperty:@(YES) forKey:VCRIsRecordingRequestKey inRequest:mutableRequest];
    [NSURLConnection connectionWithRequest:mutableRequest delegate:self];
}

- (void)stopLoading {
    // do nothing
}

#pragma mark = NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    self.recording.headerFields = response.allHeaderFields;
    self.recording.statusCode = response.statusCode;
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (self.recording.data) {
        NSMutableData *currentData = [NSMutableData dataWithData:self.recording.data];
        [currentData appendData:data];
        self.recording.data = currentData;
    } else {
        self.recording.data = data;
    }
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.recording.error = error;
    [[[VCRCassetteManager defaultManager] currentCassette] addRecording:self.recording];
    [self.client URLProtocol:self didFailWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[[VCRCassetteManager defaultManager] currentCassette] addRecording:self.recording];
    [self.client URLProtocolDidFinishLoading:self];
}

@end


