//
//  ViewController.m
//  YouTube Video Player Demo
//
//  Created by Cédric Luthi on 02.05.13.
//  Copyright (c) 2013 Cédric Luthi. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()
@property (nonatomic, weak) IBOutlet UITextField *videoIdentifierTextField;
@end

@implementation DemoViewController

- (IBAction) playYouTubeVideo:(id)sender
{
	NSLog(@"TODO: play '%@'", self.videoIdentifierTextField.text);
}

@end
