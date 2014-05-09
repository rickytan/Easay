//
//  ESActivityViewController.m
//  Easay
//
//  Created by ricky on 14-5-9.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESActivityViewController.h"
#import "UIColor+RExtension.h"

@interface ESActivityViewController ()
@property (nonatomic, strong) CAShapeLayer * shapeLayer;
@end

@implementation ESActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.lineCap = kCALineCapSquare;
    self.shapeLayer.lineDashPattern = @[@3, @30];
    self.shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
    self.shapeLayer.lineWidth = 24;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(300, 0)];
    self.shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:self.shapeLayer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.shapeLayer.frame = CGRectMake(10, 300, 300, 32);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
