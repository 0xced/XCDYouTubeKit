//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

@interface DemoFullScreenViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *videoIdentifierTextField;
@property (nonatomic, weak) IBOutlet UISwitch *lowQualitySwitch;

- (IBAction) play:(id)sender;

@end
