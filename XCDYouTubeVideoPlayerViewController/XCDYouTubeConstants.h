//
//  XCDYouTubeConstants.h
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Adrien Truong on 2/5/14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XCDYouTubeVideoQuality) {
	XCDYouTubeVideoQualitySmall240  = 36,
	XCDYouTubeVideoQualityMedium360 = 18,
	XCDYouTubeVideoQualityHD720     = 22,
	XCDYouTubeVideoQualityHD1080    = 37,
};

FOUNDATION_EXPORT NSString *const XCDYouTubeVideoErrorDomain;

// Metadata notification userInfo keys, they are all optional
FOUNDATION_EXPORT NSString *const XCDMetadataKeyTitle;
FOUNDATION_EXPORT NSString *const XCDMetadataKeySmallThumbnailURL;
FOUNDATION_EXPORT NSString *const XCDMetadataKeyMediumThumbnailURL;
FOUNDATION_EXPORT NSString *const XCDMetadataKeyLargeThumbnailURL;