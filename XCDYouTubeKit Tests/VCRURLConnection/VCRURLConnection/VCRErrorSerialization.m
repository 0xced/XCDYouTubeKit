//
// VCRError.m
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

#import "VCRErrorSerialization.h"

// For -[NSData initWithBase64Encoding:] and -[NSData base64Encoding]
// Remove when targetting iOS 7+, use -[NSData initWithBase64EncodedString:options:] and -[NSData base64EncodedStringWithOptions:] instead
#pragma clang diagnostic ignored "-Wdeprecated"

static NSString * SerializedUserInfo(NSDictionary *userInfo) {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    return [data base64Encoding];
}

static NSDictionary * DeserializedUserInfo(NSString *string) {
    NSData *data = string ? [[NSData alloc] initWithBase64Encoding:string] : [NSData data];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

NSDictionary * JSONWithError(NSError *error) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary addEntriesFromDictionary:@{ @"code": @(error.code),
                                            @"domain": error.domain }];
    if ([error.userInfo count] > 0) {
        dictionary[@"userInfo"] = SerializedUserInfo(error.userInfo);
    }
    return dictionary;
}

extern NSError * ErrorWithJSON(NSDictionary *json) {
    NSString *domain = json[@"domain"];
    NSInteger code = [json[@"code"] integerValue];
    NSDictionary *userInfo = DeserializedUserInfo(json[@"userInfo"]);
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}
