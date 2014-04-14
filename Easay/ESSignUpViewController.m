//
//  ESSignUpViewController.m
//  Easay
//
//  Created by ricky on 14-4-13.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESSignUpViewController.h"
#import "ProgressHUD.h"

@interface ESSignUpViewController () <
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UIActionSheetDelegate
>
@property (nonatomic, assign) IBOutlet UITextField * userField, * passField, * emailField;
@property (nonatomic, assign) IBOutlet UIButton * headerButton;

- (IBAction)onHeader:(id)sender;
- (IBAction)onContinue:(id)sender;
@end

@implementation ESSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.userField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userField.layer.borderWidth = 1.0;
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    image.image = [UIImage imageNamed:@"user"];
    image.contentMode = UIViewContentModeCenter;
    self.userField.leftView = image;
    self.userField.leftViewMode = UITextFieldViewModeAlways;
    self.userField.font = [UIFont fontWithName:@"Nexa Light" size:16];
    
    self.emailField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.emailField.layer.borderWidth = 1.0;
    image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    image.image = [UIImage imageNamed:@"mail"];
    image.contentMode = UIViewContentModeCenter;
    self.emailField.leftView = image;
    self.emailField.leftViewMode = UITextFieldViewModeAlways;
    self.emailField.font = [UIFont fontWithName:@"Nexa Light" size:16];
    
    self.passField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.passField.layer.borderWidth = 1.0;
    image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    image.image = [UIImage imageNamed:@"pass"];
    image.contentMode = UIViewContentModeCenter;
    self.passField.leftView = image;
    self.passField.leftViewMode = UITextFieldViewModeAlways;
    self.passField.font = [UIFont fontWithName:@"Nexa Light" size:16];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.userField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)onHeader:(id)sender
{
    UIActionSheet *actions = [[UIActionSheet alloc] initWithTitle:nil
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:@"从相机拍摄", @"从相册选取", nil];
    [actions showInView:self.view];
}

- (IBAction)onContinue:(id)sender
{
    [ProgressHUD show:@"Loading..."];
    [self.view endEditing:YES];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [ProgressHUD dismiss];
        if ([self.delegate respondsToSelector:@selector(signUpViewController:didSignUpWithUser:error:)]) {
            [self.delegate signUpViewController:self
                              didSignUpWithUser:[NSObject new]
                                          error:nil];
        }
    });
}

#pragma mark - UIAction

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        UIImagePickerControllerSourceType type = (buttonIndex == 0) ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
        if (![UIImagePickerController isSourceTypeAvailable:type]) {
            [[[UIAlertView alloc] initWithTitle:(type == UIImagePickerControllerSourceTypeCamera) ? @"您的设备不支持拍照":@"您没有相册"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"好"
                              otherButtonTitles:nil] show];
            return;
        }
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = type;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker
                           animated:YES
                         completion:NULL];
    }
}

#pragma mark - UIImagePicker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES
                               completion:^{
                                   UIImage *image = info[UIImagePickerControllerEditedImage];
                                   [self.headerButton setTitle:nil
                                                      forState:UIControlStateNormal];
                                   [self.headerButton setImage:image
                                                      forState:UIControlStateNormal];
                                   
                               }];
}

@end
