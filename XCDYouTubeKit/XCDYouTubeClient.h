//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <XCDYouTubeKit/XCDYouTubeOperation.h>
#import <XCDYouTubeKit/XCDYouTubeVideo.h>
#import <XCDYouTubeKit/XCDYouTubeError.h>

@interface XCDYouTubeClient : NSObject

+ (instancetype) defaultClient; // Client with the default language identifier, i.e. the preferred language for the main bundle.

- (instancetype) initWithLanguageIdentifier:(NSString *)languageIdentifier;

@property (nonatomic, readonly) NSString *languageIdentifier;

- (id<XCDYouTubeOperation>) getVideoWithIdentifier:(NSString *)videoIdentifier completionHandler:(void (^)(XCDYouTubeVideo *video, NSError *error))completionHandler __attribute__((nonnull(2)));

@end
