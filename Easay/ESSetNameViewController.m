//
//  ESSetNameViewController.m
//  Easay
//
//  Created by ricky on 14-5-10.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESSetNameViewController.h"
#import "UIViewController+ES.h"

@interface ESSetNameViewController ()
@property (nonatomic, assign) IBOutlet UITextField *textField;
@end

@implementation ESSetNameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-back"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(onDismiss:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.textField.layer.borderWidth = 1.0;
    self.textField.layer.borderColor = [UIColor whiteColor].CGColor;
    UIView *spacer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 40)];
    spacer.backgroundColor = [UIColor clearColor];
    self.textField.leftView = spacer;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
