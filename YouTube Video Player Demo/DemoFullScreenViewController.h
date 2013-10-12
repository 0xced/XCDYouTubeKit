//
//  DemoFullScreenViewController.h
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 26.09.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

@interface DemoFullScreenViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *videoIdentifierTextField;
@property (nonatomic, weak) IBOutlet UISwitch *lowQualitySwitch;

- (IBAction) play:(id)sender;

@end
