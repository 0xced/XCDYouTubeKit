//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

// Matching DDLogFlag from CocoaLumberjack's DDLog.h
typedef NS_OPTIONS(NSUInteger, XCDLogFlag) {
	XCDLogFlagError      = (1 << 0), // 0...00001
	XCDLogFlagWarning    = (1 << 1), // 0...00010
	XCDLogFlagInfo       = (1 << 2), // 0...00100
	XCDLogFlagDebug      = (1 << 3), // 0...01000
	XCDLogFlagVerbose    = (1 << 4), // 0...10000
	XCDLogFlagTrace      = (1 << 5)  // 0..100000 (custom level not present in DDLog.h)
};

__attribute__((visibility("hidden")))
@interface XCDYouTubeLogger : NSObject
+ (void) logMessage:(NSString * (^)(void))message flag:(XCDLogFlag)flag file:(const char *)file function:(const char *)function line:(NSUInteger)line;
@end

extern void XCDYouTubeSetLogHandler(void (^handler)(NSString * (^message)(void), XCDLogFlag flag, const char *file, const char *function, NSUInteger line));

#define XCDYouTubeLog(_flag, _message) [XCDYouTubeLogger logMessage:(_message) flag:(_flag) file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__]

#define XCDYouTubeLogError(format, ...)   XCDYouTubeLog(XCDLogFlagError,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogWarning(format, ...) XCDYouTubeLog(XCDLogFlagWarning, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogInfo(format, ...)    XCDYouTubeLog(XCDLogFlagInfo,    (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogDebug(format, ...)   XCDYouTubeLog(XCDLogFlagDebug,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogVerbose(format, ...) XCDYouTubeLog(XCDLogFlagVerbose, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogTrace(format, ...)   XCDYouTubeLog(XCDLogFlagTrace,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
