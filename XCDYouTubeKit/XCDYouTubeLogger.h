//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSInteger XCDYouTubeKitLumberjackContext;

// Matching DDLogFlag from CocoaLumberjack's DDLog.h
typedef NS_OPTIONS(NSUInteger, XCDLogFlag) {
	XCDLogFlagError      = (1 << 0), // 0...00001
	XCDLogFlagWarning    = (1 << 1), // 0...00010
	XCDLogFlagInfo       = (1 << 2), // 0...00100
	XCDLogFlagDebug      = (1 << 3), // 0...01000
	XCDLogFlagVerbose    = (1 << 4), // 0...10000
	XCDLogFlagTrace      = (1 << 5)  // 0..100000 (custom level not present in DDLog.h)
};

@interface XCDYouTubeLogger : NSObject

+ (void) setLogHandler:(void (^)(NSString * (^message)(void), XCDLogFlag flag, const char *file, const char *function, NSUInteger line))logHandler;

@end
