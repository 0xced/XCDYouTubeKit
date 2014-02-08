//
//  XCDYouTubeExtractor.h
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Adrien Truong on 2/5/14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCDYoutubeConstants.h"

/*
 Returned dictionary contains keys for all video qualities and metadata found.
 
 Possible Keys:
 @(XCDYouTubeVideoQualitySmall240)
 @(XCDYouTubeVideoQualityMedium360)
 @(XCDYouTubeVideoQualityHD720)
 @(XCDYouTubeVideoQualityHD1080)
 XCDMetadataKeyTitle
 XCDMetadataKeySmallThumbnailURL
 XCDMetadataKeyMediumThumbnailURL
 XCDMetadataKeyLargeThumbnailURL
 */
typedef void (^XCDYoutubeExtractorCompletionHandler)(NSDictionary *, NSError *);

@interface XCDYouTubeExtractor : NSObject

@property (nonatomic, copy, readonly) NSString *videoIdentifier;
@property (nonatomic, readonly, getter = isExtracting) BOOL extracting;

+ (instancetype) extractorWithVideoIdentifier:(NSString *)videoIdentifier;
- (instancetype) initWithVideoIdentifier:(NSString *)videoIdentifier;

- (void) startWithCompletionHandler:(XCDYoutubeExtractorCompletionHandler)completionHandler;
- (void) cancel;

@end
