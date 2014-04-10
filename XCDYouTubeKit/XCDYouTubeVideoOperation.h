//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <XCDYouTubeKit/XCDYouTubeOperation.h>
#import <XCDYouTubeKit/XCDYouTubeVideo.h>

@interface XCDYouTubeVideoOperation : NSOperation <XCDYouTubeOperation>

- (instancetype) initWithVideoIdentifier:(NSString *)videoIdentifier languageIdentifier:(NSString *)languageIdentifier;

@property (atomic, readonly) NSError *error;
@property (atomic, readonly) XCDYouTubeVideo *video;

@end
