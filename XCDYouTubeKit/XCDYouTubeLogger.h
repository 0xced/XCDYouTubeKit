//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSInteger XCDYouTubeKitLumberjackContext;

typedef NS_ENUM(NSUInteger, XCDLogLevel) {
	XCDLogLevelError      = 0,
	XCDLogLevelWarning    = 1,
	XCDLogLevelInfo       = 2,
	XCDLogLevelDebug      = 3,
	XCDLogLevelVerbose    = 4,
	XCDLogLevelTrace      = 5
};

@interface XCDYouTubeLogger : NSObject

+ (void) setLogHandler:(void (^)(NSString * (^message)(void), XCDLogLevel level, const char *file, const char *function, NSUInteger line))logHandler;

@end
