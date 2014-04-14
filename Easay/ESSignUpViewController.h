//
//  ESSignUpViewController.h
//  Easay
//
//  Created by ricky on 14-4-13.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ESSignUpViewController;

@protocol ESSignUpViewControllerDelegate <NSObject>
@optional
- (void)signUpViewController:(ESSignUpViewController *)signUp
           didSignUpWithUser:(id)user
                       error:(NSError *)error;

@end

@interface ESSignUpViewController : UIViewController
@property (nonatomic, assign) id<ESSignUpViewControllerDelegate> delegate;
@end
