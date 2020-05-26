//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#if !__has_feature(nullability)
#define NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_END
#define nullable
#endif

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  The quality of YouTube videos. These values are used as keys in the `<[XCDYouTubeVideo streamURLs]>` property.
 *
 *  The constant numbers are the YouTube [itag](https://en.wikipedia.org/wiki/Talk:YouTube/Archive_22#Moved_from_YouTube#Quality_formats) values.
 */
typedef NS_ENUM(NSUInteger, XCDYouTubeVideoQuality) {
	/**
	 *  Video: 240p MPEG-4 Visual | 0.175 Mbit/s
	 *  Audio: AAC | 36 kbit/s
	 */
	XCDYouTubeVideoQualitySmall240  = 36,
	
	/**
	 *  Video: 360p H.264 | 0.5 Mbit/s
	 *  Audio: AAC | 96 kbit/s
	 */
	XCDYouTubeVideoQualityMedium360 = 18,
	
	/**
	 *  Video: 720p H.264 | 2-3 Mbit/s
	 *  Audio: AAC | 192 kbit/s
	 */
	XCDYouTubeVideoQualityHD720     = 22,
	
	/**
	 *  Video: 1080p H.264 | 3–5.9 Mbit/s
	 *  Audio: AAC | 192 kbit/s
	 *
	 *  @deprecated YouTube has removed 1080p mp4 videos.
	 */
	XCDYouTubeVideoQualityHD1080 DEPRECATED_MSG_ATTRIBUTE("YouTube has removed 1080p mp4 videos.") = 37,
};

/**
 *  Used as a key in the `streamURLs` property of the `XCDYouTubeVideo` class for live videos.
 */
extern NSString *const XCDYouTubeVideoQualityHTTPLiveStreaming;

/**
 *  Represents a YouTube video. Use the `<-[XCDYouTubeClient getVideoWithIdentifier:completionHandler:]>` method to obtain a `XCDYouTubeVideo` object.
 */
@interface XCDYouTubeVideo : NSObject <NSCopying>

/**
 *  --------------------------------
 *  @name Accessing video properties
 *  --------------------------------
 */

/**
 *  The 11 characters YouTube video identifier.
 */
@property (nonatomic, readonly) NSString *identifier;
/**
 *  The title of the video.
 */
@property (nonatomic, readonly) NSString *title;
/**
 * The name of author that uploaded this video.
 */
@property (nonatomic, readonly) NSString *author;
/**
 * The channel identifier of YouTube channel that this video belongs to.
 */
@property (nonatomic, readonly) NSString *channelIdentifier;
/**
 * The description of the video.
 */
@property (nonatomic, readonly) NSString *videoDescription;
/**
 *  The duration of the video in seconds.
 */
@property (nonatomic, readonly) NSTimeInterval duration;
/**
 *  The views count of the video.
 */
@property (nonatomic, readonly) NSInteger viewCount;
/**
 *  An array of thumbnail URLs for an images of different sizes. Ordered from smaller to bigger.
 */
@property (nonatomic, readonly, nullable) NSArray<NSURL *> *thumbnailURLs;
/**
 *  A thumbnail URL for an image of small size, i.e. 120×90. May be nil.
 */
@property (nonatomic, readonly, nullable) NSURL *thumbnailURL
	DEPRECATED_MSG_ATTRIBUTE("Use `thumbnailURLs` instead.");
/**
 *  A thumbnail URL for an image of small size, i.e. 120×90. May be nil.
 */
@property (nonatomic, readonly, nullable) NSURL *smallThumbnailURL DEPRECATED_MSG_ATTRIBUTE("Renamed. Use `thumbnailURL` instead.");
/**
 *  A thumbnail URL for an image of medium size, i.e. 320×180, 480×360 or 640×480. May be nil.
 */
@property (nonatomic, readonly, nullable) NSURL *mediumThumbnailURL DEPRECATED_MSG_ATTRIBUTE("No longer available. Use `thumbnailURL` instead.");
/**
 *  A thumbnail URL for an image of large size, i.e. 1'280×720 or 1'980×1'080. May be nil.
 */
@property (nonatomic, readonly, nullable) NSURL *largeThumbnailURL DEPRECATED_MSG_ATTRIBUTE("No longer available. Use `thumbnailURL` instead.");

/**
 *  A dictionary of video stream URLs.
 *
 *  The keys are the YouTube [itag](https://en.wikipedia.org/wiki/YouTube#Quality_and_formats) values as `NSNumber` objects. The values are the video URLs as `NSURL` objects. There is also the special `XCDYouTubeVideoQualityHTTPLiveStreaming` key for live videos.
 *
 *  You should not store the URLs for later use since they have a limited lifetime and are bound to an IP address.
 *
 *  @see XCDYouTubeVideoQuality
 *  @see expirationDate
 */
#if __has_feature(objc_generics)
@property (nonatomic, readonly) NSDictionary<id, NSURL *> *streamURLs;
#else
@property (nonatomic, readonly) NSDictionary *streamURLs;
#endif

/**

*  A streamURL that is compatible on Apple devices (can be `nil`)
*  The `streamURLs` may contain both video and audio streams, some video streams do not contain any audio. This property will return a video stream that contains both audio and video with a maximum video quality of 720p in the case of videos that aren't live. Also, this properly will return the URL to a live stream in the case of live videos.
*/
@property (nonatomic, readonly, nullable) NSURL *streamURL;

/**

 *  A dictionary of caption URLs (XML).
 *
 *  The keys are the [language codes](https://www.loc.gov/standards/iso639-2/php/code_list.php) values as `NSString` objects. The values are the caption URLs as `NSURL` objects.
 *
 *  You should not store the URLs for later use since they have a limited lifetime.
 */
#if __has_feature(objc_generics)
@property (nonatomic, readonly, nullable) NSDictionary<id, NSURL *> *captionURLs;
#else
@property (nonatomic, readonly, nullable) NSDictionary *captionURLs;
#endif

/**
 
 *  A dictionary of auto generated caption URLs (XML).
 *
 *  The keys are the [language codes](https://www.loc.gov/standards/iso639-2/php/code_list.php) values as `NSString` objects. The values are the caption URLs as `NSURL` objects. These URLs are the ones that were automatically generated by YouTube.
 *
 *  You should not store the URLs for later use since they have a limited lifetime.
 */

#if __has_feature(objc_generics)
@property (nonatomic, readonly, nullable) NSDictionary<id, NSURL *> *autoGeneratedCaptionURLs;
#else
@property (nonatomic, readonly, nullable) NSDictionary *autoGeneratedCaptionURLs;
#endif
/**
 *  An array of strings (YouTube video identifier) of other streams, this indicates that the video is a multi-camera video. Use  `<XCDYouTubeClient>  or  `<XCDYouTubeVideoOperation>  to fetch the other streams.
*/
#if __has_feature(objc_generics)
@property (nonatomic, readonly, nullable) NSArray<NSString *> *videoIdentifiers;
#else
@property (nonatomic, readonly, nullable) NSArray *videoIdentifiers;
#endif

/**
 *  The expiration date of the video.
 *
 *  After this date, the stream URLs will not be playable. May be nil if it can not be determined, for example in live videos.
 */
@property (nonatomic, readonly, nullable) NSDate *expirationDate;

@end

NS_ASSUME_NONNULL_END
