//
//  ViewController.m
//  CameraDate
//
//  Created by KaeJer Cho on 2015/11/6.
//  Copyright © 2015年 KaeJer Cho. All rights reserved.
//

#import "ViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "MBProgressHUD.h"

@interface ViewController ()<DBRestClientDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) DBRestClient *restClient;
@end
//UIButton *btn;
MBProgressHUD *hud;
NSString *currentFilePath;
NSString *currentFilename;
NSString *currentFolder;
NSMutableArray *waitFile;
NSInteger lock;
NSInteger count;
@implementation ViewController
@synthesize btn;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkFails)
                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
    
    userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:YES forKey:@"dblink"];
    if([userDefault boolForKey:@"dblink"] == NO){
        NSLog(@"Not linked");
        btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(64, 240, 200, 60);
        [btn setTitle:@"Link Dropbox" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(checkLinked) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        [self.view addSubview:btn];
    }
    else{
        NSLog(@"Linked");
    }
   
    
}
- (void)viewDidAppear:(BOOL)animated {
    userDefault = [NSUserDefaults standardUserDefaults];
    if([userDefault boolForKey:@"dblink"] == NO){
        NSLog(@"Not linked");
    }
    else{
        NSLog(@"Linked");
        [self Camerainit];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkLinked {
    userDefault = [NSUserDefaults standardUserDefaults];
    if([userDefault boolForKey:@"dblink"] == NO){
        if (![[DBSession sharedSession] isLinked]) {
            [[DBSession sharedSession] linkFromController:self];
        }
    }
   
}

- (void)check {
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
        NSLog(@"not link");
    }
    NSLog(@"linked");

}

- (void)checkFails {
    NSLog(@"Check fails");
    [self datePickInit];
    userDefault = [NSUserDefaults standardUserDefaults];
    if([userDefault objectForKey:@"waitFiles"]) {
        waitFile = [[NSMutableArray alloc]initWithArray:[userDefault objectForKey:@"waitFiles"]];
    }
    else {
        waitFile = [[NSMutableArray alloc] init];
    }
    lock = [waitFile count];
    count = 0;
    NSLog(@"Fails:%lu",(unsigned long)[waitFile count]);
    for (NSString *filename in waitFile) {
        NSString *destDir = [NSString stringWithFormat:@"/%@",[filename substringWithRange:NSMakeRange(0, 8)]];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",filename]];
        currentFilename = filename;
        hud.labelText = @"上傳中";
        [hud show:YES];
        [self.restClient uploadFile:[NSString stringWithFormat:@"%@",filename] toPath:destDir withParentRev:nil fromPath:filePath];
    }
    
    
}


- (void)restClient:(DBRestClient*)client uploadProgress:(CGFloat)progress
           forFile:(NSString*)destPath from:(NSString*)srcPath {
    dispatch_async(dispatch_get_main_queue(), ^(){
        NSLog(@"p:%f",progress);
        hud.progress = progress;
    });
//    dispatch_async(dispatch_get_main_queue(), ^{
////    NSLog(@"%.2f",progress);
//        hud.progress = progress;
//    });
}
- (void)Camerainit {
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.showsCameraControls = NO;
    imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    
    [[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
    
    self.CamerOview.frame = imagePicker.cameraOverlayView.frame;

    imagePicker.cameraOverlayView = self.CamerOview;
    
    self.CamerOview = nil;
    
    self.imagePickerController = imagePicker;
    [self presentViewController:self.imagePickerController animated:NO completion:nil];
    [self datePickInit];
    hud = [[MBProgressHUD alloc]initWithView:self.imagePickerController.view];
     hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    [self.imagePickerController.view addSubview:hud];
    [self checkFails];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //get img
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage *img;
    CGSize newSize;
    if (image.size.height > image.size.width) {
        //portrait
        img = [ViewController drawText:date
                               inImage:image
                               atPoint:CGPointMake(image.size.width * 0.65, image.size.height * 0.9)];
        
        newSize.width = 600;
        newSize.height = 800;
    }
    else
    {
        //landscape
        img = [ViewController drawText:date
                               inImage:image
                               atPoint:CGPointMake(image.size.width * 0.75, image.size.height * 0.9)];
        newSize.width = 800;
        newSize.height = 600;
    }
    
    
    UIImage *reSized = [self reSizeImage:img toSize:newSize];
    NSData *myResizedData = UIImageJPEGRepresentation(reSized, 0.5);
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:myResizedData], self,
                                   nil,
                                   nil);
    //create folder
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    userDefault = [NSUserDefaults standardUserDefaults];
    if (![userDefault boolForKey:strDate]) {
        [self.restClient createFolder:[NSString stringWithFormat:@"/%@",strDate]];
        [userDefault setBool:YES forKey:strDate];
        [userDefault synchronize];
    }


    //save local
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *forDate = [dateFormatter stringFromDate:[NSDate date]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",forDate]]; //Add the file name
    [myResizedData writeToFile:filePath atomically:YES];
    currentFilePath = filePath;
    currentFilename = forDate;
    currentFolder = strDate;
    
    //save to dropbox
    NSString *destDir = [NSString stringWithFormat:@"/%@",currentFolder];
    hud.labelText = [NSString stringWithFormat:@"上傳中:%@.jpg",currentFilename];
    [hud show:YES];
    [waitFile addObject:[NSString stringWithFormat:@"%@.jpg",currentFilename]];
    [self.restClient uploadFile:[NSString stringWithFormat:@"%@.jpg",currentFilename] toPath:destDir withParentRev:nil fromPath:filePath];
//    [picker dismissViewControllerAnimated:NO completion:nil];

    
}
- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath
              from:(NSString *)srcPath metadata:(DBMetadata *)metadata {
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
    dispatch_async(dispatch_get_main_queue(), ^{
        hud.labelText = @"上傳成功！";
        [hud hide:YES afterDelay:1];
        [waitFile removeObject:metadata.filename];
        count += 1;
        if (count == lock) {
            userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:waitFile forKey:@"waitFiles"];
            [userDefault synchronize];
        }
    });
    self.CameraBut.enabled = YES;
    [self datePickInit];
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error {
    NSLog(@"File upload failed with error: %@", error);
    dispatch_async(dispatch_get_main_queue(), ^{
        hud.labelText = @"上傳失敗！";
        [hud hide:YES afterDelay:2];
    });
    userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:waitFile forKey:@"waitFiles"];
    [userDefault synchronize];
    self.CameraBut.enabled = YES;
    [self datePickInit];
}
// Folder is the metadata for the newly created folder
- (void)restClient:(DBRestClient*)client createdFolder:(DBMetadata*)folder{
    NSLog(@"Created Folder Path %@",folder.path);
    NSLog(@"Created Folder name %@",folder.filename);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:YES forKey:strDate];


}
// [error userInfo] contains the root and path
- (void)restClient:(DBRestClient*)client createFolderFailedWithError:(NSError*)error{
    NSLog(@"%@",error);
}

