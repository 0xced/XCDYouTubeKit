//
//  ViewController.m
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import "DemoViewController.h"

#import "XCDYouTubeVideoPlayerViewController.h"

@interface DemoViewController () <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *videoIdentifierTextField;
@property (nonatomic, weak) IBOutlet UISwitch *lowQualitySwitch;
@property (nonatomic, weak) IBOutlet UIView *videoContainerView;
@property (nonatomic, weak) IBOutlet UISwitch *fullScreenSwitch;

@property (nonatomic, strong) XCDYouTubeVideoPlayerViewController *videoPlayerViewController;
@end

@implementation DemoViewController

- (id) initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
	if (!(self = [super initWithNibName:nibName bundle:nibBundle]))
		return nil;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerViewControllerDidReceiveMetadata:) name:XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification object:nil];
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *) title
{
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

- (void) viewDidLoad
{
	self.videoIdentifierTextField.superview.layer.cornerRadius = 10.f;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.view endEditing:YES];
}

- (IBAction) playYouTubeVideo:(id)sender
{
	if (!self.videoPlayerViewController)
		self.videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:self.videoIdentifierTextField.text];
	else
		self.videoPlayerViewController.videoIdentifier = self.videoIdentifierTextField.text;
	
	if (self.lowQualitySwitch.on)
		self.videoPlayerViewController.preferredVideoQualities = @[ @(XCDYouTubeVideoQualitySmall240), @(XCDYouTubeVideoQualityMedium360) ];
	
	if (self.fullScreenSwitch.on)
		[self presentMoviePlayerViewControllerAnimated:self.videoPlayerViewController];
	else if (![self.videoContainerView.subviews containsObject:self.videoPlayerViewController.moviePlayer.view])
		[self.videoPlayerViewController presentInView:self.videoContainerView];
}

- (IBAction) playTrendingVideo:(id)sender
{
	XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [XCDYouTubeVideoPlayerViewController new];
	if (self.fullScreenSwitch.on)
	{
		[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
	}
	else
	{
		[self.videoContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[videoPlayerViewController presentInView:self.videoContainerView];
		[videoPlayerViewController.moviePlayer prepareToPlay];
	}
	
	// https://developers.google.com/youtube/2.0/developers_guide_protocol_video_feeds#Standard_feeds
	NSURL *url = [NSURL URLWithString:@"https://gdata.youtube.com/feeds/api/standardfeeds/on_the_web?v=2&alt=json&max-results=1"];
	[NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		id json = [NSJSONSerialization JSONObjectWithData:data ?: [NSData new] options:0 error:NULL];
		NSString *videoIdentifier = [[[json valueForKeyPath:@"feed.entry.media$group.yt$videoid.$t"] lastObject] description];
		videoPlayerViewController.videoIdentifier = videoIdentifier;
	}];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
	[self playYouTubeVideo:textField];
	return YES;
}

#pragma mark - Notifications

- (void) videoPlayerViewControllerDidReceiveMetadata:(NSNotification *)notification
{
	if (notification.object != self.videoPlayerViewController)
		return;
	
	NSURL *thumbnailURL = notification.userInfo[XCDMetadataKeyMediumThumbnailURL] ?: notification.userInfo[XCDMetadataKeySmallThumbnailURL];
	[NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:thumbnailURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		UIImageView *thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.videoContainerView.bounds.size.width, self.videoContainerView.bounds.size.height)];
		thumbnailImageView.image = [UIImage imageWithData:data];
		thumbnailImageView.backgroundColor = [UIColor blackColor];
		thumbnailImageView.contentMode = UIViewContentModeScaleAspectFit;
		thumbnailImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		thumbnailImageView.userInteractionEnabled = YES;
		[self.videoContainerView addSubview:thumbnailImageView];
		
		// Do not get the `Play` image like this in production code
		NSString *simulatorRoot = [[[NSProcessInfo processInfo] environment] objectForKey:@"IPHONE_SIMULATOR_ROOT"] ?: @"";
		NSBundle *quickTimePlugin = [NSBundle bundleWithPath:[simulatorRoot stringByAppendingPathComponent:@"/System/Library/Internet Plug-Ins/QuickTime Plugin.webplugin"]];
		NSURL *playURL = [quickTimePlugin URLForResource:@"Play" withExtension:@"png"];
		UIImage *playImage = [UIImage imageWithContentsOfFile:playURL.path];
		UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
		playButton.frame = thumbnailImageView.frame;
		playButton.autoresizingMask = thumbnailImageView.autoresizingMask;
		[playButton setImage:playImage forState:UIControlStateNormal];
		[playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
		[thumbnailImageView addSubview:playButton];
	}];
}

- (void) play:(UIButton *)sender
{
	[UIView animateWithDuration:0.3f animations:^{
		sender.superview.alpha = 0.f;
	} completion:^(BOOL finished) {
		[sender.superview removeFromSuperview];
	}];
	
	[self.videoPlayerViewController.moviePlayer play];
}

@end
