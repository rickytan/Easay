//
//  UIViewController+ES.m
//  Easay
//
//  Created by ricky on 14-4-13.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "UIViewController+ES.h"

@implementation UIViewController (ES)

- (IBAction)onDismiss:(id)sender
{
    if (![self.navigationController popViewControllerAnimated:YES])
        [self dismissViewControllerAnimated:YES
                                 completion:NULL];
}

- (IBAction)onDismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

@end
