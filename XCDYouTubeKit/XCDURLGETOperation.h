//
//  XCDURLGetOperation.h
//  XCDYouTubeKit
//
//  Created by Soneé John on 2/18/20.
//  Copyright © 2020 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

__attribute__((visibility("hidden")))
@interface XCDURLGETOperation : NSOperation

- (instancetype) initWithURL:(NSURL *)url info:(nullable NSDictionary *)info cookes:(nullable NSArray <NSHTTPCookie *> *)cookies;

@property (atomic, strong, readonly) NSURL *url;
@property (atomic, copy, readonly, nullable) NSDictionary *info;
@property (atomic, copy, readonly, nullable) NSArray <NSHTTPCookie *> *cookies;

@property (atomic, readonly, nullable) NSURLResponse *response;

@property (atomic, readonly, nullable) NSError *error;

@end

NS_ASSUME_NONNULL_END
