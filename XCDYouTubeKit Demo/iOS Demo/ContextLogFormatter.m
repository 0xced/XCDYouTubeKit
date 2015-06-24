//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "ContextLogFormatter.h"

@interface ContextLogFormatter ()

@property (nonatomic, strong) NSDictionary *levels;
@property (nonatomic, assign) DDLogLevel defaultLevel;

@end

@implementation ContextLogFormatter

- (instancetype) initWithLevels:(NSDictionary *)levels defaultLevel:(DDLogLevel)defaultLevel
{
	if (!(self = [super init]))
		return nil;
	
	_levels = levels;
	_defaultLevel = defaultLevel;
	
	return self;
}

- (NSString *) formatLogMessage:(DDLogMessage *)logMessage
{
	NSNumber *contextLevel = self.levels[@(logMessage.context)];
	DDLogLevel level = contextLevel ? [contextLevel unsignedIntegerValue] : self.defaultLevel;
	return logMessage.flag & level ? logMessage.message : nil;
}

@end
