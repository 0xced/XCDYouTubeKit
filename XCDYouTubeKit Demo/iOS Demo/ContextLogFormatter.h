//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

@import Foundation;
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface ContextLogFormatter : NSObject <DDLogFormatter>

- (instancetype) initWithLevels:(NSDictionary *)levels defaultLevel:(DDLogLevel)defaultLevel;

@end
