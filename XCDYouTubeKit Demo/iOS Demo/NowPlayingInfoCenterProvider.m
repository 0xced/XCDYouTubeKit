//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "NowPlayingInfoCenterProvider.h"

@implementation NowPlayingInfoCenterProvider

- (instancetype) init
{
	if (!(self = [super init]))
		return nil;
	
	self.enabled = YES;
	
	return self;
}

- (void) setEnabled:(BOOL)enabled
{
	if (_enabled == enabled)
		return;
	
	_enabled = enabled;
	
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	if (enabled)
		[defaultCenter addObserver:self selector:@selector(videoPlayerViewControllerDidReceiveVideo:) name:XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification object:nil];
	else
		[defaultCenter removeObserver:self name:XCDYouTubeVideoPlayerViewControllerDidReceiveVideoNotification object:nil];
}

- (void) videoPlayerViewControllerDidReceiveVideo:(NSNotification *)notification
{
	XCDYouTubeVideo *video = notification.userInfo[XCDYouTubeVideoUserInfoKey];
	NSString *title = video.title;
	if (title)
		[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = @{ MPMediaItemPropertyTitle: title };
	
	[NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:video.mediumThumbnailURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
	{
		if (data)
		{
			UIImage *image = [UIImage imageWithData:data];
			MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
			if (title && artwork)
				[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = @{ MPMediaItemPropertyTitle: title, MPMediaItemPropertyArtwork: artwork };
		}
	}];
}

@end
