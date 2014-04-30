//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

#import <XCDYouTubeKit/XCDYouTubeVideo.h>

// NSError key for the `MPMoviePlayerPlaybackDidFinishNotification` userInfo dictionary
// Ideally, there should be a `MPMoviePlayerPlaybackDidFinishErrorUserInfoKey` declared near to `MPMoviePlayerPlaybackDidFinishReasonUserInfoKey`
// in MPMoviePlayerController.h but since it doesn't exist, here is a convenient constant key.
MP_EXTERN NSString *const XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey;

MP_EXTERN NSString *const XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification;
MP_EXTERN NSString *const XCDYouTubeVideoUserInfoKey; // XCDYouTubeVideo

MP_EXTERN NSString *const XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification DEPRECATED_MSG_ATTRIBUTE("Use XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification instead.");
MP_EXTERN NSString *const XCDMetadataKeyTitle DEPRECATED_MSG_ATTRIBUTE("Use XCDYouTubeVideoUserInfoKey instead.");
MP_EXTERN NSString *const XCDMetadataKeySmallThumbnailURL DEPRECATED_MSG_ATTRIBUTE("Use XCDYouTubeVideoUserInfoKey instead.");
MP_EXTERN NSString *const XCDMetadataKeyMediumThumbnailURL DEPRECATED_MSG_ATTRIBUTE("Use XCDYouTubeVideoUserInfoKey instead.");
MP_EXTERN NSString *const XCDMetadataKeyLargeThumbnailURL DEPRECATED_MSG_ATTRIBUTE("Use XCDYouTubeVideoUserInfoKey instead.");

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
