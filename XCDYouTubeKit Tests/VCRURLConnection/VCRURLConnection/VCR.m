//
// VCR.m
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

#import "VCR.h"
#import "VCR+NSURLSessionConfiguration.h"
#import "VCRCassette.h"
#import "VCRCassetteManager.h"
#import "VCRRecordingURLProtocol.h"
#import "VCRReplayingURLProtocol.h"
#import <objc/runtime.h>

static BOOL _VCRIsRecording;
static BOOL _VCRIsReplaying;
static NSArray *_VCRCookies;


@implementation VCR

+ (void)loadCassetteWithContentsOfURL:(NSURL *)url {
    [[VCRCassetteManager defaultManager] setCurrentCassetteURL:url];
}

+ (VCRCassette *)cassette {
    return [[VCRCassetteManager defaultManager] currentCassette];
}

+ (void)addProtocols {
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        [NSURLProtocol registerClass:[VCRRecordingURLProtocol class]];
        [NSURLProtocol registerClass:[VCRReplayingURLProtocol class]];
        VCRAddProtocolsToNSURLSessionConfiguration();
    });
}

+ (void)setRecording:(BOOL)recording {
    if (recording) [self addProtocols];
    _VCRIsRecording = recording;
}

+ (BOOL)isRecording {
    return _VCRIsRecording;
}

+ (void)setReplaying:(BOOL)replaying {
    if (replaying) [self addProtocols];
    _VCRIsReplaying = replaying;
}

+ (BOOL)isReplaying {
    return _VCRIsReplaying;
}

+ (void)start {
    [self setRecording:YES];
    [self setReplaying:YES];
}

+ (void)stop {
	for (NSHTTPCookie *cookie in _VCRCookies) {
		[[NSHTTPCookieStorage sharedHTTPCookieStorage]deleteCookie:cookie];
	}
    [self setRecording:NO];
    [self setReplaying:NO];
}

+ (void)save:(NSString *)path {
    return [[VCRCassetteManager defaultManager] save:path];
}

+ (NSArray<NSHTTPCookie *> *)cookies {
	return  _VCRCookies;
}

+ (void)setCookies:(NSArray<NSHTTPCookie *> *)cookies {
	if (_VCRCookies != cookies) {
		_VCRCookies = cookies;
	}
}

@end


