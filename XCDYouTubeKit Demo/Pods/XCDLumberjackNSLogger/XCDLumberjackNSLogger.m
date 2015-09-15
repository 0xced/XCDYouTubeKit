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

static NSData * MessageAsData(NSString *message);

static void SetThreadNameWithMessage(DDLogMessage *logMessage)
{
	// There is no _thread name_ parameter for LogXXXToF functions, but we can abuse NSLogger’s thread name caching mechanism which uses the current thread dictionary
	NSString *queueLabel = [logMessage.queueLabel isEqualToString:@"com.apple.main-thread"] ? @"Main Queue" : logMessage.queueLabel;
	NSThread.currentThread.threadDictionary[@"__$NSLoggerThreadName$__"] = [NSString stringWithFormat:@"%@ [%@]", logMessage.threadID, queueLabel];
}

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
	NSData *data = MessageAsData(logMessage.message);
	SetThreadNameWithMessage(logMessage);
	if (data)
		LogDataToF(self.logger, logMessage.fileName.UTF8String, (int)logMessage.line, logMessage.function.UTF8String, tag, level, data);
	else
		LogMessageRawToF(self.logger, logMessage.fileName.UTF8String, (int)logMessage.line, logMessage.function.UTF8String, tag, level, logMessage.message);
}

#pragma mark - NSObject

- (NSString *) debugDescription
{
	NSMutableString *debugDescription = [NSMutableString stringWithString:[super debugDescription]];
	NSString *bonjourServiceName = (__bridge NSString *)self.logger->bonjourServiceName;
	NSString *viewerHost = (__bridge NSString *)self.logger->host;
	uint32_t options = self.logger->options;
	NSDictionary *tags = self.tags;
	
	if (bonjourServiceName)
		[debugDescription appendFormat:@"\n\tBonjour Service Name: %@", bonjourServiceName];
	if (viewerHost)
		[debugDescription appendFormat:@"\n\tViewer Host: %@:%@", viewerHost, @(self.logger->port)];
	
	[debugDescription appendString:@"\n\tOptions:"];
	[debugDescription appendFormat:@"\n\t\tLog To Console:               %@", options & kLoggerOption_LogToConsole              ? @"YES" : @"NO"];
	[debugDescription appendFormat:@"\n\t\tCapture System Console:       %@", options & kLoggerOption_CaptureSystemConsole      ? @"YES" : @"NO"];
	[debugDescription appendFormat:@"\n\t\tBuffer Logs Until Connection: %@", options & kLoggerOption_BufferLogsUntilConnection ? @"YES" : @"NO"];
	[debugDescription appendFormat:@"\n\t\tBrowse Bonjour:               %@", options & kLoggerOption_BrowseBonjour             ? @"YES" : @"NO"];
	[debugDescription appendFormat:@"\n\t\tBrowse Only Local Domain:     %@", options & kLoggerOption_BrowseOnlyLocalDomain     ? @"YES" : @"NO"];
	[debugDescription appendFormat:@"\n\t\tUse SSL:                      %@", options & kLoggerOption_UseSSL                    ? @"YES" : @"NO"];
	
	if (tags.count > 0)
	{
		[debugDescription appendString:@"\n\tTags:"];
		for (NSNumber *context in [[tags allKeys] sortedArrayUsingSelector:@selector(compare:)])
			[debugDescription appendFormat:@"\n\t\t%@ -> %@", context, tags[context]];
	}
	return [debugDescription copy];
}

@end

static NSData * MessageAsData(NSString *message)
{
	if ([message hasPrefix:@"<"] && [message hasSuffix:@">"])
	{
		message = [message substringWithRange:NSMakeRange(1, message.length - 2)];
		message = [message stringByReplacingOccurrencesOfString:@" " withString:@""];
		NSCharacterSet *hexadecimalCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefABCDEF"];
		if (message.length % 2 == 0 && [message rangeOfCharacterFromSet:hexadecimalCharacterSet.invertedSet].location == NSNotFound)
		{
			NSMutableData *data = [NSMutableData new];
			char chars[3] = {'\0','\0','\0'};
			for (NSUInteger i = 0; i < message.length / 2; i++)
			{
				chars[0] = [message characterAtIndex:i*2];
				chars[1] = [message characterAtIndex:i*2 + 1];
				uint8_t byte = strtol(chars, NULL, 16);
				[data appendBytes:&byte length:sizeof(byte)];
			}
			return data;
		}
	}
	return nil;
}
