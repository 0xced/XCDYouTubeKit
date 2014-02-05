//
//  XCDYouTubeConstants.h
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Adrien Truong on 2/5/14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

typedef NS_ENUM(NSUInteger, XCDYouTubeVideoQuality) {
	XCDYouTubeVideoQualitySmall240  = 36,
	XCDYouTubeVideoQualityMedium360 = 18,
	XCDYouTubeVideoQualityHD720     = 22,
	XCDYouTubeVideoQualityHD1080    = 37,
};

MP_EXTERN NSString *const XCDYouTubeVideoErrorDomain;

// Metadata notification userInfo keys, they are all optional
MP_EXTERN NSString *const XCDMetadataKeyTitle;
MP_EXTERN NSString *const XCDMetadataKeySmallThumbnailURL;
MP_EXTERN NSString *const XCDMetadataKeyMediumThumbnailURL;
MP_EXTERN NSString *const XCDMetadataKeyLargeThumbnailURL;