//
//  VideoPickerController.m
//  XCDYouTubeKit Demo
//
//  Created by Cédric Luthi on 20.01.15.
//  Copyright (c) 2015 Cédric Luthi. All rights reserved.
//

#import "VideoPickerController.h"

@implementation VideoPickerController

@synthesize videos = _videos;

- (NSArray *) videos
{
	if (!_videos)
		_videos = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"YouTubeDemoVideos"];
	return _videos;
}

- (void) setVideos:(NSArray *)videos
{
	_videos = videos;
	[self.pickerView reloadAllComponents];
}

- (void) setPickerView:(UIPickerView *)pickerView
{
	_pickerView = pickerView;
	[self hidePickerViewAnimated:NO];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return self.videos.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [[self.videos[row] allKeys] firstObject];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSString *videoIdentifier = [[self.videos[row] allValues] firstObject];
	
	if ([self.delegate respondsToSelector:@selector(videoPickerController:didSelectVideoWithIdentifier:)])
		[self.delegate videoPickerController:self didSelectVideoWithIdentifier:videoIdentifier];
}

#pragma mark - Picker View

- (IBAction) togglePickerView:(id)sender
{
	if (CGAffineTransformIsIdentity(self.pickerView.transform))
		[self hidePickerView:sender];
	else
		[self showPickerView:sender];
}

- (IBAction) showPickerView:(id)sender
{
	[self showPickerViewAnimated:YES];
}

- (IBAction) hidePickerView:(id)sender
{
	[self hidePickerViewAnimated:YES];
}

- (void) updatePickerViewTransform:(CGAffineTransform)transform animated:(BOOL)animated
{
	void (^updateTransform)(void) = ^{
		self.pickerView.transform = transform;
	};
	
	if (animated)
		[UIView animateWithDuration:0.3f animations:updateTransform];
	else
		updateTransform();
}

- (void) showPickerViewAnimated:(BOOL)animated;
{
	[self updatePickerViewTransform:CGAffineTransformIdentity animated:animated];
}

- (void) hidePickerViewAnimated:(BOOL)animated;
{
	[self updatePickerViewTransform:CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.pickerView.frame)) animated:animated];
}

@end
