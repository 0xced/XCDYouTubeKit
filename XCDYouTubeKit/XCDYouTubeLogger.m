//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeLogger.h"

#import <objc/runtime.h>

@protocol XCDYouTubeLogger_DDLog
// Copied from CocoaLumberjack's DDLog interface
+ (void) log:(BOOL)asynchronous message:(NSString *)message level:(NSUInteger)level flag:(DDLogFlag)flag context:(NSInteger)context file:(const char *)file function:(const char *)function line:(NSUInteger)line tag:(id)tag;
@end

static void (^const DefaultLogHandler)(NSString *(^)(void), DDLogFlag, const char *, const char *, NSUInteger) = ^(NSString *(^message)(void), DDLogFlag flag, const char *file, const char *function, NSUInteger line)
{
	char *logLevelString = getenv("XCDYouTubeKitLogLevel");
	NSUInteger logLevel = logLevelString ? strtoul(logLevelString, NULL, 0) : DDLogFlagError | DDLogFlagWarning;
	if ((flag & logLevel))
		NSLog(@"[XCDYouTubeKit] %@", message());
};

static Class DDLogClass = Nil;

static void (^const CocoaLumberjackLogHandler)(NSString *(^)(void), DDLogFlag, const char *, const char *, NSUInteger) = ^(NSString *(^message)(void), DDLogFlag flag, const char *file, const char *function, NSUInteger line)
{
	[DDLogClass log:YES message:message() level:NSUIntegerMax flag:flag context:(NSInteger)0xced70676 file:file function:function line:line tag:nil];
};

static void (^LogHandler)(NSString *(^)(void), DDLogFlag, const char *, const char *, NSUInteger);

void XCDYouTubeSetLogHandler(void (^handler)(NSString * (^message)(void), DDLogFlag flag, const char *file, const char *function, NSUInteger line))
{
	LogHandler = handler;
}

@implementation XCDYouTubeLogger

+ (void) initialize
{
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		if (LogHandler)
			return;
		
		LogHandler = DefaultLogHandler;
		
		DDLogClass = objc_lookUpClass("DDLog");
		if (DDLogClass)
		{
			const SEL logSeletor = @selector(log:message:level:flag:context:file:function:line:tag:);
			const char *typeEncoding = method_getTypeEncoding(class_getClassMethod(DDLogClass, logSeletor));
			const char *expectedTypeEncoding = protocol_getMethodDescription(@protocol(XCDYouTubeLogger_DDLog), logSeletor, /* isRequiredMethod: */ YES, /* isInstanceMethod: */ NO).types;
			if (typeEncoding && expectedTypeEncoding && strcmp(typeEncoding, expectedTypeEncoding) == 0)
				LogHandler = CocoaLumberjackLogHandler;
			else
				NSLog(@"[XCDYouTubeKit] Incompatible CocoaLumberjack version. Expected \"%@\", got \"%@\".", expectedTypeEncoding ? @(expectedTypeEncoding) : @"", typeEncoding ? @(typeEncoding) : @"");
		}
	});
}

+ (void) logMessage:(NSString * (^)(void))message flag:(DDLogFlag)flag file:(const char *)file function:(const char *)function line:(NSUInteger)line
{
	if (LogHandler)
		LogHandler(message, flag, file, function, line);
}

@end
