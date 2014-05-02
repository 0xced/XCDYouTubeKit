//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <XCDYouTubeKit/XCDYouTubeVideo.h>

#import <JavaScriptCore/JavaScriptCore.h>

#define XCDYouTubeErrorUseCipherSignature -1000

extern NSString *const XCDYouTubeNoStreamVideoUserInfoKey;

extern NSDictionary *XCDDictionaryWithQueryString(NSString *string, NSStringEncoding encoding);

@interface XCDYouTubeVideo ()

- (instancetype) initWithIdentifier:(NSString *)identifier info:(NSDictionary *)info signatureFunction:(JSValue *)signatureFunction response:(NSURLResponse *)response error:(NSError **)error;

- (void) mergeVideo:(XCDYouTubeVideo *)video;

@end
