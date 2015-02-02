//
//  VideoPickerController.h
//  XCDYouTubeKit Demo
//
//  Created by Cédric Luthi on 20.01.15.
//  Copyright (c) 2015 Cédric Luthi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoPickerController;

@protocol VideoPickerControllerDelegate <NSObject>
@optional
- (void) videoPickerController:(VideoPickerController *)videoPickerController didSelectVideoWithIdentifier:(NSString *)videoIdentifier;
@end

@interface VideoPickerController : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *videos;

@property (nonatomic, weak) IBOutlet id<VideoPickerControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;

- (IBAction) togglePickerView:(id)sender;
- (IBAction) showPickerView:(id)sender;
- (IBAction) hidePickerView:(id)sender;

@end
