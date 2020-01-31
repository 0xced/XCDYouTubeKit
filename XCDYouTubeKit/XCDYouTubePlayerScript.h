//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((visibility("hidden")))
@interface XCDYouTubePlayerScript : NSObject

- (instancetype) initWithString:(NSString *)string;
- (instancetype) initWithString:(NSString *)string additionalPatterns:(NSArray<NSString *> *)customPatterns;

- (NSString *) unscrambleSignature:(NSString *)scrambledSignature;

@end
