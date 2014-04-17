//
//  ESHomeViewController.m
//  Easay
//
//  Created by ricky on 14-4-14.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESHomeViewController.h"

@interface ESHomeViewController () <UIScrollViewDelegate>
@property (nonatomic, assign) IBOutlet UIScrollView * scrollView;
@property (nonatomic, assign) IBOutlet UIPageControl * pageControl;
@end

@implementation ESHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CAShapeLayer *dotLine = [CAShapeLayer layer];
    dotLine.strokeColor = [UIColor whiteColor].CGColor;
    dotLine.lineDashPattern = @[@1, @6];
    dotLine.lineWidth = 1.0;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(320, 0)];
    dotLine.path = path.CGPath;
    
    dotLine.position = CGPointMake(0, self.scrollView.frame.origin.y);
    [self.view.layer addSublayer:dotLine];
    
    self.scrollView.contentSize = CGSizeMake(960, 640);
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
