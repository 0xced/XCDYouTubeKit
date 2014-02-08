//
//  XCDYouTubeVideoPlayerViewController.h
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "XCDYoutubeConstants.h"

MP_EXTERN NSString *const XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey; // NSError key for the `MPMoviePlayerPlaybackDidFinishNotification` userInfo dictionary

enum {
	XCDYouTubeErrorInvalidVideoIdentifier = 2,   // The given `videoIdentifier` string is invalid (including `nil`)
	XCDYouTubeErrorRemovedVideo           = 100, // The video has been removed as a violation of YouTube's policy
	XCDYouTubeErrorRestrictedPlayback     = 150  // The video is not playable because of legal reasons or the this is a private video
};

MP_EXTERN NSString *const XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification;

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
