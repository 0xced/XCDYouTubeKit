//
// VCRReplayingURLProtocol.m
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

#import "VCRReplayingURLProtocol.h"
#import "VCRCassette.h"
#import "VCRCassetteManager.h"
#import "VCRRecording.h"
#import "VCR.h"

@implementation VCRReplayingURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return [VCR isReplaying] && [self recordingForRequest:request] && ([request.URL.scheme isEqualToString:@"https"] || [request.URL.scheme isEqualToString:@"http"]);
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

+ (VCRRecording *)recordingForRequest:(NSURLRequest *)request {
    VCRCassette *cassette = [[VCRCassetteManager defaultManager] currentCassette];
    return [cassette recordingForRequest:request];
}

- (void)startLoading {
    VCRRecording *recording = [[self class] recordingForRequest:self.request];
    NSError *error = recording.error;
    if (!error) {
        NSURL *url = [NSURL URLWithString:recording.URI];
        NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:url
                                                                  statusCode:recording.statusCode
                                                                 HTTPVersion:@"HTTP/1.1"
                                                                headerFields:recording.headerFields];
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:recording.data];
        [self.client URLProtocolDidFinishLoading:self];
    } else {
        [self.client URLProtocol:self didFailWithError:error];
    }
}

- (void)stopLoading {
    // do nothing
}

@end
