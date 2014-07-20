//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((visibility("hidden")))
@interface XCDYouTubeVideoWebpage : NSObject

- (instancetype) initWithData:(NSData *)data response:(NSURLResponse *)response;

@property (nonatomic, readonly) NSDictionary *videoInfo;
@property (nonatomic, readonly) NSURL *javaScriptPlayerURL;

@end
