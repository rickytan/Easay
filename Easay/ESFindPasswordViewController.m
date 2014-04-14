//
//  ESFindPasswordViewController.m
//  Easay
//
//  Created by ricky on 14-4-13.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESFindPasswordViewController.h"
#import "ProgressHUD.h"

@interface ESFindPasswordViewController ()
@property (nonatomic, assign) IBOutlet UITextField * emailField;
- (IBAction)onResetPass:(id)sender;
@end

@implementation ESFindPasswordViewController

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
    UIImageView *image = nil;
    
    self.emailField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.emailField.layer.borderWidth = 1.0;
    image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    image.image = [UIImage imageNamed:@"mail"];
    image.contentMode = UIViewContentModeCenter;
    self.emailField.leftView = image;
    self.emailField.leftViewMode = UITextFieldViewModeAlways;
    self.emailField.font = [UIFont fontWithName:@"Nexa Light" size:16];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.emailField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onResetPass:(id)sender
{
    [ProgressHUD show:@"Loading..."];
    [self.view endEditing:YES];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [ProgressHUD dismiss];
        [self dismissViewControllerAnimated:YES
                                 completion:NULL];
    });
}

@end
