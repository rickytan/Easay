//
//  ESViewController.m
//  Easay
//
//  Created by ricky on 14-4-14.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESViewController.h"
#import "RTSiderViewController.h"
#import "ESMenuViewController.h"
#import "ESHomeViewController.h"

@interface ESViewController () <RTSiderViewControllerDatasource, RTSiderViewControllerDelegate>

@end

@implementation ESViewController

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
    RTSiderViewController *sider = [[RTSiderViewController alloc] init];
    sider.delegate = self;
    sider.dataSource = self;
    [self.view addSubview:sider.view];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RTSider

- (CGFloat)siderViewControllerMarginForSlidingToLeft:(RTSiderViewController *)controller
{
    return 84.0;
}

- (BOOL)shouldAdjustWidthOfLeftViewController
{
    return YES;
}

- (BOOL)siderViewController:(RTSiderViewController *)controller
        canSlideToDirection:(SlideState)state
{
    if ([controller.currentMiddleViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)controller.currentMiddleViewController;
        if (nav.childViewControllers.firstObject != nav.topViewController)
            return NO;
        return YES;
    }
    return YES;
}

@end
