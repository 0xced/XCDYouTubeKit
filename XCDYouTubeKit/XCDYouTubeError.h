//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The error domain used throughout XCDYouTubeKit.
 */
extern NSString *const XCDYouTubeVideoErrorDomain;

/**
 *  A key that may be present in the error's userInfo dictionary when the error code is XCDYouTubeErrorNoStreamAvailable.
 *  The object for that key is a NSSet instance containing localized country names.
 */
extern NSString *const XCDYouTubeAllowedCountriesUserInfoKey;

/**
 *  These values are returned as the error code property of an NSError object with the domain `XCDYouTubeVideoErrorDomain`.
 */
typedef NS_ENUM(NSInteger, XCDYouTubeErrorCode) {
	/**
	 *  Returned when no suitable video stream is available. This can occur due to various reason such as:
	 *  * The video is not playable because of legal reasons or when the video is private.
	 *  * The given video identifier string is invalid.
	 *  * The video was removed as a violation of YouTube's policy or when the video did not exist.
	 */
	XCDYouTubeErrorNoStreamAvailable      = -2,
	
	/**
	 *  Returned when a network error occurs. See `NSUnderlyingErrorKey` in the userInfo dictionary for more information.
	 */
	XCDYouTubeErrorNetwork                = -1,
	/**
	 * Returned when an empty response is returned. This may indicate that YouTube has blocked requests from your IP address because of overuse.
	 * This error does not contain any info in the `userInfo` property and is not appropriate to show to the user.
	*/
	XCDYouTubeErrorEmptyResponse = -3,
	/**
	 * Returned when an 429 HTTP code is returned. This may indicate that YouTube has blocked requests from your IP address because of overuse.
	 * This error code will the be code of the `NSError` in `NSUnderlyingErrorKey` when `XCDYouTubeErrorNetwork` is return when appropriate. This error is not localized.
	*/
	XCDYouTubeErrorTooManyRequests = -4,
	/**
	 * Returned  to indicate an unknown error. This error is not localized.
	*/
	XCDYouTubeErrorUnknown = -5,
	/**
	 *  Previously returned when the given video identifier string is invalid.
	 *  Use `XCDYouTubeErrorNoStreamAvailable` instead.
	 */
	XCDYouTubeErrorInvalidVideoIdentifier DEPRECATED_MSG_ATTRIBUTE("YouTube has stopped using error code 2.") = 2,
	
	/**
	 *  Previously returned when the video was removed as a violation of YouTube's policy or when the video did not exist.
	 */
	XCDYouTubeErrorRemovedVideo DEPRECATED_MSG_ATTRIBUTE("YouTube has stopped using error code 100.") = 100,
	
	/**
	 *  Previously returned when the video is not playable because of legal reasons or when the video is private.
	 *  Use `XCDYouTubeErrorNoStreamAvailable` instead.
	 */
	XCDYouTubeErrorRestrictedPlayback DEPRECATED_MSG_ATTRIBUTE("YouTube has stopped using error code 150.") = 150
};
