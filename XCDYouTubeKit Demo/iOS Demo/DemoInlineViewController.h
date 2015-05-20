//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

@interface DemoInlineViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *videoContainerView;
@property (nonatomic, weak) IBOutlet UISwitch *prepareToPlaySwitch;
@property (nonatomic, weak) IBOutlet UISwitch *shouldAutoplaySwitch;

- (IBAction) load:(id)sender;
- (IBAction) prepareToPlay:(UISwitch *)sender;

@end
