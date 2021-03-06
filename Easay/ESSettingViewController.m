//
//  ESSettingViewController.m
//  Easay
//
//  Created by ricky on 14-5-9.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESSettingViewController.h"
#import "UIFont+ES.h"
#import "ESOptionSelectViewController.h"
#import "ESPrivacyCell.h"

@interface ESSettingViewController () <ESOptionSelectDelegate>
@property (nonatomic, strong) NSArray *sections;
@end

@implementation ESSettingViewController

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
    self.sections = @[@[@{@"title": @"Privacy Settings", @"value": @"Public"}],
                      @[@{@"title": @"The Name", @"value": @"Youulii Pang"},
                        @{@"title": @"The Battery Show", @"value": @"%"},
                        @{@"title": @"Time Display", @"value": @"24h"},
                        @{@"title": @"GPS", @"value": @"ON"}],
                      @[@{@"title": @"Weibo", @"value": @"Disconnect", @"image": @"connect-weibo"},
                        @{@"title": @"Pinterest", @"value": @"Connect", @"image": @"connect-path"},
                        @{@"title": @"WeChat", @"value": @"Connect", @"image": @"connect-wechat"}]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.sections[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 24.f;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Header"];
        header.contentView.backgroundColor = [UIColor clearColor];
        header.textLabel.font = [UIFont boldFontWithSize:14];
    }
    static NSString *headerString[] = {@"ACCOUNT", @"EASAY(CONNECTED)", @"SHARING"};
    header.textLabel.text = headerString[section];
    return header;
}

- (void)tableView:(UITableView *)tableView
willDisplayHeaderView:(UIView *)view
       forSection:(NSInteger)section
{
    ((UITableViewHeaderFooterView *)view).textLabel.textColor = [UIColor colorWithRed:200.0/255
                                                                                green:216.0/255
                                                                                 blue:233.0/255
                                                                                alpha:1.0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell"];
    cell.textLabel.font = [UIFont lightFontWithSize:14];
    cell.detailTextLabel.font = [UIFont lightFontWithSize:14];
    
    cell.textLabel.text = self.sections[indexPath.section][indexPath.row][@"title"];
    cell.detailTextLabel.text = self.sections[indexPath.section][indexPath.row][@"value"];
    cell.imageView.image = [UIImage imageNamed:self.sections[indexPath.section][indexPath.row][@"image"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            ESOptionSelectViewController *option = [[ESOptionSelectViewController alloc] init];
            option.title = @"Privacy Settings";
            option.delegate = self;
            option.options = @[[ESOptionItem optionItemWithText:@"Everyone(Public)"
                                                    description:@"Everyone on Easay can search for you, view your full profile, send you invites and see your activi."
                                                          image:[UIImage imageNamed:@"priv-radar"]],
                               [ESOptionItem optionItemWithText:@"Friends(Social)"
                                                    description:@"Everyone on Easay can search for you, view your limited profile, and sned you invites. Only friends can view your full profile and see your activity."
                                                          image:[UIImage imageNamed:@"priv-head"]],
                               [ESOptionItem optionItemWithText:@"Me Only(Private)"
                                                    description:@"Nobody on Easay can search for you, view your profile, send you invites or see your activity."
                                                          image:[UIImage imageNamed:@"priv-avatar"]]
                               ];
            option.tableView.rowHeight = 108.0f;
            [option.tableView registerClass:[ESPrivacyCell class]
                     forCellReuseIdentifier:@"Cell"];
            //option.selectedIndexPath = [NSIndexPath indexPathForRow:0
            //                                              inSection:0];
            [self.navigationController pushViewController:option
                                                 animated:YES];
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self performSegueWithIdentifier:@"SetName"
                                              sender:self];
                }
                    break;
                case 1:
                {
                    ESOptionSelectViewController *option = [[ESOptionSelectViewController alloc] init];
                    option.title = @"The Battery Show";
                    option.delegate = self;
                    option.options = @[@"The battery percentage, % ON",
                                       @"The battery percentage, % OFF"];
                    option.selectedIndexPath = [NSIndexPath indexPathForRow:0
                                                                  inSection:0];
                    [self.navigationController pushViewController:option
                                                         animated:YES];
                }
                    break;
                case 2:
                {
                    ESOptionSelectViewController *option = [[ESOptionSelectViewController alloc] init];
                    option.title = @"Time Display";
                    option.delegate = self;
                    option.options = @[@"24-hour",
                                       @"12-hour"];
                    option.selectedIndexPath = [NSIndexPath indexPathForRow:0
                                                                  inSection:0];
                    [self.navigationController pushViewController:option
                                                         animated:YES];
                }
                    break;
                case 3:
                {
                    ESOptionSelectViewController *option = [[ESOptionSelectViewController alloc] init];
                    option.title = @"GPS";
                    option.delegate = self;
                    option.options = @[@"ON",
                                       @"OFF"];
                    option.selectedIndexPath = [NSIndexPath indexPathForRow:0
                                                                  inSection:0];

                    [self.navigationController pushViewController:option
                                                         animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - ESOptionSelectDelegate

- (void)optionSelectViewController:(ESOptionSelectViewController *)controller
                didSelectIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
