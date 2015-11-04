//
//  Copyright © 2015 Cédric Luthi. All rights reserved.
//

#import "VideoCell.h"

@interface VideoCell ()

@property (nonatomic, strong) NSURLSessionDataTask *imageDataTask;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation VideoCell

- (void) prepareForReuse
{
	self.playlistItem = nil;
	[self.imageDataTask cancel];
}

- (void) setPlaylistItem:(GTLYouTubePlaylistItem *)playlistItem
{
	_playlistItem = playlistItem;
	
	self.titleLabel.text = playlistItem.snippet.title;
	
	GTLYouTubeThumbnailDetails *thumbnails = playlistItem.snippet.thumbnails;
	GTLYouTubeThumbnail *thumbnail = thumbnails.maxres ?: thumbnails.high ?: thumbnails.medium ?: thumbnails.standard;
	NSURL *thumbnailURL = [NSURL URLWithString:thumbnail.url];
	self.imageDataTask = [[NSURLSession sharedSession] dataTaskWithURL:thumbnailURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			self.imageView.image = self.playlistItem == playlistItem ? [UIImage imageWithData:data] : nil;
		});
	}];
	[self.imageDataTask resume];
}

- (void) didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator
{
	[coordinator addCoordinatedAnimations:^{
		self.titleLabel.textColor = self.isFocused ? [UIColor whiteColor] : [UIColor blackColor];
	} completion:nil];
}


@end
