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
// Compatible with CocoaLumberjack's DDLog interface
+ (void) log:(BOOL)asynchronous level:(NSUInteger)level flag:(DDLogFlag)flag context:(NSInteger)context file:(const char *)file function:(const char *)function line:(NSUInteger)line tag:(id)tag format:(NSString *)format, ... NS_FORMAT_FUNCTION(9,10);
@end

extern Class XCDYouTubeLogClass(void);

#define XCDYouTubeLog(_flag, _format, ...) [XCDYouTubeLogClass() log:YES level:NSUIntegerMax flag:(_flag) context:(NSInteger)0xced70676 file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__ tag:nil format:(_format), ##__VA_ARGS__]

#define XCDYouTubeLogError(format, ...)   XCDYouTubeLog(DDLogFlagError,   format, ##__VA_ARGS__)
#define XCDYouTubeLogWarning(format, ...) XCDYouTubeLog(DDLogFlagWarning, format, ##__VA_ARGS__)
#define XCDYouTubeLogInfo(format, ...)    XCDYouTubeLog(DDLogFlagInfo,    format, ##__VA_ARGS__)
#define XCDYouTubeLogDebug(format, ...)   XCDYouTubeLog(DDLogFlagDebug,   format, ##__VA_ARGS__)
#define XCDYouTubeLogVerbose(format, ...) XCDYouTubeLog(DDLogFlagVerbose, format, ##__VA_ARGS__)
#define XCDYouTubeLogTrace(format, ...)   XCDYouTubeLog(DDLogFlagTrace,   format, ##__VA_ARGS__)
