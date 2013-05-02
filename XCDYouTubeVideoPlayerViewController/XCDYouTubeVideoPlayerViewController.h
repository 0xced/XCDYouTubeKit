//
//  XCDYouTubeVideoPlayerViewController.h
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface XCDYouTubeVideoPlayerViewController : MPMoviePlayerViewController

- (id) initWithYouTubeVideoIdentifier:(NSString *)videoIdentifier;

@end
