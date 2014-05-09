//
//  ESHomeViewController.m
//  Easay
//
//  Created by ricky on 14-4-14.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESHomeViewController.h"
#import "UIColor+RExtension.h"
#import "UIFont+ES.h"

@interface ESHomeViewController () <UIScrollViewDelegate>
@property (nonatomic, assign) IBOutlet UIScrollView * scrollView;
@property (nonatomic, assign) IBOutlet UIPageControl * pageControl;
@property (nonatomic, assign) IBOutlet UILabel * dateLabel, * locationLabel, * moneyLabel;
@property (nonatomic, assign) IBOutlet UILabel * distThisWeek, * distLastWeek, * costThisWeek, * costLastWeek;
@property (nonatomic, strong) CAShapeLayer * shape0, * shape1, * shape2;
@property (nonatomic, strong) CATextLayer * textLayer;
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

- (CAShapeLayer *)shapeWithRadius:(CGFloat)radius andColor:(UIColor *)color
{
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.lineCap = kCALineCapSquare;
    shape.lineWidth = 18.0;
    shape.fillColor = [UIColor clearColor].CGColor;
    shape.strokeColor = color.CGColor;
    shape.strokeStart = 0.0;
    shape.strokeEnd = 0.0;
    shape.path = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                radius:radius
                                            startAngle:0
                                              endAngle:2*M_PI
                                             clockwise:YES].CGPath;
    [self.view.layer addSublayer:shape];
    return shape;
}

- (void)loadView
{
    [super loadView];
    
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationDuration:0.5];
    
    self.shape0 = [self shapeWithRadius:120
                               andColor:[UIColor colorWithHexString:@"#ffe400"]];
    self.shape1 = [self shapeWithRadius:100
                               andColor:[UIColor colorWithHexString:@"#ffd500"]];
    self.shape2 = [self shapeWithRadius:80
                               andColor:[UIColor colorWithHexString:@"#ffc500"]];
    
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
    
    self.textLayer = [CATextLayer layer];
    self.textLayer.fontSize = 44;
    self.textLayer.hidden = YES;
    self.textLayer.font = (__bridge CFTypeRef)[UIFont lightFontName];
    self.textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    self.textLayer.string = @"0";
    self.textLayer.masksToBounds = NO;
    self.textLayer.contentsScale = [UIScreen mainScreen].scale;
    self.textLayer.alignmentMode = kCAAlignmentCenter;
    self.textLayer.bounds = (CGRect){{0,0}, {120, self.textLayer.preferredFrameSize.height}};
    self.textLayer.transform = CATransform3DMakeScale(CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN);
    [self.view.layer addSublayer:self.textLayer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    self.scrollView.contentSize = CGSizeMake(960, 640);
    
    [self performSelector:@selector(showContent)
               withObject:nil
               afterDelay:0.5];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.shape0.position = CGPointMake(CGRectGetWidth(self.view.bounds) / 2,
                                       CGRectGetHeight(self.view.bounds) / 2 - 44);
    self.shape1.position = self.shape0.position;
    self.shape2.position = self.shape0.position;
    
    self.textLayer.position = self.shape0.position;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[CATransaction setDisableActions:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showContent
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.0
                                                                                              :0.0
                                                                                              :0.75
                                                                                              :1.5]];
    self.shape0.strokeEnd = 0.8;
    self.shape1.strokeEnd = 0.75;
    self.shape2.strokeEnd = 0.6;
    [CATransaction commit];
    
    NSInteger finalNum = 58;
    
    [CATransaction begin];
    
    self.textLayer.transform = CATransform3DIdentity;
    self.textLayer.hidden = NO;
    [CATransaction setCompletionBlock:^{
        CAKeyframeAnimation * numjump = [CAKeyframeAnimation animationWithKeyPath:@"string"];
        NSMutableArray *values = [NSMutableArray arrayWithCapacity:finalNum + 1];
        for (int i=0; i <= finalNum; ++i) {
            [values addObject:[NSString stringWithFormat:@"%d", i]];
        }
        numjump.values = values;
        numjump.duration = 2.0;
        numjump.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        numjump.removedOnCompletion = NO;
        numjump.timeOffset = 1.0;
        [self.textLayer addAnimation:numjump
                              forKey:@"NumberJump"];
        self.textLayer.string = values.lastObject;
    }];
    [CATransaction commit];
}


@end
