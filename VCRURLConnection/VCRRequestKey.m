//
// VCRRequest.m
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

#import "VCRRequestKey.h"

@interface VCRRequestKey ()

- (id)initWithRecording:(VCRRecording *)recording;
- (id)initWithRequest:(NSURLRequest *)request;

@property (nonatomic, strong, readwrite) NSString *URI;
@property (nonatomic, strong, readwrite) NSString *method;

@end

@implementation VCRRequestKey

+ (VCRRequestKey *)keyForObject:(id)object {
    if ([object isKindOfClass:[VCRRecording class]]) {
        return [[VCRRequestKey alloc] initWithRecording:object];
    } else if ([object isKindOfClass:[NSURLRequest class]])  {
        return [[VCRRequestKey alloc] initWithRequest:object];
    } else {
        NSAssert(false, @"Attempted to create VCRRequestKey with invalid object: %@", object);
        return nil;
    }
}

- (id)initWithRecording:(VCRRecording *)recording {
    if ((self = [super init])) {
        self.URI = recording.URI;
        self.method = [recording.method uppercaseString];
    }
    return self;
}

- (id)initWithRequest:(NSURLRequest *)request {
    if ((self = [super init])) {
        self.URI = [request.URL absoluteString];
        self.method = [request.HTTPMethod uppercaseString];
    }
    return self;
}

- (id)JSON {
    return @{ @"uri": self.URI };
}

- (BOOL)isEqual:(VCRRequestKey *)key {
    return [self.method isEqual:key.method] && [self.URI isEqual:key.URI];
}

- (NSUInteger)hash {
    return [self.method hash] ^ [self.URI hash];
}

- (id)copyWithZone:(NSZone *)zone {
    VCRRequestKey *key = [[[self class] alloc] init];
    if (key) {
        key.URI = [self.URI copyWithZone:zone];
        key.method = [self.method copyWithZone:zone];
    }
    return key;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<VCRRequestKey %@ %@>", self.method, self.URI];
}

@end
