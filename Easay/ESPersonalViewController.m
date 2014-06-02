//
//  ESPersonalViewController.m
//  Easay
//
//  Created by ricky on 14-6-2.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESPersonalViewController.h"
#import "ESActivityViewDataCell.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    cell.distance.text = [NSString stringWithFormat:@"%ld km", (long)_data[indexPath.row].distance];
    cell.money.text = [NSString stringWithFormat:@"%ld USD", (long)_data[indexPath.row].price];
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
