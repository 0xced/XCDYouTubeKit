//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeLogger.h"

@implementation XCDYouTubeLogger

+ (void) log:(BOOL)asynchronous level:(NSUInteger)level flag:(DDLogFlag)flag context:(NSInteger)context file:(const char *)file function:(const char *)function line:(NSUInteger)line tag:(id)tag format:(NSString *)format, ...
{
	char *logLevelString = getenv("XCDYouTubeKitLogLevel");
	NSUInteger logLevel = logLevelString ? strtoul(logLevelString, NULL, 0) : DDLogFlagError | DDLogFlagWarning;
	if (!(flag & logLevel))
		return;
	
	va_list arguments;
	va_start(arguments, format);
	NSLog(@"[XCDYouTubeKit] %@", [[NSString alloc] initWithFormat:format arguments:arguments]);
	va_end(arguments);
}

@end

Class XCDYouTubeLogClass(void)
{
	static Class logClass;
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		logClass = NSClassFromString(@"DDLog");
		if (![logClass methodSignatureForSelector:@selector(log:level:flag:context:file:function:line:tag:format:)])
			logClass = [XCDYouTubeLogger class];
	});
	return logClass;
}
