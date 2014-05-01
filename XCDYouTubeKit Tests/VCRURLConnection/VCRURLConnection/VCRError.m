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

#import "VCRError.h"

// For -[NSData initWithBase64Encoding:] and -[NSData base64Encoding]
// Remove when targetting iOS 7+, use -[NSData initWithBase64EncodedString:options:] and -[NSData base64EncodedStringWithOptions:] instead
#pragma clang diagnostic ignored "-Wdeprecated"

@interface VCRError ()
@property (nonatomic, copy) NSString *vcr_localizedDescription;
@end

@implementation VCRError

+ (id)JSONForError:(NSError *)error {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary addEntriesFromDictionary:@{ @"code": @(error.code),
                                            @"domain": error.domain,
                                            @"localizedDescription": error.localizedDescription }];
    if ([error.userInfo count] > 0) {
        dictionary[@"userInfo"] = [self serializedUserInfo:error.userInfo];
    }
    return dictionary;
}

+ (NSString *)serializedUserInfo:(NSDictionary *)userInfo {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    return [data base64Encoding];
}

+ (NSDictionary *)deserializedUserInfo:(NSString *)string {
    NSData *data = string ? [[NSData alloc] initWithBase64Encoding:string] : [NSData data];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (id)initWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)userInfo localizedDescription:(NSString *)localizedDescription {
    self = [super initWithDomain:domain code:code userInfo:userInfo];
    if (self) {
        self.vcr_localizedDescription = localizedDescription;
    }
    return self;
}

- (id)initWithJSON:(id)json {
    return [self initWithDomain:json[@"domain"]
                           code:[json[@"code"] integerValue]
                       userInfo:[[self class] deserializedUserInfo:json[@"userInfo"]]
           localizedDescription:json[@"localizedDescription"]];
}

- (NSString *)localizedDescription {
    return self.vcr_localizedDescription;
}

@end
