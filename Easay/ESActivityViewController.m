//
//  ESActivityViewController.m
//  Easay
//
//  Created by ricky on 14-5-9.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESActivityViewController.h"
#import "UIColor+RExtension.h"
#import "ESSegmentView.h"

@interface ESActivityViewDataCell : UITableViewCell
@property (nonatomic, assign) IBOutlet UILabel * trafficMethod, * distance, * money, * percentage;
@end

@implementation ESActivityViewDataCell

@end

static struct {
    char * method;
    NSInteger distance;
    NSInteger price;
} _data[] = {
    {"Walking", 7, 0},
    {"Riding", 31, 9},
    {"Driving", 9, 19}
};

static CGFloat _percents[] = {0.f, 0.f, 0.f};

@interface ESActivityViewController () <UITableViewDataSource>
@property (nonatomic, assign) IBOutlet ESSegmentView *segmentView;
@property (nonatomic, assign) IBOutlet UIButton * dayBtn, * weekBtn, * monthBtn, * yearBtn;
@property (nonatomic, assign) IBOutlet UITableView *dataView;
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
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.segmentView.segments = @[@2, @3, @8];
    self.segmentView.titles = @[@"BUS", @"SUBWAY", @"OIL"];
    [self calulatePercent];
    
    [self.segmentView performSelector:@selector(setSegments:)
               withObject:@[@4, @1, @5]
               afterDelay:2];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
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

#pragma mark - Actions

- (IBAction)onDateButton:(UIButton *)button
{
    self.dayBtn.selected = self.weekBtn.selected = self.monthBtn.selected = self.yearBtn.selected = NO;
    button.selected = YES;
    
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

@end
