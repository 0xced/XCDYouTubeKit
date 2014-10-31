//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "MPMoviePlayerController+OverlayView.h"

#import <objc/runtime.h>

@protocol MPMoviePlayerController_OverlayView_Types
- (void) void_bool:(BOOL)hidden bool:(BOOL)animated block:(void (^)(void))completionBlock;
@end

@implementation MPMoviePlayerController (OverlayView)

static void (*setHiddenAnimatedIMP)(id, SEL, BOOL, BOOL, void (^)(void));
static __weak MPMoviePlayerController *currentMoviePlayerController;

static void SetHiddenAnimated(id self, SEL _cmd, BOOL hidden, BOOL animated, void (^completionBlock)(void))
{
	setHiddenAnimatedIMP(self, _cmd, hidden, animated, completionBlock);
	
	currentMoviePlayerController.overlayView_xcd.hidden = hidden || currentMoviePlayerController.controlStyle != MPMovieControlStyleFullscreen;
}

+ (void) load
{
	@autoreleasepool
	{
		dispatch_async(dispatch_get_main_queue(), ^{
			NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
			[defaultCenter addObserver:self selector:@selector(xcd_overlayView_moviePlayerNowPlayingMovieDidChange:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
		});
		
		Class MPVideoPlaybackOverlayView = NSClassFromString([@[ @"MP", @"Video", @"Playback", @"Overlay", @"View" ] componentsJoinedByString:@""]);
		if (!MPVideoPlaybackOverlayView)
		{
			NSLog(@"MPMoviePlayerController+OverlayView failed to initialize. (Error #%@)", @1);
			return;
		}
		
		SEL selector = NSSelectorFromString([@[ @"set", @"Hidden", @":", @"animated", @":", @"completion", @"Block", @":" ] componentsJoinedByString:@""]);
		Method setHidden_animated_completionBlock = class_getInstanceMethod(MPVideoPlaybackOverlayView, selector);
		if (!setHidden_animated_completionBlock)
		{
			NSLog(@"MPMoviePlayerController+OverlayView failed to initialize. (Error #%@)", @2);
			return;
		}
		
		struct objc_method_description methodDescription = protocol_getMethodDescription(@protocol(MPMoviePlayerController_OverlayView_Types), @selector(void_bool:bool:block:), YES, YES);
		if (strcmp(method_getTypeEncoding(setHidden_animated_completionBlock), methodDescription.types) != 0)
		{
			NSLog(@"MPMoviePlayerController+OverlayView failed to initialize. (Error #%@)", @3);
			return;
		}
		
		setHiddenAnimatedIMP = (__typeof__(setHiddenAnimatedIMP))method_getImplementation(setHidden_animated_completionBlock);
		method_setImplementation(setHidden_animated_completionBlock, (IMP)SetHiddenAnimated);
	}
}

+ (void) xcd_overlayView_moviePlayerNowPlayingMovieDidChange:(NSNotification *)notification
{
	currentMoviePlayerController = notification.object;
}

static void *OverlayViewKey = &OverlayViewKey;

- (UIView *) overlayView_xcd
{
	return objc_getAssociatedObject(self, OverlayViewKey);
}

- (void) setOverlayView_xcd:(UIView *)overlayView
{
	if (!setHiddenAnimatedIMP)
		return;
	
	[self.overlayView_xcd removeFromSuperview];
	
	overlayView.hidden = self.controlStyle != MPMovieControlStyleFullscreen;
	overlayView.frame = (CGRect){ CGPointMake(CGRectGetMinX(overlayView.frame), 50), overlayView.frame.size };
	[self.view addSubview:overlayView];
	
	objc_setAssociatedObject(self, OverlayViewKey, overlayView, OBJC_ASSOCIATION_ASSIGN);
}

@end
