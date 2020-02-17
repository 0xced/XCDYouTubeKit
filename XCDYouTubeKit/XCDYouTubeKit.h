//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import <TargetConditionals.h>

#import "XCDYouTubeClient.h"
#import "XCDYouTubeError.h"
#import "XCDYouTubeLogger.h"
#import "XCDYouTubeOperation.h"
#import "XCDYouTubeVideo.h"
#import "XCDYouTubeVideoOperation.h"
#import "XCDYouTubeVideoQueryOperation.h"

#if TARGET_OS_IOS || (!defined(TARGET_OS_IOS) && TARGET_OS_IPHONE)
#import "XCDYouTubeVideoPlayerViewController.h"
#endif
