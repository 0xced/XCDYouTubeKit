//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#if !__has_feature(nullability)
#define NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_END
#define nullable
#define __nullable
#endif

#import <Foundation/Foundation.h>

#import "XCDYouTubeOperation.h"
#import "XCDYouTubeVideo.h"
#import "XCDYouTubeError.h"
#import "XCDYouTubeVideoQueryOperation.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `XCDYouTubeClient` class is responsible for interacting with the YouTube API. Given a YouTube video identifier, you will get video information with the `<-getVideoWithIdentifier:completionHandler:>` method.
 *
 *  On iOS, you probably don’t want to use `XCDYouTubeClient` directly but the higher level class `<XCDYouTubeVideoPlayerViewController>`.
 */
@interface XCDYouTubeClient : NSObject

+ (NSString *)innertubeApiKey;
+ (void)setInnertubeApiKey:(NSString *)key;

/**
 *  ------------------
 *  @name Initializing
 *  ------------------
 */

/**
 *  Returns the shared client with the default language, i.e. the preferred language of the main bundle.
 *
 *  @return The default client.
 */
+ (instancetype) defaultClient;

/**
 *  Initializes a client with the specified language identifier.
 *
 *  @param languageIdentifier An [ISO 639-1 two-letter language code](http://www.loc.gov/standards/iso639-2/php/code_list.php) used for error localization. If you pass a nil language identifier, the preferred language of the main bundle will be used.
 *
 *  @return A client with the specified language identifier.
 */
- (instancetype) initWithLanguageIdentifier:(nullable NSString *)languageIdentifier;

/**
 *  ---------------------------------
 *  @name Accessing client properties
 *  ---------------------------------
 */

/**
 *  The language identifier of the client, used for error localization.
 *
 *  @see -initWithLanguageIdentifier:
 */
@property (nonatomic, readonly) NSString *languageIdentifier;

/**
 *  --------------------------------------
 *  @name Interacting with the YouTube API
 *  --------------------------------------
 */

/**
 *  Starts an asynchronous operation for the specified video identifier, and calls a handler upon completion.
 *
 *  @param videoIdentifier   A 11 characters YouTube video identifier. If the video identifier is invalid (including nil) the completion handler will be called with an error with `XCDYouTubeVideoErrorDomain` domain and `XCDYouTubeErrorNoStreamAvailable` code.
 *  @param completionHandler A block to execute when the client finishes the operation. The completion handler is executed on the main thread. If the completion handler is nil, this method throws an exception.
 *
 *  @discussion If the operation completes successfully, the video parameter of the handler block contains a `<XCDYouTubeVideo>` object, and the error parameter is nil. If the operation fails, the video parameter is nil and the error parameter contains information about the failure. The error's domain is always `XCDYouTubeVideoErrorDomain`.
 *
 *  @see XCDYouTubeErrorCode
 *
 *  @return An opaque object conforming to the `<XCDYouTubeOperation>` protocol for canceling the asynchronous video information operation. If you call the `cancel` method before the operation is finished, the completion handler will not be called. It is recommended that you store this opaque object as a weak property.
 */
- (id<XCDYouTubeOperation>) getVideoWithIdentifier:(nullable NSString *)videoIdentifier completionHandler:(void (^)(XCDYouTubeVideo * __nullable video, NSError * __nullable error))completionHandler;

