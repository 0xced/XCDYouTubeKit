//
//  XCDYouTubeClient.h
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Cédric Luthi on 17.03.14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <XCDYouTubeVideoPlayerViewController/XCDYouTubeOperation.h>
#import <XCDYouTubeVideoPlayerViewController/XCDYouTubeVideo.h>

@interface XCDYouTubeClient : NSObject

- (instancetype) initWithLanguageIdentifier:(NSString *)languageIdentifier;

@property (nonatomic, readonly) NSString *languageIdentifier;

- (id<XCDYouTubeOperation>) getVideoWithIdentifier:(NSString *)videoIdentifier completionHandler:(void (^)(XCDYouTubeVideo *video, NSError *error))completionHandler;

@end
