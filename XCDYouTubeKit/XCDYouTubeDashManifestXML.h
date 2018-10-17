//
//  XCDYouTubeDashManifestXML.h
//  XCDYouTubeKit
//
//  Created by Soneé John on 10/24/17.
//  Copyright © 2017 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>
__attribute__((visibility("hidden")))
@interface XCDYouTubeDashManifestXML : NSObject

- (instancetype)initWithXMLString:(NSString *)XMLString;

- (NSDictionary *)streamURLs;

@end
