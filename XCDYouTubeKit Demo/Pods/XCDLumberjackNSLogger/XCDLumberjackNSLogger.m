//
//  Copyright (c) 2015 Cédric Luthi. All rights reserved.
//

#import "XCDLumberjackNSLogger.h"

@implementation XCDLumberjackNSLogger

- (instancetype) init
{
	return [self initWithBonjourServiceName:nil];
}

- (instancetype) initWithBonjourServiceName:(NSString *)bonjourServiceName
{
	if (!(self = [super init]))
		return nil;
	
	_logger = LoggerInit();
	LoggerSetupBonjour(_logger, NULL, (__bridge CFStringRef)bonjourServiceName);
	LoggerSetOptions(_logger, _logger->options & ~kLoggerOption_CaptureSystemConsole);
	
	return self;
}

- (void) dealloc
{
	LoggerStop(self.logger);
}

#pragma mark - DDLogger

@synthesize logFormatter = _logFormatter;

- (NSString *) loggerName
{
	return @"cocoa.lumberjack.NSLogger";
}

- (void) didAddLogger
{
	LoggerStart(self.logger);
}

- (void) flush
{
	LoggerFlush(self.logger, NO);
}

- (void) logMessage:(DDLogMessage *)logMessage
{
	int level = log2f(logMessage.flag);
	NSString *tag = self.tags[@(logMessage.context)];
	LogMessageToF(self.logger, logMessage.fileName.UTF8String, (int)logMessage.line, logMessage.function.UTF8String, tag, level, @"%@", logMessage.message);
}

@end
