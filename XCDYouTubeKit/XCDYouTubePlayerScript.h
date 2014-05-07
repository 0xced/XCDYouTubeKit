//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCDYouTubePlayerScript : NSObject

- (instancetype) initWithString:(NSString *)string;

- (NSString *) unscrambleSignature:(NSString *)scrambledSignature;

@end
