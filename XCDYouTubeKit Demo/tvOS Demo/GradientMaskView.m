//
//  Copyright © 2015 Cédric Luthi. All rights reserved.
//

#import "GradientMaskView.h"

@interface GradientMaskView ()

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;

@end

@implementation GradientMaskView

- (instancetype) initWithFrame:(CGRect)frame
{
	if (!(self = [super initWithFrame:frame]))
		return nil;
	
	[self commonInit];
	
	return self;
}

- (instancetype) initWithCoder:(NSCoder *)decoder
{
	if (!(self = [super initWithCoder:decoder]))
		return nil;
	
	[self commonInit];
	
	return self;
}

- (void) commonInit
{
	_maskPosition = @{ @"start": @0, @"end": @0 };
	
	CAGradientLayer *gradientLayer = [CAGradientLayer new];
	gradientLayer.colors = @[ (__bridge id)[UIColor colorWithWhite:0 alpha:0].CGColor, (__bridge id)[UIColor colorWithWhite:0 alpha:1].CGColor ];
	[self.layer addSublayer:gradientLayer];
	_gradientLayer = gradientLayer;
	
	[self updateGradientLayer];
}

- (void) setMaskPosition:(NSDictionary<NSString *,NSNumber *> *)maskPosition
{
	_maskPosition = maskPosition;
	
	[self updateGradientLayer];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	[self updateGradientLayer];
}

- (void) updateGradientLayer
{
	CGSize size = self.bounds.size;
	
	self.gradientLayer.frame = (CGRect){ CGPointZero, size };
	
	CGFloat start = [self.maskPosition[@"start"] floatValue];
	CGFloat end = [self.maskPosition[@"end"] floatValue];
	self.gradientLayer.locations = @[ @(end / size.height), @(start / size.height) ];
}

@end
