//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XCDYouTubeVideoQuality) {
	XCDYouTubeVideoQualitySmall240  = 36,
	XCDYouTubeVideoQualityMedium360 = 18,
	XCDYouTubeVideoQualityHD720     = 22,
	XCDYouTubeVideoQualityHD1080    = 37,
};

@interface XCDYouTubeVideo : NSObject <NSCopying>

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *title;

@property (nonatomic, readonly) NSURL *smallThumbnailURL;
@property (nonatomic, readonly) NSURL *mediumThumbnailURL;
@property (nonatomic, readonly) NSURL *largeThumbnailURL;

@property (nonatomic, readonly) NSDictionary *streamURLs;

@end
