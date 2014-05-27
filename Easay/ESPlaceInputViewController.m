//
//  ESPlaceInputViewController.m
//  Easay
//
//  Created by ricky on 14-5-26.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESPlaceInputViewController.h"
#import "UIColor+RExtension.h"
#import "UIFont+ES.h"
#import "UIViewController+ES.h"

@interface ESPlaceInputViewController () <UISearchBarDelegate>
@property (nonatomic, strong) NSArray * searchHistory;
@end

@implementation ESPlaceInputViewController

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
    self.title = @"Input Address";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.contentInset = UIEdgeInsetsMake([UIApplication sharedApplication].statusBarFrame.size.height, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class]
           forHeaderFooterViewReuseIdentifier:@"Header"];
    
    /*
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(onDismiss:)];
    self.navigationItem.leftBarButtonItem = back;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor themeColor];
    self.navigationController.navigationBar.barTintColor = [UIColor themeColor];
     */
    
    self.view.backgroundColor = [UIColor themeColor];
    self.tableView.separatorColor = [UIColor darkGrayColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.tintColor = [UIColor whiteColor];
    searchBar.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    searchBar.layer.borderWidth = 1.f;
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.searchBarStyle = UISearchBarStyleProminent;
    searchBar.placeholder = @"INPUT YOUR ADDR";
    [searchBar setImage:[UIImage imageNamed:@"search"]
       forSearchBarIcon:UISearchBarIconSearch
                  state:UIControlStateNormal];
    [searchBar setBackgroundImage:[UIImage imageNamed:@"clear"]
                   forBarPosition:UIBarPositionTop
                       barMetrics:UIBarMetricsDefault];
    
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"clear"]
                                    forState:UIControlStateNormal];
    [searchBar sizeToFit];
    [searchBar becomeFirstResponder];
    self.tableView.tableHeaderView = searchBar;
    
    self.searchHistory = @[@"ZheJiang University, Zijinggang Campus",
                           @"Incity Shopping Market",
                           @"YunJin Mansion",
                           @"YangGong Road",
                           @"Hangzhou Museum",
                           @"Xihu Art Gallery",
                           @"West Lake Park",
                           @"The Bank of China"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.searchHistory.count;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    header.backgroundView = [[UIView alloc] init];
    header.textLabel.text = @"HISTORY";
    header.textLabel.font = [UIFont boldFontWithSize:12];
    header.textLabel.textColor = [UIColor whiteColor];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:@"history"];
    cell.textLabel.text = self.searchHistory[indexPath.row];
    cell.textLabel.font = [UIFont boldFontWithSize:10];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.field.text = self.searchHistory[indexPath.row];
    [self dismissViewControllerAnimated:YES
                             completion:NULL];
}

#pragma mark - UISearch

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self onDismiss:nil];
}

@end
