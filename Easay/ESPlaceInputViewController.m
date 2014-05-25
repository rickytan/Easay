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

@interface ESPlaceInputViewController () <UISearchDisplayDelegate>
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
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(onDismiss:)];
    self.navigationItem.leftBarButtonItem = back;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor themeColor];
    self.navigationController.navigationBar.barTintColor = [UIColor themeColor];
    
    self.view.backgroundColor = [UIColor themeColor];
    self.tableView.separatorColor = [UIColor darkGrayColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class]
           forHeaderFooterViewReuseIdentifier:@"Header"];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.tintColor = [UIColor whiteColor];
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    searchBar.layer.borderWidth = 1.f;
    searchBar.showsCancelButton = YES;
    searchBar.barStyle = UISearchBarStyleMinimal;
    searchBar.placeholder = @"INPUT YOUR ADDR";
    [searchBar setImage:[UIImage imageNamed:@"search"]
       forSearchBarIcon:UISearchBarIconSearch
                  state:UIControlStateNormal];
    [searchBar setBackgroundImage:[[UIImage alloc] init]
                   forBarPosition:UIBarPositionTop
                       barMetrics:UIBarMetricsDefault];
    
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"clear"]
                                    forState:UIControlStateNormal];
    [searchBar sizeToFit];
    self.tableView.tableHeaderView = searchBar;
    
    UISearchDisplayController *searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar
                                                                                    contentsController:self];
    //searchController.displaysSearchBarInNavigationBar = YES;
    searchController.delegate = self;
    searchController.searchResultsDataSource = self;
    searchController.searchResultsDelegate = self;
    [searchController.searchResultsTableView registerClass:[UITableViewCell class]
                                    forCellReuseIdentifier:@"Cell"];
    //searchController.active = YES;
    
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
estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:@"history"];
    cell.textLabel.text = self.searchHistory[indexPath.row];
    cell.textLabel.font = [UIFont boldFontWithSize:10];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

@end
