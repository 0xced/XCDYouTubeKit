//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const XCDYouTubeVideoErrorDomain;

typedef NS_ENUM(NSInteger, XCDYouTubeErrorCode) {
	XCDYouTubeErrorNetwork                = -1,  // A network error occurred.
	XCDYouTubeErrorInvalidVideoIdentifier = 2,   // The given `videoIdentifier` string is invalid (including `nil`)
	XCDYouTubeErrorRemovedVideo           = 100, // The video has been removed as a violation of YouTube's policy
	XCDYouTubeErrorRestrictedPlayback     = 150  // The video is not playable because of legal reasons or the this is a private video
};
