//
// VCRRequestKeyTests.m
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

#import "VCRRequestKeyTests.h"
#import "VCRRequestKey.h"

@interface VCRRequestKeyTests ()
@property (nonatomic, strong) VCRRequestKey *key1;
@property (nonatomic, strong) VCRRequestKey *key2;
@end

@implementation VCRRequestKeyTests

- (void)setUp {
    NSString *path = @"http://foo/bar";
    
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:url];
    self.key1 = [VCRRequestKey keyForObject:request1];

    VCRRecording *recording = [[VCRRecording alloc] init];
    recording.method = @"GET";
    recording.URI = path;
    self.key2 = [VCRRequestKey keyForObject:recording];
}

- (void)testIsEqual {
    XCTAssertEqualObjects(self.key1, self.key2, @"Key objects should be equal");
}

- (void)testHash {
    XCTAssertEqual([self.key1 hash], [self.key2 hash], @"Key hashes should be equal");
}

- (void)testAsDictionaryKey {
    NSDictionary *dictionary = @{ self.key1: @"Foo" };    
    XCTAssertEqualObjects([dictionary objectForKey:self.key2], @"Foo", @"Can lookup with equivalent key");
}

@end
