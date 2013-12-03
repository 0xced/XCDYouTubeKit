//
//  XCDYouTubeVideoPlayerViewController.h
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

typedef NS_ENUM(NSUInteger, XCDYouTubeVideoQuality) {
	XCDYouTubeVideoQualitySmall240  = 36,
	XCDYouTubeVideoQualityMedium360 = 18,
	XCDYouTubeVideoQualityHD720     = 22,
	XCDYouTubeVideoQualityHD1080    = 37,
};

MP_EXTERN NSString *const XCDYouTubeVideoErrorDomain;

// NSError key for the `MPMoviePlayerPlaybackDidFinishNotification` userInfo dictionary
// Ideally, there should be a `MPMoviePlayerPlaybackDidFinishErrorUserInfoKey` declared near to `MPMoviePlayerPlaybackDidFinishReasonUserInfoKey`
// in MPMoviePlayerController.h but since it doesn't exist, here is a convenient constant key.
MP_EXTERN NSString *const XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey;

enum {
	XCDYouTubeErrorInvalidVideoIdentifier = 2,   // The given `videoIdentifier` string is invalid (including `nil`)
	XCDYouTubeErrorRemovedVideo           = 100, // The video has been removed as a violation of YouTube's policy
	XCDYouTubeErrorRestrictedPlayback     = 150  // The video is not playable because of legal reasons or the this is a private video
};

MP_EXTERN NSString *const XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification;
// Metadata notification userInfo keys, they are all optional
MP_EXTERN NSString *const XCDMetadataKeyTitle;
MP_EXTERN NSString *const XCDMetadataKeySmallThumbnailURL;
MP_EXTERN NSString *const XCDMetadataKeyMediumThumbnailURL;
MP_EXTERN NSString *const XCDMetadataKeyLargeThumbnailURL;

@interface XCDYouTubeVideoPlayerViewController : MPMoviePlayerViewController

- (id) initWithVideoIdentifier:(NSString *)videoIdentifier;

@property (nonatomic, copy) NSString *videoIdentifier;

// On iPhone, defaults to @[ @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ]
// On iPad, defaults to @[ @(XCDYouTubeVideoQualityHD1080), @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ]
// If you really know what you are doing, you can use the `itag` values as described on http://en.wikipedia.org/wiki/YouTube#Quality_and_codecs
// Setting this property to nil restores its default values
@property (nonatomic, copy) NSArray *preferredVideoQualities;

// Ownership of the XCDYouTubeVideoPlayerViewController instance is transferred to the view.
- (void) presentInView:(UIView *)view;

@end
