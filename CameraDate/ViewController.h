//
//  ViewController.h
//  CameraDate
//
//  Created by KaeJer Cho on 2015/11/6.
//  Copyright © 2015年 KaeJer Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIDatePicker *datepicker;
    NSString *date;
    UIImagePickerController *imagePicker;
    NSUserDefaults *userDefault;
    
}
- (IBAction)click:(id)sender;
- (IBAction)time:(id)sender;
@property (nonatomic) UIButton *btn;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (nonatomic)UIView *oview;
@property (strong, nonatomic) IBOutlet UIView *CamerOview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *TimeButLebel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *CamerButLabel;
@property (weak, nonatomic) IBOutlet UIButton *CameraBut;
- (void)addCameraView;
- (IBAction)TakePic:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIView *camerView;
@property (nonatomic) UIImagePickerController *imagePickerController;
@end

