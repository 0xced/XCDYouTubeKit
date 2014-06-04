//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

@interface PlayerEventLogger : NSObject

+ (instancetype) sharedLogger;

@property (nonatomic, assign, getter = isEnabled) BOOL enabled; // defaults to `NO`

@end
