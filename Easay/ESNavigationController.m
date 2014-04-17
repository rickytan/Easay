//
//  ESNavigationController.m
//  Easay
//
//  Created by ricky on 14-4-18.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESNavigationController.h"

@interface ESNavigationController ()

@end

@implementation ESNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.visibleViewController preferredStatusBarStyle];
}

@end
