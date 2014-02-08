//
//  DemoExtractorViewController.h
//  YouTube Video Player Demo
//
//  Created by Adrien Truong on 2/7/14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoExtractorViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *videoIdentifierTextField;
@property (nonatomic, weak) IBOutlet UILabel *URL240Label;
@property (nonatomic, weak) IBOutlet UILabel *URL360Label;
@property (nonatomic, weak) IBOutlet UILabel *URL720Label;
@property (nonatomic, weak) IBOutlet UILabel *URL1080Label;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *smallPicLabel;
@property (nonatomic, weak) IBOutlet UILabel *medPicLabel;
@property (nonatomic, weak) IBOutlet UILabel *bigPicLabel;

- (IBAction) extract:(id)sender;

@end
