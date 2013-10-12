//
//  DemoThumbnailViewController.h
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 26.09.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

@interface DemoThumbnailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *actionButton;
@property (nonatomic, weak) IBOutlet UIView *videoContainerView;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

- (IBAction) loadThumbnail:(id)sender;

@end
