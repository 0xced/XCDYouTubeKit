//
//  XCDYouTubeVideoOperation.h
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Cédric Luthi on 31.03.14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <XCDYouTubeVideoPlayerViewController/XCDYouTubeOperation.h>
#import <XCDYouTubeVideoPlayerViewController/XCDYouTubeVideo.h>

@interface XCDYouTubeVideoOperation : NSOperation <XCDYouTubeOperation>

- (instancetype) initWithVideoIdentifier:(NSString *)videoIdentifier languageIdentifier:(NSString *)languageIdentifier;

@property (atomic, readonly) NSError *error;
@property (atomic, readonly) XCDYouTubeVideo *video;

@end
