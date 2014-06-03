//
//  ESFriendViewController.m
//  Easay
//
//  Created by ricky on 14-4-18.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESFriendViewController.h"
#import "UIFont+ES.h"
#import "UIColor+RExtension.h"

@interface ESFriendViewController ()
@property (nonatomic, strong) NSArray * friends;
@property (nonatomic, strong) NSNumberFormatter * formatter;
@end

@implementation ESFriendViewController

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
    self.searchDisplayController.searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    self.searchDisplayController.searchBar.layer.borderWidth = 1.0;
    [self.searchDisplayController.searchBar setBackgroundImage:[UIImage imageNamed:@"clear"]
                                                forBarPosition:UIBarPositionTop
                                                    barMetrics:UIBarMetricsDefault];
    [self.searchDisplayController.searchBar setImage:[UIImage imageNamed:@"search"]
                                    forSearchBarIcon:UISearchBarIconSearch
                                               state:UIControlStateNormal];
    [self.searchDisplayController.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"clear"]
                                                                 forState:UIControlStateNormal];
    
    self.tableView.backgroundView = [[UIView alloc] init];
    self.tableView.backgroundView.backgroundColor = [UIColor themeColor];
    
    self.formatter = [[NSNumberFormatter alloc] init];
    self.formatter.formatterBehavior = NSNumberFormatterBehavior10_4;
    self.formatter.numberStyle = NSNumberFormatterDecimalStyle;
    [self.formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    
    self.friends = @[@{@"image": @"1",
                       @"name": @"gusty",
                       @"distance": @28810},
                     @{@"image": @"2",
                       @"name": @"clumsy",
                       @"distance": @532},
                     @{@"image": @"3",
                       @"name": @"brainy",
                       @"distance": @19731},
                     @{@"image": @"4",
                       @"name": @"papa",
                       @"distance": @528810},
                     @{@"image": @"5",
                       @"name": @"hackus",
                       @"distance": @63}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
        cell.imageView.image = [UIImage imageNamed:self.friends[indexPath.row][@"image"]];
        cell.textLabel.text = [self.friends[indexPath.row][@"name"] uppercaseString];
        cell.textLabel.font = [UIFont lightFontWithSize:16];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.font = [UIFont lightFontWithSize:16];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ km", [self.formatter stringFromNumber:self.friends[indexPath.row][@"distance"]]];
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                           reuseIdentifier:@"SearchCell"];
        }
        cell.imageView.image = [UIImage imageNamed:self.friends[indexPath.row][@"image"]];
        cell.textLabel.text = [self.friends[indexPath.row][@"name"] uppercaseString];
        cell.textLabel.font = [UIFont lightFontWithSize:16];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.font = [UIFont lightFontWithSize:16];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ km", [self.formatter stringFromNumber:self.friends[indexPath.row][@"distance"]]];
        return cell;
    }
}

@end
