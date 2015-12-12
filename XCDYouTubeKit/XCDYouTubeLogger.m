//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeLogger.h"

@protocol XCDYouTubeLogger_DDLog
// Copied from CocoaLumberjack's DDLog interface
+ (void) log:(BOOL)asynchronous message:(NSString *)message level:(NSUInteger)level flag:(DDLogFlag)flag context:(NSInteger)context file:(const char *)file function:(const char *)function line:(NSUInteger)line tag:(id)tag;
@end

@implementation XCDYouTubeLogger

+ (void) logMessage:(NSString * (^)(void))message flag:(DDLogFlag)flag file:(const char *)file function:(const char *)function line:(NSUInteger)line
{
	Class DDLogClass = NSClassFromString(@"DDLog");
	if ([DDLogClass respondsToSelector:@selector(log:message:level:flag:context:file:function:line:tag:)])
	{
		[DDLogClass log:YES message:message() level:NSUIntegerMax flag:flag context:(NSInteger)0xced70676 file:file function:function line:line tag:nil];
	}
	else
	{
		char *logLevelString = getenv("XCDYouTubeKitLogLevel");
		NSUInteger logLevel = logLevelString ? strtoul(logLevelString, NULL, 0) : DDLogFlagError | DDLogFlagWarning;
		if (!(flag & logLevel))
			return;
		
		NSLog(@"[XCDYouTubeKit] %@", message());
	}
}

@end
