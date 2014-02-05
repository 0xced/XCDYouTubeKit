//
//  XCDYouTubeVideoPlayerViewController.m
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoPlayerViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#import "XCDYouTubeExtractor.h"

NSString *const XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey = @"XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey";

NSString *const XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification = @"XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification";

@interface XCDYouTubeVideoPlayerViewController ()
@property (nonatomic, strong) XCDYouTubeExtractor *extractor;
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
	
	self.preferredVideoQualities = nil;
	
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

- (void) setVideoIdentifier:(NSString *)videoIdentifier
{
	if (![NSThread isMainThread])
	{
		[self performSelectorOnMainThread:_cmd withObject:videoIdentifier waitUntilDone:NO];
		return;
	}
	
	if ([videoIdentifier isEqual:self.videoIdentifier])
		return;
	
	_videoIdentifier = [videoIdentifier copy];
	
    self.extractor = [XCDYouTubeExtractor extractorWithVideoIdentifier:self.videoIdentifier];
    [self.extractor startWithCompletionHandler:^(NSDictionary *info, NSError *error) {
        if (!info)
        {
            [self finishWithError:error];
            return;
        }
        
        for (NSNumber *videoQuality in self.preferredVideoQualities)
        {
            NSURL *URL = info[videoQuality];
            if (URL)
            {
                NSArray *keys = @[ XCDMetadataKeyTitle, XCDMetadataKeySmallThumbnailURL, XCDMetadataKeyMediumThumbnailURL, XCDMetadataKeyLargeThumbnailURL ];
                NSMutableDictionary *userInfo = [NSMutableDictionary new];
                for (NSString *key in keys)
                {
                    id value = info[key];
                    if (value)
                    {
                        userInfo[key] = value;
                    }
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification object:self userInfo:userInfo];
                
                self.moviePlayer.contentURL = URL;
                break;
            }
        }
    }];
}

- (void) setPreferredVideoQualities:(NSArray *)preferredVideoQualities
{
	if (preferredVideoQualities)
	{
		_preferredVideoQualities = [preferredVideoQualities copy];
	}
	else
	{
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
			_preferredVideoQualities = @[ @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ];
		else
			_preferredVideoQualities = @[ @(XCDYouTubeVideoQualityHD1080), @(XCDYouTubeVideoQualityHD720), @(XCDYouTubeVideoQualityMedium360), @(XCDYouTubeVideoQualitySmall240) ];
	}
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

- (void) finishWithError:(NSError *)error
{
	NSDictionary *userInfo = @{ MPMoviePlayerPlaybackDidFinishReasonUserInfoKey: @(MPMovieFinishReasonPlaybackError),
	                            XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey: error };
	[[NSNotificationCenter defaultCenter] postNotificationName:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer userInfo:userInfo];
	
	if (self.isEmbedded)
		[self.moviePlayer.view removeFromSuperview];
	else
		[self.presentingViewController dismissMoviePlayerViewControllerAnimated];
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
	
	[self.extractor cancel];
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
