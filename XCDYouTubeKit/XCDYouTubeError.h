//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The error domain used throughout XCDYouTubeKit.
 */
extern NSString *const XCDYouTubeVideoErrorDomain;

/**
 *  These values are returned as the error code property of an NSError object with the domain `XCDYouTubeVideoErrorDomain`.
 */
typedef NS_ENUM(NSInteger, XCDYouTubeErrorCode) {
	/**
	 *  Returned when no suitable video stream is available.
	 */
	XCDYouTubeErrorNoStreamAvailable      = -2,
	
	/**
	 *  Returned when a network error occurs. See `NSUnderlyingErrorKey` in the userInfo dictionary for more information.
	 */
	XCDYouTubeErrorNetwork                = -1,
	
	/**
	 *  Returned when the given video identifier string is invalid.
	 */
	XCDYouTubeErrorInvalidVideoIdentifier = 2,
	
	/**
	 *  Previously returned when the video was removed as a violation of YouTube's policy or when the video did not exist.
	 *  Now replaced by code 150, i.e. `XCDYouTubeErrorRestrictedPlayback`.
	 */
	XCDYouTubeErrorRemovedVideo DEPRECATED_MSG_ATTRIBUTE("YouTube has stopped using error code 100.") = 100,
	
	/**
	 *  Returned when the video is not playable because of legal reasons or when the video is private.
	 */
	XCDYouTubeErrorRestrictedPlayback     = 150
};
