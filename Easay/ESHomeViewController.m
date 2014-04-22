//
//  ESHomeViewController.m
//  Easay
//
//  Created by ricky on 14-4-14.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESHomeViewController.h"
#import "UIColor+RExtension.h"

@interface ESHomeViewController () <UIScrollViewDelegate>
@property (nonatomic, assign) IBOutlet UIScrollView * scrollView;
@property (nonatomic, assign) IBOutlet UIPageControl * pageControl;
@property (nonatomic, assign) IBOutlet UILabel * dateLabel, * locationLabel, * moneyLabel;
@property (nonatomic, strong) CAShapeLayer * shape0, * shape1, * shape2;
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

- (void)loadView
{
    [super loadView];
    
    self.shape0 = [CAShapeLayer layer];
    self.shape0.lineCap = kCALineCapSquare;
    self.shape0.lineWidth = 32.0;
    self.shape0.path = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                      radius:120
                                                  startAngle:0
                                                    endAngle:2*M_PI
                                                   clockwise:YES].CGPath;
    self.shape0.backgroundColor = [UIColor colorWithHexString:@"#ffe400"].CGColor;
    self.shape0.strokeStart = 0;
    [self.view.layer addSublayer:self.shape0];
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

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.dateLabel sizeToFit];
    self.shape0.position = CGPointMake(CGRectGetWidth(self.view.bounds) / 2,
                                       CGRectGetHeight(self.view.bounds) / 2);
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
