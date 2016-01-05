//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

@import UIKit;

@interface DemoInlineViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *videoContainerView;
@property (nonatomic, weak) IBOutlet UISwitch *prepareToPlaySwitch;
@property (nonatomic, weak) IBOutlet UISwitch *shouldAutoplaySwitch;

- (IBAction) load:(id)sender;
- (IBAction) prepareToPlay:(UISwitch *)sender;

@end
