//
//  ESLoginViewController.m
//  Easay
//
//  Created by ricky on 14-4-4.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESLoginViewController.h"

@interface ESLoginViewController ()
@property (nonatomic, assign) IBOutlet UIImageView * logo;
@property (nonatomic, assign) IBOutlet UILabel * titleLabel, * subtitleLabel, * startLabel;
@property (nonatomic, assign) IBOutlet UITextField * userField, * passField;
@property (nonatomic, assign) IBOutlet NSLayoutConstraint * titleTop;
@property (nonatomic, assign) IBOutlet NSLayoutConstraint * logoTop, * logoHeight, * accountBottom;
@property (nonatomic, assign) IBOutlet NSLayoutConstraint * textFieldTop;
@property (nonatomic, assign) IBOutlet UIButton * upButton;
- (IBAction)onUp:(id)sender;
- (IBAction)onDismissKeyboard:(id)sender;
@end

@implementation ESLoginViewController

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
    
    self.passField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.passField.layer.borderWidth = 1.0;
    image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    image.image = [UIImage imageNamed:@"pass"];
    image.contentMode = UIViewContentModeCenter;
    self.passField.leftView = image;
    self.passField.leftViewMode = UITextFieldViewModeAlways;
    self.passField.font = [UIFont fontWithName:@"Nexa Light" size:16];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.byValue = [NSValue valueWithCGPoint:CGPointMake(0, -8)];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    anim.autoreverses = YES;
    anim.repeatCount = CGFLOAT_MAX;
    anim.duration = 0.5;
    [self.upButton.layer addAnimation:anim
                               forKey:@"Up"];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)onUp:(id)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.titleTop.constant = 24;
                         self.logoTop.constant = 60;
                         self.logoHeight.constant = 118;
                         self.textFieldTop.constant = 36;
                         self.accountBottom.constant = 0;
                         [self.view layoutIfNeeded];
                         self.titleLabel.transform = CGAffineTransformMakeScale(0.6, 0.6);
                         self.subtitleLabel.alpha = 0.0;
                         self.upButton.alpha = 0.0;
                         self.startLabel.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         self.startLabel.hidden = YES;
                         self.upButton.hidden = YES;
                     }];
}

- (IBAction)onDismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

@end
