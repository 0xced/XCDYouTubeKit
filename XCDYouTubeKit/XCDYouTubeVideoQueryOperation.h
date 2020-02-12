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


@interface XCDYouTubeVideoQueryOperation : NSOperation

- (instancetype) initWithVideo:(XCDYouTubeVideo *)video cookies:(nullable NSArray<NSHTTPCookie *> *)cookies;

@property (atomic, strong, readonly) XCDYouTubeVideo *video;
@property (atomic, copy, readonly, nullable) NSArray<NSHTTPCookie *>*cookies;

#if __has_feature(objc_generics)
@property (atomic, readonly) NSDictionary<id, NSURL *> *streamURLs;
#else
@property (atomic, readonly) NSDictionary *streamURLs;
#endif

@property (atomic, readonly, nullable) NSError *error;

@end

NS_ASSUME_NONNULL_END
