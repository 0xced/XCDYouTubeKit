//
//  XCDYouTubeVideo.h
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Cédric Luthi on 17.03.14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCDYouTubeVideo : NSObject

- (instancetype) initWithData:(NSData *)data error:(NSError **)error;

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *title;

@property (nonatomic, readonly) NSURL *smallThumbnailURL;
@property (nonatomic, readonly) NSURL *mediumThumbnailURL;
@property (nonatomic, readonly) NSURL *largeThumbnailURL;

@end