/**
 *  Starts an asynchronous operation for the specified video identifier, and calls a handler upon completion.
 *
 *  @param videoIdentifier   A 11 characters YouTube video identifier. If the video identifier is invalid (including nil) the completion handler will be called with an error with `XCDYouTubeVideoErrorDomain` domain and `XCDYouTubeErrorNoStreamAvailable` code.
 *	@param cookies An array of `NSHTTPCookie` objects, can be nil. These cookies can be used for certain videos that require a login.
 *  @param completionHandler A block to execute when the client finishes the operation. The completion handler is executed on the main thread. If the completion handler is nil, this method throws an exception.
 *
 *  @discussion If the operation completes successfully, the video parameter of the handler block contains a `<XCDYouTubeVideo>` object, and the error parameter is nil. If the operation fails, the video parameter is nil and the error parameter contains information about the failure. The error's domain is always `XCDYouTubeVideoErrorDomain`.
 *
 *  @see XCDYouTubeErrorCode
 *
 *  @return An opaque object conforming to the `<XCDYouTubeOperation>` protocol for canceling the asynchronous video information operation. If you call the `cancel` method before the operation is finished, the completion handler will not be called. It is recommended that you store this opaque object as a weak property.
 */
- (id<XCDYouTubeOperation>) getVideoWithIdentifier:(NSString *)videoIdentifier cookies:(nullable NSArray <NSHTTPCookie *>*)cookies completionHandler:(void (^)(XCDYouTubeVideo * __nullable video, NSError * __nullable error))completionHandler;

/**
 *  Starts an asynchronous operation for the specified video identifier, and calls a handler upon completion.
 *
 *  @param videoIdentifier   A 11 characters YouTube video identifier. If the video identifier is invalid (including nil) the completion handler will be called with an error with `XCDYouTubeVideoErrorDomain` domain and `XCDYouTubeErrorNoStreamAvailable` code.
 *	@param cookies An array of `NSHTTPCookie` objects, can be nil. These cookies can be used for certain videos that require a login.
 *  @param customPatterns An array of `NSString` objects, can be nil. These patterns can be used to create custom regular expression objects in favor of the internal hard-coded patterns for video parsing. If none of these patterns produces a valid `NSRegularExpression` object then the internal hard-coded regular expression objects are used. Typically, you do not need to use this parameter, however, it can be used a way to use update patterns when needed (i.e to adapt to YouTube API changes). See https://github.com/0xced/XCDYouTubeKit/blob/master/REGULAR_EXPRESSION.md for more info.
 *  @param completionHandler A block to execute when the client finishes the operation. The completion handler is executed on the main thread. If the completion handler is nil, this method throws an exception.
 *
 *  @discussion If the operation completes successfully, the video parameter of the handler block contains a `<XCDYouTubeVideo>` object, and the error parameter is nil. If the operation fails, the video parameter is nil and the error parameter contains information about the failure. The error's domain is always `XCDYouTubeVideoErrorDomain`.
 *
 *  @see XCDYouTubeErrorCode
 *
 *  @return An opaque object conforming to the `<XCDYouTubeOperation>` protocol for canceling the asynchronous video information operation. If you call the `cancel` method before the operation is finished, the completion handler will not be called. It is recommended that you store this opaque object as a weak property.
 */
- (id<XCDYouTubeOperation>) getVideoWithIdentifier:(NSString *)videoIdentifier cookies:(nullable NSArray <NSHTTPCookie *>*)cookies customPatterns:(nullable NSArray<NSString *> *)customPatterns completionHandler:(void (^)(XCDYouTubeVideo * __nullable video, NSError * __nullable error))completionHandler;

