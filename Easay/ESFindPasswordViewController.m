//
//  ESFindPasswordViewController.m
//  Easay
//
//  Created by ricky on 14-4-13.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESFindPasswordViewController.h"

@interface ESFindPasswordViewController ()
@property (nonatomic, assign) IBOutlet UITextField * emailField;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
