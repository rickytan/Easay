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

@interface ESTrafficExchangeViewController () <UITableViewDataSource>
@property (nonatomic, assign) IBOutlet UITableView *tableView;
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
                     (id)[UIColor clearColor].CGColor,
                     (id)[UIColor colorWithWhite:0
                                           alpha:0.3].CGColor];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    [self.view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESTrafficSiteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SiteCell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = @"Wenhuang Temple";
    cell.drawTop = indexPath.row > 0;
    cell.drawBottom = indexPath.row < 7;
    return cell;
}



@end