/**
 *  Starts an asynchronous operation for the specified `XCDYouTubeVide` object`, and calls a handler upon completion.
 *
 *  @param video  The `<XCDYouTubeVideo>` object that this operation will query. Passing a `nil` video will throw an `NSInvalidArgumentException` exception.
 *  @param cookies  An array of `NSHTTPCookie` objects, can be nil. These cookies can be used for certain videos that require a login.
 *  @param completionHandler A block to execute when the client finishes the operation. The completion handler is executed on the main thread. If the completion handler is nil, this method throws an exception.
 *  @discussion If the query operation completes successfully (i.e. at least one URL stream is reachable), the `streamURLs` parameter of the completion handler block contains a `NSDictionary` object, and the error parameter is nil. If the operation fails, the `streamURLs` parameter is nil and the error parameter contains information about the failure. The error's domain is always `XCDYouTubeVideoErrorDomain`. The `streamErrors` does not indicate that the operation failed but can contain detailed information on why a specific stream failed.In addition, this parameter is dictionary of `NSError` objects. The keys are the YouTube [itag](https://en.wikipedia.org/wiki/YouTube#Quality_and_formats) values as `NSNumber` objects. In some cases the errors within this dictionary may contain `NSError` objects with the code `NSURLErrorNetworkConnectionLost`—this may indicate that the file stored on YouTube's server is incomplete—furthermore, the error will make this suggestion via the`NSLocalizedRecoverySuggestionErrorKey` key of the error's `userInfo`.
 *
 *  @see XCDYouTubeVideoQueryOperation
 *
 *
 *  @return A newly initialized`<XCDYouTubeVideoQueryOperation>` object for canceling the asynchronous query  operation. If you call the `cancel` method before the operation is finished, the completion handler will not be called.
 */
- (XCDYouTubeVideoQueryOperation *) queryVideo:(XCDYouTubeVideo *)video cookies:(nullable NSArray <NSHTTPCookie *>*)cookies completionHandler:(void (^)(NSDictionary * __nullable streamURLs, NSError * __nullable error, NSDictionary<id, NSError *> * __nullable streamErrors))completionHandler;
/**
 *  Starts an asynchronous operation for the specified `XCDYouTubeVide` object`,  stream URLs to query and cookies, then calls a handler upon completion.
 *
 *  @param video The `<XCDYouTubeVideo>` object that this operation will query. Passing a `nil` video will throw an `NSInvalidArgumentException` exception.
 *  @param streamURLsToQuery The specific stream URLs to query, can be nil. These URLs and keys must be contained in the `streamURLs` property of the `video` object, if none of the values in `streamURLsToQuery` match then all of the `streamURLs`  will be queried.
 *  @param options  Options that are reserved for future use.
 *  @param cookies  An array of `NSHTTPCookie` objects, can be nil. These cookies can be used for certain videos that require a login.
 *  @param completionHandler A block to execute when the client finishes the operation. The completion handler is executed on the main thread. If the completion handler is nil, this method throws an exception.
 *  @discussion If the query operation completes successfully (i.e. at least one URL stream is reachable), the `streamURLs` parameter of the completion handler block contains a `NSDictionary` object, and the error parameter is nil. If the operation fails, the `streamURLs` parameter is nil and the error parameter contains information about the failure. The error's domain is always `XCDYouTubeVideoErrorDomain`. The `streamErrors` does not indicate that the operation failed but can contain detailed information on why a specific stream failed.In addition, this parameter is dictionary of `NSError` objects. The keys are the YouTube [itag](https://en.wikipedia.org/wiki/YouTube#Quality_and_formats) values as `NSNumber` objects. In some cases the errors within this dictionary may contain `NSError` objects with the code `NSURLErrorNetworkConnectionLost`—this may indicate that the file stored on YouTube's server is incomplete—furthermore, the error will make this suggestion via the`NSLocalizedRecoverySuggestionErrorKey` key of the error's `userInfo`.
 *
 *  @see XCDYouTubeVideoQueryOperation
 *
 *
 *  @return A newly initialized`<XCDYouTubeVideoQueryOperation>` object for canceling the asynchronous query  operation. If you call the `cancel` method before the operation is finished, the completion handler will not be called.
 */
- (XCDYouTubeVideoQueryOperation *) queryVideo:(XCDYouTubeVideo *)video streamURLsToQuery:(NSDictionary<id, NSURL *> * __nullable)streamURLsToQuery options:(NSDictionary * __nullable)options cookies:(nullable NSArray <NSHTTPCookie *>*)cookies completionHandler:(void (^)(NSDictionary *__nullable streamURLs, NSError * __nullable error, NSDictionary<id, NSError *> *__nullable streamErrors))completionHandler;


@end

NS_ASSUME_NONNULL_END
