//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((visibility("hidden")))
@interface XCDYouTubeVideoWebpage : NSObject

- (instancetype) initWithHTMLString:(NSString *)html;

@property (nonatomic, readonly) NSDictionary *playerConfiguration;
@property (nonatomic, readonly) NSDictionary *videoInfo;
@property (nonatomic, readonly) NSURL *javaScriptPlayerURL;
@property (nonatomic, readonly) BOOL isAgeRestricted;

@end
