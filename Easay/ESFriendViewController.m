//
//  ESFriendViewController.m
//  Easay
//
//  Created by ricky on 14-4-18.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESFriendViewController.h"
#import "UIFont+ES.h"

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
    self.navigationController.view.backgroundColor = self.view.backgroundColor;
    
    self.formatter = [[NSNumberFormatter alloc] init];
    self.formatter.formatterBehavior = NSNumberFormatterBehavior10_4;
    self.formatter.numberStyle = NSNumberFormatterDecimalStyle;
    [self.formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    
    self.friends = @[@{@"image": @"head",
                       @"name": @"gusty",
                       @"distance": @28810},
                     @{@"image": @"head",
                       @"name": @"clumsy",
                       @"distance": @532},
                     @{@"image": @"head",
                       @"name": @"brainy",
                       @"distance": @19731},
                     @{@"image": @"head",
                       @"name": @"papa",
                       @"distance": @528810},
                     @{@"image": @"head",
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
