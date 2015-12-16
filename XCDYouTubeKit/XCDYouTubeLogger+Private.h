//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XCDYouTubeLogger.h"

@interface XCDYouTubeLogger ()

+ (void) logMessage:(NSString * (^)(void))message flag:(XCDLogFlag)flag file:(const char *)file function:(const char *)function line:(NSUInteger)line;

@end

#define XCDYouTubeLog(_flag, _message) [XCDYouTubeLogger logMessage:(_message) flag:(_flag) file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__]

#define XCDYouTubeLogError(format, ...)   XCDYouTubeLog(XCDLogFlagError,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogWarning(format, ...) XCDYouTubeLog(XCDLogFlagWarning, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogInfo(format, ...)    XCDYouTubeLog(XCDLogFlagInfo,    (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogDebug(format, ...)   XCDYouTubeLog(XCDLogFlagDebug,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogVerbose(format, ...) XCDYouTubeLog(XCDLogFlagVerbose, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define XCDYouTubeLogTrace(format, ...)   XCDYouTubeLog(XCDLogFlagTrace,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
