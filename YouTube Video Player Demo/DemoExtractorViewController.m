//
//  DemoExtractorViewController.m
//  YouTube Video Player Demo
//
//  Created by Adrien Truong on 2/7/14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import "DemoExtractorViewController.h"

@interface DemoExtractorViewController ()

@property (nonatomic, strong) XCDYouTubeExtractor *extractor;

@end

@implementation DemoExtractorViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.videoIdentifierTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"VideoIdentifier"];
}

- (IBAction) extract:(id)sender
{
    [self.view endEditing:YES];

    if (self.extractor.isExtracting)
    {
        NSLog(@"Already extracting. Wait until done.");
        return;
    }
    
    self.extractor = [XCDYouTubeExtractor extractorWithVideoIdentifier:self.videoIdentifierTextField.text];
    [self.extractor startWithCompletionHandler:^(NSDictionary *info, NSError *error) {
        if (!info)
        {
            NSLog(@"Error extracting:%@", [error userInfo]);
        }
        
        self.URL240Label.text = [info[@(XCDYouTubeVideoQualitySmall240)] absoluteString];
        self.URL360Label.text = [info[@(XCDYouTubeVideoQualityMedium360)] absoluteString];
        self.URL720Label.text = [info[@(XCDYouTubeVideoQualityHD720)] absoluteString];
        self.URL1080Label.text = [info[@(XCDYouTubeVideoQualityHD1080)] absoluteString];
        self.titleLabel.text = info[XCDMetadataKeyTitle];
        self.smallPicLabel.text = [info[XCDMetadataKeySmallThumbnailURL] absoluteString];
        self.medPicLabel.text = [info[XCDMetadataKeyMediumThumbnailURL] absoluteString];
        self.bigPicLabel.text = [info[XCDMetadataKeyLargeThumbnailURL] absoluteString];
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
	[self extract:textField];
	return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
	[[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"VideoIdentifier"];
}

@end
