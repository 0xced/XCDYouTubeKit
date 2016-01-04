//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

@import UIKit;

@class VideoPickerController;

@protocol VideoPickerControllerDelegate <NSObject>
@optional
- (void) videoPickerController:(VideoPickerController *)videoPickerController didSelectVideoWithIdentifier:(NSString *)videoIdentifier;
@end

@interface VideoPickerController : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, copy) NSArray *videos;

@property (nonatomic, weak) IBOutlet id<VideoPickerControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;

- (IBAction) togglePickerView:(id)sender;
- (IBAction) showPickerView:(id)sender;
- (IBAction) hidePickerView:(id)sender;

@end
