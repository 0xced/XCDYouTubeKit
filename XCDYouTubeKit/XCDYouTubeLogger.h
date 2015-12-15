//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

// From CocoaLumberjack's DDLog.h
typedef NS_OPTIONS(NSUInteger, DDLogFlag) {
	DDLogFlagError      = (1 << 0), // 0...00001
	DDLogFlagWarning    = (1 << 1), // 0...00010
	DDLogFlagInfo       = (1 << 2), // 0...00100
	DDLogFlagDebug      = (1 << 3), // 0...01000
	DDLogFlagVerbose    = (1 << 4), // 0...10000
	DDLogFlagTrace      = (1 << 5)  // 0..100000 (custom level not present in DDLog.h)
};

__attribute__((visibility("hidden")))
@interface XCDYouTubeLogger : NSObject
+ (void) logMessage:(NSString * (^)(void))message flag:(DDLogFlag)flag file:(const char *)file function:(const char *)function line:(NSUInteger)line;
@end

#define XCDYouTubeLog(_flag, _message) [XCDYouTubeLogger logMessage:(_message) flag:(_flag) file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__]

#define XCDYouTubeLogError(format, ...)   XCDYouTubeLog(DDLogFlagError,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogWarning(format, ...) XCDYouTubeLog(DDLogFlagWarning, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogInfo(format, ...)    XCDYouTubeLog(DDLogFlagInfo,    (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogDebug(format, ...)   XCDYouTubeLog(DDLogFlagDebug,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogVerbose(format, ...) XCDYouTubeLog(DDLogFlagVerbose, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogTrace(format, ...)   XCDYouTubeLog(DDLogFlagTrace,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
