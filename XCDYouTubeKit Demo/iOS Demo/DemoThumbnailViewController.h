//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

@interface DemoThumbnailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *actionButton;
@property (nonatomic, weak) IBOutlet UIView *videoContainerView;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

- (IBAction) loadThumbnail:(id)sender;

@end
