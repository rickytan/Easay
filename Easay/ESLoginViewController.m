//
//  ESLoginViewController.m
//  Easay
//
//  Created by ricky on 14-4-4.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESLoginViewController.h"
#import "ESSignUpViewController.h"
#import "ESViewController.h"
#import "ProgressHUD.h"

@interface ESLoginViewController () <ESSignUpViewControllerDelegate>
@property (nonatomic, assign) IBOutlet UIImageView * logo;
@property (nonatomic, assign) IBOutlet UILabel * titleLabel, * subtitleLabel, * startLabel;
@property (nonatomic, assign) IBOutlet UITextField * userField, * passField;
@property (nonatomic, assign) IBOutlet NSLayoutConstraint * titleTop;
@property (nonatomic, assign) IBOutlet NSLayoutConstraint * logoTop, * logoHeight, * accountBottom;
@property (nonatomic, assign) IBOutlet NSLayoutConstraint * textFieldTop;
@property (nonatomic, assign) IBOutlet UIButton * upButton;
- (IBAction)onUp:(id)sender;
- (IBAction)onLogin:(id)sender;
- (IBAction)onPan:(UIPanGestureRecognizer *)pan;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SignUpSegue"]) {
        ((ESSignUpViewController *)((UINavigationController *)segue.destinationViewController).topViewController).delegate = self;
    }
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

- (IBAction)onPan:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint trans = [pan translationInView:self.view];
            CGFloat ratio = -trans.y / 300;
            if (ratio < 0) ratio = 0;
            if (ratio > 1) ratio = 1;
            
            self.titleTop.constant = ratio * 24 + (1-ratio) * 72;
            self.logoTop.constant = ratio * 60 + (1-ratio) * 202;
            self.logoHeight.constant = ratio * 118 + (1-ratio) * 225;
            self.textFieldTop.constant = ratio * 36 + (1-ratio) * 300;
            self.accountBottom.constant = ratio * 0 + (1-ratio) * -100;
            [self.view layoutIfNeeded];
            self.titleLabel.transform = CGAffineTransformMakeScale(ratio * 0.6 + (1-ratio), ratio * 0.6 + (1-ratio));
            self.subtitleLabel.alpha = 1-ratio;
            self.upButton.alpha = 1-ratio;
            self.startLabel.alpha = 1-ratio;
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint trans = [pan translationInView:self.view];
            CGFloat ratio = -trans.y / 300;
            if (ratio > 0.2) {
                [self onUp:nil];
                pan.enabled = NO;
            }
        }
            break;
        default:
            break;
    }
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

- (IBAction)onLogin:(id)sender
{
    [ProgressHUD show:@"Loading..."];
    [self.view endEditing:YES];

    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [ProgressHUD dismiss];
        [self performSegueWithIdentifier:@"ShowHomeSegue"
                                  sender:self];
    });
}

#pragma mark - ESSignUp

- (void)signUpViewController:(ESSignUpViewController *)signUp didSignUpWithUser:(id)user error:(NSError *)error
{
    if (user) {
        [signUp dismissViewControllerAnimated:YES
                                   completion:^{
                                       [self onLogin:nil];
                                   }];
    }
}

@end