- (void)datePickInit
{
    
    //UIDatePicker *oneDatePicker = [[UIDatePicker alloc] init];
    //    self.DatePicker.frame = CGRectMake(0, 425, 260, 200);
    
    //oneDatePicker.frame = CGRectMake(0, 20, 320, 300); // 设置显示的位置和大小
    //[self.DatePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    self.DatePicker.date = [NSDate date]; // 设置初始时间
    self.DatePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
    self.DatePicker.datePickerMode = UIDatePickerModeDate; // 设置样式
    [self.DatePicker addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    // [self.view addSubview:oneDatePicker]; // 添加到View上
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy/MM/dd";
    date = [selectDateFormatter stringFromDate:self.DatePicker.date];
    self.time.text = date;//get date
    
}
- (void)oneDatePickerValueChanged:(UIDatePicker *) sender {
    
    NSDate *select = [sender date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy/MM/dd"; // 设置时间和日期的格式
    date = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    self.time.text = date;
    NSLog(@"%@", [sender date]);
}


- (void)renderView:(UIView*)view inContext:(CGContextRef)context
{
    // -renderInContext: renders in the coordinate space of the layer,
    // so we must first apply the layer's geometry to the graphics context
    CGContextSaveGState(context);
    
    // Center the context around the window's anchor point
    CGContextTranslateCTM(context, [view center].x, [view center].y - 72);
    // Apply the window's transform about the anchor point
    CGContextConcatCTM(context, [view transform]);
    // Offset by the portion of the bounds left of and above the anchor point
    CGContextTranslateCTM(context,
                          -[view bounds].size.width * [[view layer] anchorPoint].x,
                          -[view bounds].size.height * [[view layer] anchorPoint].y);
    
    // Render the layer hierarchy to the current context
    [[view layer] renderInContext:context];
    
    // Restore the context
    CGContextRestoreGState(context);
}


+(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    UIFont *font = [UIFont boldSystemFontOfSize:150];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor redColor] set];
    [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;}

- (IBAction)TakePic:(id)sender {
    [self.imagePickerController takePicture];
    self.CameraBut.enabled=NO;
    
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}
@end
