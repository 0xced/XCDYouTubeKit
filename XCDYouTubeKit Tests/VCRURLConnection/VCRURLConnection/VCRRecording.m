//
// VCRRecording.m
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

#import "VCRRecording.h"
#import "VCROrderedMutableDictionary.h"
#import "VCRErrorSerialization.h"
#if TARGET_OS_IPHONE
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <CoreServices/CoreServices.h>
#endif

// For -[NSData initWithBase64Encoding:] and -[NSData base64Encoding]
// Remove when targetting iOS 7+, use -[NSData initWithBase64EncodedString:options:] and -[NSData base64EncodedStringWithOptions:] instead
#pragma clang diagnostic ignored "-Wdeprecated"

@implementation VCRRecording

- (id)initWithJSON:(id)json {
    if ((self = [self init])) {
        
        self.method = json[@"method"];
        NSAssert(self.method, @"VCRRecording: method is required");
        
        self.URI = json[@"uri"];
        NSAssert(self.URI, @"VCRRecording: uri is required");

        self.statusCode = [json[@"status"] intValue];

        self.headerFields = json[@"headers"];
        if (!self.headerFields) {
            self.headerFields = [NSDictionary dictionary];
        }
        
        NSString *body = json[@"body"];
        [self setBody:body];
        
        if (json[@"error"]) {
            self.error = ErrorWithJSON(json[@"error"]);
        }
    }
    return self;
}

- (BOOL)isEqual:(VCRRecording *)recording {
    return [self.method isEqualToString:recording.method] &&
           [self.URI isEqualToString:recording.URI] &&
           [self.body isEqualToString:recording.body];
}

- (NSUInteger)hash {
    const NSUInteger prime = 17;
    NSUInteger hash = 1;
    hash = prime * hash + [self.method hash];
    hash = prime * hash + [self.URI hash];
    hash = prime * hash + [self.body hash];
    return hash;
}

- (BOOL)isText {
    NSString *type = [[self HTTPURLResponse] MIMEType] ?: @"text/plain";
    if ([@[ @"application/x-www-form-urlencoded" ] containsObject:type]) {
        return YES;
    }
    CFStringRef uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)type, NULL);
    BOOL isText = UTTypeConformsTo(uti, kUTTypeText);
    if (uti) {
        CFRelease(uti);
    }
    return isText;
}

- (void)setBody:(id)body
{
    if ([body isKindOfClass:[NSDictionary class]]) {
        self.data = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    } else if ([self isText]) {
        self.data = [body dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([body isKindOfClass:[NSString class]]) {
        self.data = [[NSData alloc] initWithBase64Encoding:body];
    }
}

- (NSString *)body {
    if ([self isText]) {
        return [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    } else {
        return [self.data base64Encoding];
    }
}

- (id)JSON {
    NSDictionary *infoDict = @{@"method": self.method, @"status": @(self.statusCode), @"uri": self.URI};
    VCROrderedMutableDictionary *dictionary = [VCROrderedMutableDictionary dictionaryWithDictionary:infoDict];
    
    if (self.headerFields) {
        dictionary[@"headers"] = self.headerFields;
    }
    
    if (self.body) {
        dictionary[@"body"] = self.body;
    }
    
    NSError *error = self.error;
    if (error) {
        dictionary[@"error"] = JSONWithError(error);
    }
    
    VCROrderedMutableDictionary *sortedDict = [VCROrderedMutableDictionary dictionaryWithCapacity:[infoDict count]];
    [[dictionary sortedKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        sortedDict[key] = dictionary[key];
    }];
    
    return sortedDict;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"<VCRRecording %@ %@, data length %li>", self.method, self.URI, (unsigned long)[self.data length]];
}

- (NSHTTPURLResponse *)HTTPURLResponse {
    NSURL *url = [NSURL URLWithString:_URI];
    return [[NSHTTPURLResponse alloc] initWithURL:url
                                       statusCode:_statusCode
                                      HTTPVersion:@"HTTP/1.1"
                                     headerFields:_headerFields];
}

@end

