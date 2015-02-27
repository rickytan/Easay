//
//  ESOptionSelectViewController.m
//  Easay
//
//  Created by ricky on 14-5-10.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESOptionSelectViewController.h"
#import "UIFont+ES.h"
#import "UIViewController+ES.h"
#import "UIColor+RExtension.h"

@implementation ESOptionItem

+ (instancetype)optionItemWithText:(NSString *)text description:(NSString *)desc image:(UIImage *)image
{
    ESOptionItem *item = [[ESOptionItem alloc] init];
    item.text = text;
    item.itemDescription = desc;
    item.image = image;
    return item;
}

@end

@interface ESOptionSelectViewController ()

@end

@implementation ESOptionSelectViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor themeColor];
    self.tableView.rowHeight = 54.f;
    self.tableView.separatorColor = [[UIColor themeColor] colorByLighting:-.2];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-back"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(onDismiss:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    double delayInSeconds = .1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.tableView selectRowAtIndexPath:self.selectedIndexPath
                                    animated:NO
                              scrollPosition:UITableViewScrollPositionNone];
    });
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
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont lightFontWithSize:14];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    ESOptionItem *item = (ESOptionItem *)self.options[indexPath.row];
    if ([item isKindOfClass:[NSString class]])
        cell.textLabel.text = (NSString *)item;
    else {
        cell.textLabel.text = item.text;
        cell.detailTextLabel.text = item.itemDescription;
        cell.imageView.image = item.image;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.selectedIndexPath isEqual:indexPath])
        return;
    
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    self.selectedIndexPath = indexPath;
    if ([self.delegate respondsToSelector:@selector(optionSelectViewController:didSelectIndexPath:)])
        [self.delegate optionSelectViewController:self
                               didSelectIndexPath:self.selectedIndexPath];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
