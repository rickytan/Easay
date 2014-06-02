//
//  ESPersonalViewController.m
//  Easay
//
//  Created by ricky on 14-6-2.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESPersonalViewController.h"
#import "ESActivityViewDataCell.h"
#import "UIColor+RExtension.h"

static struct {
    char * method;
    NSInteger distance;
    NSInteger price;
} _data[] = {
    {"Walking", 173092, 0},
    {"Riding", 682174, 2617},
    {"Driving", 1018766, 21293}
};

static CGFloat _percents[] = {0.f, 0.f, 0.f};

@interface ESPersonalViewController () <UITabBarDelegate, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, assign) IBOutlet UITableView * tableView;
@property (nonatomic, assign) IBOutlet UICollectionView * collectionView;
@property (nonatomic, assign) IBOutlet UIView * containerView;
@property (nonatomic, strong) IBOutlet CAShapeLayer * shape0, * shape1;

@property (nonatomic, strong) NSNumberFormatter * formatter;
@end

@implementation ESPersonalViewController

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

    NSInteger count = 0;

    CGPoint data0[] = {
        {0, 20},
        {17, 40},
        {40, 20},
        {80, 70},
        {120, 20},
        {170, 30},
        {200, 60},
        {230, 56},
        {260, 100},
        {320, 40}
    };
    count = sizeof(data0) / sizeof(CGPoint);
    self.shape0 = [CAShapeLayer layer];
    UIBezierPath *path0 = [UIBezierPath bezierPath];
    [path0 moveToPoint:CGPointZero];
    for (int i=0; i < count; ++i) {
        [path0 addLineToPoint:data0[i]];
    }
    [path0 addLineToPoint:CGPointMake(320, 0)];
    [path0 closePath];
    self.shape0.path = path0.CGPath;
    self.shape0.backgroundColor = [UIColor clearColor].CGColor;
    self.shape0.fillColor = [UIColor colorWithHexString:@"#ffc500"].CGColor;
    self.shape0.frame = self.containerView.bounds;
    self.shape0.geometryFlipped = YES;
    [self.containerView.layer addSublayer:self.shape0];

    CGPoint data1[] = {
        {0, 0},
        {24, 20},
        {48, 8},
        {100, 62},
        {130, 26},
        {166, 16},
        {198, 40},
        {230, 34},
        {284, 90},
        {320, 60}
    };
    count = sizeof(data1) / sizeof(CGPoint);
    self.shape1 = [CAShapeLayer layer];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointZero];
    for (int i=0; i < count; ++i) {
        [path1 addLineToPoint:data1[i]];
    }
    [path1 addLineToPoint:CGPointMake(320, 0)];
    [path1 closePath];
    self.shape1.path = path1.CGPath;
    self.shape1.backgroundColor = [UIColor clearColor].CGColor;
    self.shape1.fillColor = [UIColor colorWithHexString:@"#ffe400"].CGColor;
    self.shape1.frame = self.containerView.bounds;
    self.shape1.geometryFlipped = YES;
    self.shape1.shadowPath = path1.CGPath;
    self.shape1.shadowColor = [UIColor blackColor].CGColor;
    self.shape1.shadowOpacity = 0.3;
    self.shape1.shadowRadius = 6.0;
    [self.containerView.layer addSublayer:self.shape1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.formatter = [[NSNumberFormatter alloc] init];
    self.formatter.numberStyle = NSNumberFormatterBehavior10_4;

    self.tableView.layer.shadowColor = [UIColor blackColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, CGRectGetHeight(self.tableView.bounds) - 1, CGRectGetWidth(self.tableView.bounds), 3)];
    self.tableView.layer.shadowPath = path.CGPath;
    self.tableView.layer.shadowOpacity = 0.6;
    self.tableView.layer.shadowRadius = 1.4;
    
    [self calulatePercent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calulatePercent
{
    NSInteger count = sizeof(_data) / sizeof(_data[0]);
    NSInteger sum = 0;
    for (int i=0; i < count; ++i) {
        sum += _data[i].distance * _data[i].price;
    }
    for (int i=0; i < count; ++i) {
        _percents[i] = 1.f * _data[i].distance * _data[i].price / sum;
    }
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESActivityViewDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataCell"];
    cell.trafficMethod.text = [NSString stringWithUTF8String:_data[indexPath.row].method];
    cell.distance.text = [NSString stringWithFormat:@"%@ km", [self.formatter stringFromNumber:@(_data[indexPath.row].distance)]];
    cell.money.text = [NSString stringWithFormat:@"%@ USD", [self.formatter stringFromNumber:@(_data[indexPath.row].price)]];
    cell.percentage.text = [NSString stringWithFormat:@"%.2f%%", _percents[indexPath.row] * 100];
    return cell;
}

#pragma mark - UICollection

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                              withReuseIdentifier:@"Header"
                                                     forIndexPath:indexPath];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 4)
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"More"
                                                         forIndexPath:indexPath];
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                     forIndexPath:indexPath];
}

@end
