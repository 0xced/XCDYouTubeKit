//
//  XCDYouTubeVideoQueryOperation.h
//  XCDYouTubeKit Static Library
//
//  Created by Soneé John on 2/12/20.
//  Copyright © 2020 Cédric Luthi. All rights reserved.
//

#if !__has_feature(nullability)
#define NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_END
#define nullable
#endif

#import <Foundation/Foundation.h>

#import "XCDYouTubeVideo.h"

NS_ASSUME_NONNULL_BEGIN

/// XCDYouTubeVideoQueryOperation is a subclass of `NSOperation` that  check to see if the `streamURLs` in a `XCDYouTubeVideo` object  is reachable (i.e. does not contain any HTTP errors). This operation will only run on a background queue, starting this operation on the main thread will raise an assertion.
/// You should probably use the higher level class `<XCDYouTubeClient>`. Use this class only if you are very familiar with `NSOperation` and need to manage dependencies between operations.
@interface XCDYouTubeVideoQueryOperation : NSOperation


/// Initializes a video  query operation with the specified video and cookies.
/// @param video The `<XCDYouTubeVideo>` object that this operation will query. Passing a `nil` video will throw an `NSInvalidArgumentException` exception.
/// @param cookies  An array of `NSHTTPCookie` objects, can be nil. These cookies can be used for certain videos that require a login.
- (instancetype) initWithVideo:(XCDYouTubeVideo *)video cookies:(nullable NSArray<NSHTTPCookie *> *)cookies;

/// Initializes a video  query operation with the specified video,  stream URLs to query and cookies.
/// @param video The `<XCDYouTubeVideo>` object that this operation will query. Passing a `nil` video will throw an `NSInvalidArgumentException` exception.
/// @param streamURLsToQuery The specific stream URLs to query, can be nil. These URLs and keys must be contained in the `streamURLs` property of the `video` object, if none of the values in `streamURLsToQuery` match then all of the `streamURLs`  will be queried.
/// @param options  Options that are reserved for future use.
/// @param cookies  An array of `NSHTTPCookie` objects, can be nil. These cookies can be used for certain videos that require a login.
- (instancetype) initWithVideo:(XCDYouTubeVideo *)video streamURLsToQuery:(nullable NSDictionary<id, NSURL *>*)streamURLsToQuery options:(nullable NSDictionary *)options cookies:(nullable NSArray<NSHTTPCookie *> *)cookies NS_DESIGNATED_INITIALIZER;

/// The `video` object that the operation initialized initialized with.
@property (atomic, strong, readonly) XCDYouTubeVideo *video;

@property (atomic, strong, readonly, nullable) NSDictionary<id, NSURL *> *streamURLsToQuery;

/// The array of `NSHTTPCookie` objects passed during initialization.
@property (atomic, copy, readonly, nullable) NSArray<NSHTTPCookie *>*cookies;

/// A dictionary of video stream URLs that are reachable. The keys are the YouTube [itag](https://en.wikipedia.org/wiki/YouTube#Quality_and_formats) values as `NSNumber` objects. The values are the video URLs as `NSURL` objects. There is also the special `XCDYouTubeVideoQualityHTTPLiveStreaming` key for live videos.
#if __has_feature(objc_generics)
@property (atomic, readonly, nullable) NSDictionary<id, NSURL *> *streamURLs;
#else
@property (atomic, readonly, nullable) NSDictionary *streamURLs;
#endif

/// Returns an error of the `XCDYouTubeVideoErrorDomain` domain if the operation failed or nil if it succeeded. The operation will only return an error if no stream URL is reachable (error code: `XCDYouTubeErrorNoStreamAvailable`). Also, this returns `nil` if the operation is not yet finished or if it was canceled.
@property (atomic, readonly, nullable) NSError *error;

/// A dictionary of `NSError` objects. The keys are the YouTube [itag](https://en.wikipedia.org/wiki/YouTube#Quality_and_formats) values as `NSNumber` objects. Use this property to query why a specific stream was unavailable. In some cases the errors within this dictionary may contain `NSError` objects with the code `NSURLErrorNetworkConnectionLost`—this may indicate that the file stored on YouTube's server is incomplete—furthermore, the error will make this suggestion via the`NSLocalizedRecoverySuggestionErrorKey` key of the error's `userInfo`.
#if __has_feature(objc_generics)
@property (atomic, readonly, nullable) NSDictionary<id, NSError *> *streamErrors;
#else
@property (atomic, readonly, nullable) NSDictionary *streamErrors;
#endif

@end

NS_ASSUME_NONNULL_END
