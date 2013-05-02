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

@interface XCDYouTubeVideoPlayerViewController : MPMoviePlayerViewController

- (id) initWithYouTubeVideoIdentifier:(NSString *)videoIdentifier;

@property (nonatomic, strong) NSArray *preferredVideoQuality;

@end
