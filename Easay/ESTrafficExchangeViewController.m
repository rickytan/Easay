//
//  ESTrafficExchangeViewController.m
//  Easay
//
//  Created by ricky on 14-5-28.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESTrafficExchangeViewController.h"
#import "UIFont+ES.h"
#import "UIColor+RExtension.h"
@import QuartzCore;
@import CoreGraphics;

@interface ESTrafficSiteCell : UITableViewCell
@property (nonatomic, assign) BOOL drawTop, drawBottom;
@end

@implementation ESTrafficSiteCell

- (void)awakeFromNib
{
    self.textLabel.font = [UIFont boldFontWithSize:12];
}

- (void)drawRect:(CGRect)rect
{
    if (!self.drawTop && !self.drawBottom)
        return;

    CGContextRef content = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(content, 1.5);
    [[UIColor whiteColor] set];
    if (self.drawTop) {
        CGContextMoveToPoint(content, CGRectGetMidX(rect), 0);
        CGContextAddLineToPoint(content, CGRectGetMidX(rect), 4);
    }
    if (self.drawBottom) {
        CGContextMoveToPoint(content, CGRectGetMidX(rect), CGRectGetHeight(rect));
        CGContextAddLineToPoint(content, CGRectGetMidX(rect), CGRectGetHeight(rect) - 4);
    }
    CGContextDrawPath(content, kCGPathStroke);
}

- (void)setDrawBottom:(BOOL)drawBottom
{
    if (_drawBottom != drawBottom) {
        _drawBottom = drawBottom;
        [self setNeedsDisplay];
    }
}

- (void)setDrawTop:(BOOL)drawTop
{
    if (_drawTop != drawTop) {
        _drawTop = drawTop;
        [self setNeedsDisplay];
    }
}

@end

@interface ESTrafficSiteHeader : UIView
@property (nonatomic, assign) IBOutlet UILabel * transport;
@end

@implementation ESTrafficSiteHeader
@end

@interface UIView (ES)
+ (void)setAnimationPosition:(CGPoint)pos;
@end

@implementation UIView (ES)

@end

@interface ESTrafficExchangeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) IBOutlet UITableView *tableView;
@property (nonatomic, assign) IBOutlet UIView * bubble;
@property (nonatomic, strong) CAGradientLayer * maskLayer;
- (IBAction)onBubble:(id)sender;
@end

@implementation ESTrafficExchangeViewController

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
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.tableView.frame;
    layer.locations = @[@0, @0.5, @1];
    layer.colors = @[(id)[UIColor themeColor].CGColor,
                     (id)[UIColor colorWithRed:54.0/255
                                         green:137.0/255
                                          blue:229.0/255
                                         alpha:0.0].CGColor,
                     (id)[UIColor themeColor].CGColor];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    [self.view.layer addSublayer:layer];

    self.maskLayer = layer;

    self.bubble.layer.borderWidth = 4.0f;
    self.bubble.layer.borderColor = [UIColor whiteColor].CGColor;
    self.bubble.layer.backgroundColor = [UIColor yellowColor].CGColor;
    self.bubble.layer.cornerRadius = self.bubble.bounds.size.width / 2;

    self.exchangeInfo = @[@{@"Traffic": @"BUS LINE 89",
                            @"Stops": @[@"Wenhuang Temple",
                                        @"East of Wenhui Bridge",
                                        @"West of Wenhui Bridge",
                                        @"Hangzhou Children's Hospital",
                                        @"Traffic Police Detachment"]},
                          @{@"Traffic": @"BUS LINE 84",
                            @"Stops": @[@"Conservation Company",
                                        @"MingFeng",
                                        @"The West Bus Station",
                                        @"Xixi Wet Land Park",
                                        @"Taobao City"]}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITable

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.exchangeInfo.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.exchangeInfo[section][@"Stops"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 24;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    ESTrafficSiteHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[[UINib nibWithNibName:@"TrafficExchangeHeader"
                                  bundle:nil] instantiateWithOwner:self
                   options:nil] firstObject];
    }
    header.transport.text = self.exchangeInfo[section][@"Traffic"];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESTrafficSiteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SiteCell"
                                                              forIndexPath:indexPath];
    cell.textLabel.text = self.exchangeInfo[indexPath.section][@"Stops"][indexPath.row];
    cell.drawTop = indexPath.row > 0;
    cell.drawBottom = indexPath.row < [self.exchangeInfo[indexPath.section][@"Stops"] count] - 1;
    return cell;
}

#pragma mark - Actions

- (IBAction)onBubble:(id)sender
{
    /*
    CATransition *trans = [CATransition animation];
    trans.type = @"suckEffect";
    trans.duration = 0.5;
    trans.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    [self.tableView.layer addAnimation:trans
                                forKey:@"Suck"];
     */
    [UIView beginAnimations:@"Suck"
                    context:NULL];
    [UIView setAnimationTransition:103
                           forView:self.tableView
                             cache:NO];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationPosition:[self.tableView convertPoint:self.bubble.center
                                                     fromView:self.view]];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];

    self.tableView.hidden = YES;
    self.maskLayer.hidden = YES;
}

- (void)animationDidStop:(NSString *)animationID
                finished:(NSNumber *)finished
                 context:(void *)context

{

    CAKeyframeAnimation * anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint center = self.bubble.center;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:30];
    for (int i=0; i < 30; ++i) {
        CGFloat x = (2 * i) * sinf(5.0 * M_PI * i / 30);
        [arr addObject:[NSValue valueWithCGPoint:CGPointMake(center.x + x, center.y - 600.0 * i / 30)]];
    }
    anim.values = arr;
    anim.duration = 2.0;
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    [self.bubble.layer addAnimation:anim
                             forKey:@"Fly"];
}

- (void)animationDidStop:(CAAnimation *)anim
                finished:(BOOL)flag
{
    self.bubble.hidden = YES;
}

@end
