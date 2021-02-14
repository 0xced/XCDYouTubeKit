//
//  Copyright © 2013-2016 Cédric Luthi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GoogleAPIClientForREST/GTLRYouTube.h>

@interface VideoCell : UICollectionViewCell

@property (nonatomic, strong) GTLRYouTube_PlaylistItem *playlistItem;

@end
