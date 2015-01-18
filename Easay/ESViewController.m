//
//  ESViewController.m
//  Easay
//
//  Created by ricky on 14-4-14.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESViewController.h"
#import "ESMenuViewController.h"
#import "ESHomeViewController.h"

@interface ESViewController ()

@end

@implementation ESViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.

    /*
    self.delegate = self;
    self.dataSource = self;
     */
    self.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    [self setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNav"]];
    [self setLeftDrawerViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Menu"]];
    
    /*
    [self setMiddleViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNav"]];
    [self setLeftViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Menu"]];
     */
}

@end
