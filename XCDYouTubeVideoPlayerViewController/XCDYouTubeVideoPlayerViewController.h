//
//  XCDYouTubeVideoPlayerViewController.h
//  YouTube Video Player Demo
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
MP_EXTERN NSString *const XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey; // NSError

@interface XCDYouTubeVideoPlayerViewController : MPMoviePlayerViewController

- (id) initWithVideoIdentifier:(NSString *)videoIdentifier;

@property (nonatomic, copy) NSString *videoIdentifier;

// On iPhone, defaults to @[ @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ]
// On iPad, defaults to @[ @(XCDYouTubeVideoQualityHD1080), @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ]
// If you really know what you are doing, you can use the `itag` values as described on http://en.wikipedia.org/wiki/YouTube#Quality_and_codecs
@property (nonatomic, copy) NSArray *preferredVideoQualities;

// Ownership of the `moviePlayer` property is transferred to the view.
- (void) presentInView:(UIView *)view;

@end
