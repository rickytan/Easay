//
//  ESShareViewController.m
//  Easay
//
//  Created by ricky on 14-4-18.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESShareViewController.h"
#import "UIFont+ES.h"

@interface ESShareViewController () <UITextViewDelegate>
@property (nonatomic, assign) IBOutlet UITextView * textView;
@end

@implementation ESShareViewController

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
    self.textView.font = [UIFont lightFontWithSize:12];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextView

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.textView.layer.borderWidth = 0.0;
}

@end
