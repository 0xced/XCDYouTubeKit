//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoPlayerViewController.h"

#import "XCDYouTubeClient.h"

#import <objc/runtime.h>

NSString *const XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey = @"error"; // documented in -[MPMoviePlayerController initWithContentURL:]

NSString *const XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification = @"XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification";
NSString *const XCDMetadataKeyTitle = @"Title";
NSString *const XCDMetadataKeySmallThumbnailURL = @"SmallThumbnailURL";
NSString *const XCDMetadataKeyMediumThumbnailURL = @"MediumThumbnailURL";
NSString *const XCDMetadataKeyLargeThumbnailURL = @"LargeThumbnailURL";

@interface XCDYouTubeVideoPlayerViewController ()
@property (nonatomic, weak) id<XCDYouTubeOperation> videoOperation;
@property (nonatomic, assign, getter = isEmbedded) BOOL embedded;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@end

@implementation XCDYouTubeVideoPlayerViewController

static void *XCDYouTubeVideoPlayerViewControllerKey = &XCDYouTubeVideoPlayerViewControllerKey;

- (id) init
{
	return [self initWithVideoIdentifier:nil];
}

- (id) initWithContentURL:(NSURL *)contentURL
{
	@throw [NSException exceptionWithName:NSGenericException reason:@"Use the `initWithVideoIdentifier:` method instead." userInfo:nil];
}

- (id) initWithVideoIdentifier:(NSString *)videoIdentifier
{
	if (!(self = [super init]))
		return nil;
	
	if (videoIdentifier)
		self.videoIdentifier = videoIdentifier;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillEnterFullscreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:self.moviePlayer];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillExitFullscreen:) name:MPMoviePlayerWillExitFullscreenNotification object:self.moviePlayer];
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray *) preferredVideoQualities
{
	if (!_preferredVideoQualities)
		_preferredVideoQualities = @[ @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ];
	
	return _preferredVideoQualities;
}

- (void) setVideoIdentifier:(NSString *)videoIdentifier
{
	if ([videoIdentifier isEqual:self.videoIdentifier])
		return;
	
	_videoIdentifier = [videoIdentifier copy];
	
	[self.videoOperation cancel];
	self.videoOperation = [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:videoIdentifier completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		if (video)
		{
			NSURL *streamURL = nil;
			for (NSNumber *videoQuality in self.preferredVideoQualities)
			{
				streamURL = video.streamURLs[videoQuality];
				if (streamURL)
				{
					[self startVideo:video streamURL:streamURL];
					break;
				}
			}
			
			if (!streamURL)
			{
				// TODO: real error
				NSError *noStreamError = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:0 userInfo:nil];
				[self stopWithError:noStreamError];
			}
		}
		else
		{
			[self stopWithError:error];
		}
	}];
}

- (void) startVideo:(XCDYouTubeVideo *)video streamURL:(NSURL *)streamURL
{
	NSMutableDictionary *userInfo = [NSMutableDictionary new];
	if (video.title)
		userInfo[XCDMetadataKeyTitle] = video.title;
	if (video.smallThumbnailURL)
		userInfo[XCDMetadataKeySmallThumbnailURL] = video.smallThumbnailURL;
	if (video.mediumThumbnailURL)
		userInfo[XCDMetadataKeyMediumThumbnailURL] = video.mediumThumbnailURL;
	if (video.largeThumbnailURL)
		userInfo[XCDMetadataKeyLargeThumbnailURL] = video.largeThumbnailURL;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification object:self userInfo:userInfo];
	
	self.moviePlayer.contentURL = streamURL;
}

- (void) stopWithError:(NSError *)error
{
	NSDictionary *userInfo = @{ MPMoviePlayerPlaybackDidFinishReasonUserInfoKey: @(MPMovieFinishReasonPlaybackError),
	                            XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey: error };
	[[NSNotificationCenter defaultCenter] postNotificationName:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer userInfo:userInfo];
	
	if (self.isEmbedded)
		[self.moviePlayer.view removeFromSuperview];
	else
		[self.presentingViewController dismissMoviePlayerViewControllerAnimated];
}

- (void) presentInView:(UIView *)view
{
	self.embedded = YES;
	
	self.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
	self.moviePlayer.view.frame = CGRectMake(0.f, 0.f, view.bounds.size.width, view.bounds.size.height);
	self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	if (![view.subviews containsObject:self.moviePlayer.view])
		[view addSubview:self.moviePlayer.view];
	objc_setAssociatedObject(view, XCDYouTubeVideoPlayerViewControllerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - UIViewController

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if (![self isBeingPresented])
		return;
	
	self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
	[self.moviePlayer play];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	if (![self isBeingDismissed])
		return;
	
	[self.videoOperation cancel];
}

#pragma mark - Notifications

- (void) moviePlayerWillEnterFullscreen:(NSNotification *)notification
{
	UIApplication *application = [UIApplication sharedApplication];
	self.statusBarHidden = application.statusBarHidden;
	self.statusBarStyle = application.statusBarStyle;
}

- (void) moviePlayerWillExitFullscreen:(NSNotification *)notification
{
	UIApplication *application = [UIApplication sharedApplication];
	[application setStatusBarHidden:self.statusBarHidden withAnimation:UIStatusBarAnimationFade];
	[application setStatusBarStyle:self.statusBarStyle animated:YES];
}

@end
