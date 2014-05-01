//
// VCRCassetteManagerTests.m
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

#import "VCRCassetteManagerTests.h"
#import "VCRCassetteManager.h"
#import "VCRCassette.h"


@interface VCRCassetteManagerTests ()
@property (nonatomic, strong) VCRCassetteManager *manager;
@end


@implementation VCRCassetteManagerTests

- (void)setUp {
    [super setUp];
    self.manager = [[VCRCassetteManager alloc] init];
}

- (void)tearDown {
    self.manager = nil;
    [super tearDown];
}

- (void)testSetCurrentCassetteWithURL {

#if TARGET_OS_IPHONE
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"cassette-1" ofType:@"json"];
#else
    NSString *path = @"Tests/cassette-1.json";
#endif
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    XCTAssertTrue(data != nil, @"Could not load cassette %@", url);
    VCRCassette *expectedCassette = [[VCRCassette alloc] initWithData:data];
    [self.manager setCurrentCassetteURL:url];
    
    XCTAssertEqualObjects(self.manager.currentCassette, expectedCassette, @"Should set cassette with URL");
}

@end
