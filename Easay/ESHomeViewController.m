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
#import "ESWeekDataView.h"
#import "RTSiderViewController.h"
#import "ESMenuViewController.h"

@interface ESHomeViewController () <UIScrollViewDelegate>
@property (nonatomic, assign) IBOutlet UIScrollView * scrollView;
@property (nonatomic, assign) IBOutlet UIPageControl * pageControl;
@property (nonatomic, assign) IBOutlet UILabel * dateLabel, * locationLabel, * moneyLabel;
@property (nonatomic, assign) IBOutlet UILabel * distThisWeek, * distLastWeek, * costThisWeek, * costLastWeek;
@property (nonatomic, strong) CAShapeLayer * shape0, * shape1, * shape2;
@property (nonatomic, strong) CATextLayer * textLayer;
@property (nonatomic, assign) IBOutlet ESWeekDataView * weekDataView;

@property (nonatomic, strong) NSArray * weekData;

- (IBAction)onPageControl:(id)sender;
- (IBAction)onRight:(id)sender;
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
    shape.delegate = self;
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
    
    //[CATransaction setDisableActions:YES];
    //[CATransaction setAnimationDuration:0.5];
    
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
    
    self.weekData = @[@10, @8, @4, @7, @2, @5, @9];

    [self performSelector:@selector(showContent)
               withObject:nil
               afterDelay:0.5];

    self.scrollView.alpha = 0.0;
    self.scrollView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.scrollView.frame));

    [UIView animateWithDuration:1.0
                          delay:0.5
         usingSpringWithDamping:0.5
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         self.scrollView.transform = CGAffineTransformIdentity;
                         self.scrollView.alpha = 1.0;
                     }
                     completion:NULL];
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
        [self.textLayer addAnimation:numjump
                              forKey:@"NumberJump"];
        self.textLayer.string = values.lastObject;
    }];
    [CATransaction commit];
}

#pragma mark - Methods

- (void)updatePageControl
{
    self.pageControl.currentPage = (NSInteger)floorf(self.scrollView.contentOffset.x / self.scrollView.bounds.size.width + 0.5);
    if (self.pageControl.currentPage == 1) {
        self.weekDataView.weekData = self.weekData;
    }
}

#pragma mark - Actions

- (IBAction)onPageControl:(id)sender
{
    [self.scrollView setContentOffset:CGPointMake(self.pageControl.currentPage * self.scrollView.bounds.size.width, 0)
                             animated:YES];
}

- (IBAction)onRight:(id)sender
{
    [(ESMenuViewController *)self.siderViewController.currentLeftViewController setSelectedIndex:[NSIndexPath indexPathForRow:4 inSection:0]];
    [self.siderViewController setMiddleViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ThehotNav"]
                                             animated:YES];
}

#pragma mark - UIScrollView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updatePageControl];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self updatePageControl];
    }
}

#pragma mark - CALayer

- (void)displayLayer:(CALayer *)layer
{
    
}

/* If defined, called by the default implementation of -drawInContext: */

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    
}

/* Called by the default -layoutSublayers implementation before the layout
 * manager is checked. Note that if the delegate method is invoked, the
 * layout manager will be ignored. */

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    
}

@end
