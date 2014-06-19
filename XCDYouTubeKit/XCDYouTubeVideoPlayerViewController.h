//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

/**
 *  -------------------
 *  @name Notifications
 *  -------------------
 */

/**
 *  NSError key for the `MPMoviePlayerPlaybackDidFinishNotification` userInfo dictionary.
 *
 *  Ideally, there should be a `MPMoviePlayerPlaybackDidFinishErrorUserInfoKey` declared near to `MPMoviePlayerPlaybackDidFinishReasonUserInfoKey` in MPMoviePlayerController.h but since it doesn't exist, here is a convenient constant key.
 */
MP_EXTERN NSString *const XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey;

/**
 *  Posted when the video player has received the video information. The `object` of the notification is the `XCDYouTubeVideoPlayerViewController` instance. The `userInfo` dictionary contains the `XCDYouTubeVideo` object.
 */
MP_EXTERN NSString *const XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification;
/**
 *  The key for the `XCDYouTubeVideo` object in the user info dictionary of `XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification`.
 */
MP_EXTERN NSString *const XCDYouTubeVideoUserInfoKey;

/**
 *  A subclass of `MPMoviePlayerViewController` for playing YouTube videos.
 *
 *  Use UIViewController’s `presentMoviePlayerViewControllerAnimated:` method to play a YouTube video fullscreen.
 *
 *  Use the `presentInView:` method to play a YouTube video inline.
 */
@interface XCDYouTubeVideoPlayerViewController : MPMoviePlayerViewController

/**
 *  ------------------
 *  @name Initializing
 *  ------------------
 */

/**
 *  Initializes a YouTube video player view controller
 *
 *  @param videoIdentifier A 11 characters YouTube video identifier. If the video identifier is invalid (including nil) the `MPMoviePlayerPlaybackDidFinishNotification` will be posted with a `MPMovieFinishReasonPlaybackError` reason.
 *
 *  @return An initialized YouTube video player view controller with the specified video identifier.
 *
 *  @discussion You pass a nil videoIdentifier and set the `videoIdentifier` property later.
 */
- (instancetype) initWithVideoIdentifier:(NSString *)videoIdentifier __attribute__((objc_designated_initializer));

/**
 *  ------------------------------------
 *  @name Accessing the video identifier
 *  ------------------------------------
 */

/**
 *  The 11 characters YouTube video identifier.
 */
@property (nonatomic, copy) NSString *videoIdentifier;

/**
 *  ------------------------------------------
 *  @name Defining the preferred video quality
 *  ------------------------------------------
 */

/**
 *  The preferred order for the quality of the video to play. Plays the first match when multiple video streams are available.
 *
 *  Defaults to @[ XCDYouTubeVideoQualityHTTPLiveStreaming, @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ]
 *
 *  You should set this property right after calling the `initWithVideoIdentifier:` method. Setting this property to nil restores its default values.
 *
 *  @see `XCDYouTubeVideoQuality`
 */
@property (nonatomic, copy) NSArray *preferredVideoQualities;

/**
 *  ------------------------
 *  @name Presenting a video
 *  ------------------------
 */

/**
 *  Present the video inside a view.
 *
 *  @param view The view inside which you want to present the video.
 *
 *  @discussion The video view is added as a subview of the specified view. The video does not start playing immediately, you have to call `[videoPlayerViewController.moviePlayer play]` for playback to start. See `MPMoviePlayerController` documentation for more information.
 *
 *  Ownership of the XCDYouTubeVideoPlayerViewController instance is transferred to the view.
 */
- (void) presentInView:(UIView *)view;

@end

/**
 *  ------------------------------
 *  @name Deprecated notifications
 *  ------------------------------
 */
MP_EXTERN NSString *const XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification DEPRECATED_MSG_ATTRIBUTE("Use XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification instead.");
MP_EXTERN NSString *const XCDMetadataKeyTitle DEPRECATED_MSG_ATTRIBUTE("Use XCDYouTubeVideoUserInfoKey instead.");
MP_EXTERN NSString *const XCDMetadataKeySmallThumbnailURL DEPRECATED_MSG_ATTRIBUTE("Use XCDYouTubeVideoUserInfoKey instead.");
MP_EXTERN NSString *const XCDMetadataKeyMediumThumbnailURL DEPRECATED_MSG_ATTRIBUTE("Use XCDYouTubeVideoUserInfoKey instead.");
MP_EXTERN NSString *const XCDMetadataKeyLargeThumbnailURL DEPRECATED_MSG_ATTRIBUTE("Use XCDYouTubeVideoUserInfoKey instead.");
