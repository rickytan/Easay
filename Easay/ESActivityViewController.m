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
#import "ESActivityViewDataCell.h"

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
@property (nonatomic, assign) IBOutlet UIView *containerView;
@property (nonatomic, assign) IBOutlet UIButton * dayBtn, * weekBtn, * monthBtn, * yearBtn;
@property (nonatomic, assign) IBOutlet UITableView *dataView;
@property (nonatomic, assign) IBOutlet UILabel *label0, * label1, * label2;
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

    for (UIView *v in self.containerView.subviews) {
        v.hidden = YES;
    }

    if (button == self.dayBtn) {
        [self.containerView viewWithTag:1].hidden = NO;
        self.label0.text = @"3, 29, Saturday";
        self.label1.text = @"47 km";
        self.label2.text = @"$28";
        _data[0].distance = 7;
        _data[0].price = 0;
        _data[1].distance = 31;
        _data[1].price = 9;
        _data[2].distance = 9;
        _data[2].price = 19;
        self.segmentView.segments = @[@2, @3, @8];
    }
    else if (button == self.weekBtn) {
        [self.containerView viewWithTag:2].hidden = NO;
        self.label0.text = @"3,23 - 3,30";
        self.label1.text = @"379 km";
        self.label2.text = @"$251";
        _data[0].distance = 32;
        _data[0].price = 0;
        _data[1].distance = 218;
        _data[1].price = 64;
        _data[2].distance = 129;
        _data[2].price = 187;
        self.segmentView.segments = @[@1, @2, @7];
    }
    else if (button == self.monthBtn) {
        [self.containerView viewWithTag:3].hidden = NO;
        self.label0.text = @"March";
        self.label1.text = @"1,523 km";
        self.label2.text = @"$978";
        _data[0].distance = 139;
        _data[0].price = 0;
        _data[1].distance = 846;
        _data[1].price = 371;
        _data[2].distance = 539;
        _data[2].price = 607;
        self.segmentView.segments = @[@1.5, @2, @6.5];
    }
    else if (button == self.yearBtn) {
        [self.containerView viewWithTag:4].hidden = NO;
        self.label0.text = @"2014";
        self.label1.text = @"20,126 km";
        self.label2.text = @"$9,304";
        _data[0].distance = 1768;
        _data[0].price = 0;
        _data[1].distance = 9740;
        _data[1].price = 4272;
        _data[2].distance = 8618;
        _data[2].price = 5023;
        self.segmentView.segments = @[@1.5, @3, @5.5];
    }

    [self calulatePercent];
    [self.dataView reloadData];
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
