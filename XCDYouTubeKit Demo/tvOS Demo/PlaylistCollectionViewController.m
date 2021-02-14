//
//  Copyright © 2013-2016 Cédric Luthi. All rights reserved.
//

#import "PlaylistCollectionViewController.h"

#import <AVKit/AVKit.h>
#import <GoogleAPIClientForREST/GTLRYouTube.h>
#import <XCDYouTubeKit/XCDYouTubeKit.h>

#import "VideoCell.h"
#import "GradientMaskView.h"

@implementation PlaylistCollectionViewController

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	self.collectionView.maskView = [GradientMaskView new];
}

- (void) viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	GradientMaskView *maskView = (GradientMaskView *)self.collectionView.maskView;
	maskView.maskPosition = ({
		CGFloat end = [maskView.maskPosition[@"end"] floatValue];
		CGFloat maximumMaskStart = end + (self.topLayoutGuide.length * 0.5);
		CGFloat verticalScrollPosition = MAX(0, self.collectionView.contentOffset.y + self.collectionView.contentInset.top);
		@{
		   @"start": @( MIN(maximumMaskStart, end + verticalScrollPosition) ),
		   @"end":   @( self.topLayoutGuide.length * 0.8 )
		};
	});
	maskView.frame = (CGRect){ (CGPoint){0, self.collectionView.contentOffset.y}, self.collectionView.bounds.size };
}

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
	GTLRYouTube_PlaylistItem *playlistItem = self.items[indexPath.row];
	
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
