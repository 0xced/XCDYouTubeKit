//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "PlayerEventLogger.h"
#import "NowPlayingInfoCenterProvider.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, readonly) PlayerEventLogger *playerEventLogger;
@property (nonatomic, readonly) NowPlayingInfoCenterProvider *nowPlayingInfoCenterProvider;

@end
