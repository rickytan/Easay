//
//  ESMenuViewController.m
//  Easay
//
//  Created by ricky on 14-4-14.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESMenuViewController.h"
#import "UIColor+RExtension.h"
#import "UIFont+ES.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import <MapKit/MapKit.h>

@interface ESMenuCell : UITableViewCell
@end

@implementation ESMenuCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (self.isSelected || self.isHighlighted) {
        [[UIColor colorWithHexString:@"#252629"] setFill];
    }
    else {
        [[UIColor colorWithHexString:@"#37383c"] setFill];
    }
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
}

@end

@interface ESMenuViewController ()
@property (nonatomic, assign) IBOutlet UIToolbar *headBar;

@property (nonatomic, strong) NSArray * cellItems;

- (IBAction)onLogout:(id)sender;
- (IBAction)onHeader:(id)sender;
@end

@implementation ESMenuViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.selectedIndex = [NSIndexPath indexPathForRow:0
                                                inSection:0];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.headBar setBackgroundImage:[[UIImage alloc] init]
                  forToolbarPosition:UIBarPositionTop
                          barMetrics:UIBarMetricsDefault];
    self.headBar.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    self.headBar.tintColor = [UIColor whiteColor];

    self.cellItems = @[@{@"image": @"today", @"title": @"TODAY"},
                       @{@"image": @"activity", @"title": @"AVTIVITY"},
                       @{@"image": @"friends", @"title": @"FRIENDS"},
                       @{@"image": @"my-trip", @"title": @"MY TRIP"},
                       @{@"image": @"the-hot", @"title": @"THE HOT"},
                       @{@"image": @"settings", @"title": @"SETTINGS"}];

    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#37383c"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView selectRowAtIndexPath:self.selectedIndex
                                animated:animated
                          scrollPosition:UITableViewScrollPositionNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)onLogout:(id)sender
{
    [self.mm_drawerController dismissViewControllerAnimated:YES
                                                 completion:NULL];
}

- (IBAction)onHeader:(id)sender
{
    if ([sender isKindOfClass:[UITapGestureRecognizer class]] && ((UITapGestureRecognizer *)sender).state != UIGestureRecognizerStateEnded)
        return;

    [self.mm_drawerController setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"PersonalNav"]
                                   withCloseAnimation:YES
                                           completion:NULL];

    [self.tableView deselectRowAtIndexPath:self.selectedIndex
                                  animated:YES];
    self.selectedIndex = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.cellItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.imageView.image = [UIImage imageNamed:self.cellItems[indexPath.row][@"image"]];
    cell.textLabel.text = self.cellItems[indexPath.row][@"title"];
    cell.textLabel.font = [UIFont lightFontWithSize:16];
    if (indexPath.row == 1) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"badge-circle"]];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.selectedIndex isEqual:indexPath]) {
        [self.mm_drawerController closeDrawerAnimated:YES
                                           completion:^(BOOL finished) {
                                               if (finished) {
                                                   [self.mm_drawerController.centerViewController viewDidAppear:YES];
                                               }
                                           }];
        return;
    }

    self.selectedIndex = indexPath;
    switch (indexPath.row) {
        case 0:
            [self.mm_drawerController setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNav"]
                                           withCloseAnimation:YES
                                                   completion:NULL];
            break;
        case 1:
            [self.mm_drawerController setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ActivityNav"]
                                           withCloseAnimation:YES
                                                   completion:NULL];
            break;
        case 2:
            [self.mm_drawerController setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"FriendNav"]
                                           withCloseAnimation:YES
                                                   completion:NULL];
            break;
        case 3:
            [self.mm_drawerController setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MytripNav"]
                                           withCloseAnimation:YES
                                                   completion:NULL];
            break;
        case 4:
            [self.mm_drawerController setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ThehotNav"]
                                           withCloseAnimation:YES
                                                   completion:NULL];
            break;
        case 5:
            [self.mm_drawerController setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SettingNav"]
                                           withCloseAnimation:YES
                                                   completion:NULL];
            break;
        default:
            break;
    }
}

/*
 #pragma mark - Navigation

 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }

 */

@end
