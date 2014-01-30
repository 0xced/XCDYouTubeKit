//
//  DemoInlineViewController.h
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 26.09.13.
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

@interface DemoInlineViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *videoContainerView;
@property (nonatomic, weak) IBOutlet UISwitch *prepareToPlaySwitch;
@property (nonatomic, weak) IBOutlet UISwitch *shouldAutoplaySwitch;

- (IBAction) load:(id)sender;
- (IBAction) prepareToPlay:(UISwitch *)sender;

@end
