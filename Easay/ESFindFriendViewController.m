//
//  ESFindFriendViewController.m
//  Easay
//
//  Created by ricky on 14-5-9.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESFindFriendViewController.h"
#import "UIFont+ES.h"

@interface ESFindFriendViewController ()
@property (nonatomic, strong) NSArray *array;
@end

@implementation ESFindFriendViewController

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
    self.array = @[@{@"image": @"friend-weibo",
                     @"title": @"Weibo",
                     @"subtitle": @"Tap to Connect"},
                   @{@"image": @"friend-path",
                     @"title": @"Pinterest",
                     @"subtitle": @"Tap to Connect"},
                   @{@"image": @"friend-contact",
                     @"title": @"Contacts",
                     @"subtitle": @"Tap to Connect"}];
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
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.imageView.image = [UIImage imageNamed:self.array[indexPath.row][@"image"]];
    cell.textLabel.text = self.array[indexPath.row][@"title"];
    cell.textLabel.font = [UIFont lightFontWithSize:16];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont lightFontWithSize:12];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = self.array[indexPath.row][@"subtitle"];
    
    return cell;
}


@end
