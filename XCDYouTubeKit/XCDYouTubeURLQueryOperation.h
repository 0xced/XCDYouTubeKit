//
//  XCDYouTubeURLQueryOperation.h
//  XCDYouTubeKit Static Library
//
//  Created by Soneé John on 17/01/2019.
//  Copyright © 2019 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCDYouTubeURLQueryOperation : NSOperation

- (instancetype)initWithURL:(NSURL *)url info:(nullable NSDictionary *)info cookes:(nullable NSArray <NSHTTPCookie *> *)cookies;

@property (atomic, strong, readonly) NSURL *url;
@property (atomic, strong, readonly, nullable) NSDictionary *info;
@property (atomic, strong, readonly, nullable) NSArray <NSHTTPCookie *> *cookies;

@property (atomic, readonly, nullable) NSData *data;
@property (atomic, readonly, nullable) NSURLResponse *response;

@property (atomic, readonly, nullable) NSError *error;

@end

NS_ASSUME_NONNULL_END
