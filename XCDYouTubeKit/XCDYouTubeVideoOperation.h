//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <XCDYouTubeKit/XCDYouTubeOperation.h>
#import <XCDYouTubeKit/XCDYouTubeVideo.h>

/**
 *  XCDYouTubeVideoOperation is a subclass of `NSOperation` that connects to the YouTube API and parse the response.
 *
 *  You should probably use the higher level class `<XCDYouTubeClient>`. Use this class only if you are very familiar with `NSOperation` and need to manage dependencies between operations.
 *
 *  Since version 2.2.0 this operation is synchronous and must not be started on the main thread. Starting the operation on the main thread throws an exception.
 */
@interface XCDYouTubeVideoOperation : NSOperation <XCDYouTubeOperation>

/**
 *  ------------------
 *  @name Initializing
 *  ------------------
 */

/**
 *  Initializes a video operation with the specified video identifier and language identifier.
 *
 *  @param videoIdentifier    A 11 characters YouTube video identifier.
 *  @param languageIdentifier An [ISO 639-1 two-letter language code](http://www.loc.gov/standards/iso639-2/php/code_list.php) used for error localization. If you pass a nil language identifier then English (`en`) is used.
 *
 *  @return An initialized `XCDYouTubeVideoOperation` object.
 */
- (instancetype) initWithVideoIdentifier:(NSString *)videoIdentifier languageIdentifier:(NSString *)languageIdentifier;

/**
 *  --------------------------------
 *  @name Accessing operation result
 *  --------------------------------
 */

/**
 *  Returns an error of the `XCDYouTubeVideoErrorDomain` domain if the operation failed or nil if it succeeded.
 *
 *  Returns nil if the operation is not yet finished or if it was canceled.
 */
@property (atomic, readonly) NSError *error;
/**
 *  Returns a video object if the operation succeeded or nil if it failed.
 *
 *  Returns nil if the operation is not yet finished or if it was canceled.
 */
@property (atomic, readonly) XCDYouTubeVideo *video;

@end
