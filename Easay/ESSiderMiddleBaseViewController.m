//
//  ESSiderMiddleBaseViewController.m
//  Easay
//
//  Created by ricky on 14-4-18.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESSiderMiddleBaseViewController.h"
#import "RTSiderViewController.h"

@interface ESSiderMiddleBaseViewController ()
@property (nonatomic, strong) UIButton * menuButton;
- (void)onMenu:(id)sender;
@end

@implementation ESSiderMiddleBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.menuButton setImage:[UIImage imageNamed:@"menu"]
                     forState:UIControlStateNormal];
    [self.menuButton addTarget:self
                        action:@selector(onMenu:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.menuButton sizeToFit];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:self.menuButton];
    self.navigationItem.leftBarButtonItem = menuItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.menuButton.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - Action

- (void)onMenu:(id)sender
{
    [self.siderViewController slideToRightAnimated:YES];
    [UIView animateWithDuration:0.2
                          delay:0.35
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.menuButton.transform = CGAffineTransformMakeRotation(M_PI_2);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

@end

@interface ESSiderMiddleBaseTableViewController ()
@property (nonatomic, strong) UIButton * menuButton;
- (void)onMenu:(id)sender;
@end

@implementation ESSiderMiddleBaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.menuButton setImage:[UIImage imageNamed:@"menu"]
                     forState:UIControlStateNormal];
    [self.menuButton addTarget:self
                        action:@selector(onMenu:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.menuButton sizeToFit];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:self.menuButton];
    self.navigationItem.leftBarButtonItem = menuItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.menuButton.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - Action

- (void)onMenu:(id)sender
{
    [self.siderViewController slideToRightAnimated:YES];
    [UIView animateWithDuration:0.2
                          delay:0.35
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.menuButton.transform = CGAffineTransformMakeRotation(M_PI_2);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

@end
