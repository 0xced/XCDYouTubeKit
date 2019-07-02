//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "VCR.h"
#import "VCRCassetteManager.h"

@interface XCDYouTubeKitTestCase : XCTestCase
- (void) setUpTestWithSelector:(SEL)selector;
@property NSArray<NSHTTPCookie *>*cookies;
@end
