//
//  Copyright © 2015 Cédric Luthi. All rights reserved.
//

#import "PlaylistCollectionViewController.h"

#import <AVKit/AVKit.h>
#import <Google-API-Client/GTLYouTube.h>
#import <XCDYouTubeKit/XCDYouTubeKit.h>

#import "VideoCell.h"

@implementation PlaylistCollectionViewController

- (void) setItems:(NSArray *)items
{
	_items = items;
	
	[self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.items.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell" forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate

- (void) collectionView:(UICollectionView *)collectionView willDisplayCell:(VideoCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
	cell.playlistItem = self.items[indexPath.row];
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
	GTLYouTubePlaylistItem *playlistItem = self.items[indexPath.row];
	
	AVPlayerViewController *playerViewController = [AVPlayerViewController new];
	[self presentViewController:playerViewController animated:YES completion:nil];
	
	__weak AVPlayerViewController *weakPlayerViewController = playerViewController;
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:playlistItem.snippet.resourceId.videoId completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error) {
		if (video)
		{
			NSDictionary *streamURLs = video.streamURLs;
			NSURL *streamURL = streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?: streamURLs[@(XCDYouTubeVideoQualityHD720)] ?: streamURLs[@(XCDYouTubeVideoQualityMedium360)] ?: streamURLs[@(XCDYouTubeVideoQualitySmall240)];
			weakPlayerViewController.player = [AVPlayer playerWithURL:streamURL];
			[weakPlayerViewController.player play];
		}
		else
		{
			[self dismissViewControllerAnimated:YES completion:nil];
		}
	}];
}

@end
