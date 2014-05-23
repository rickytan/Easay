//
//  ESTheHotViewController.m
//  Easay
//
//  Created by ricky on 14-5-24.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESTheHotViewController.h"
#import "UIFont+ES.h"

@interface ESTheHotViewController ()
@property (nonatomic, strong) NSArray *hotPlaces, * hotLines;
@end

@implementation ESTheHotViewController

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
    [self.tableView registerClass:[UITableViewHeaderFooterView class]
forHeaderFooterViewReuseIdentifier:@"Header"];
    
    self.hotPlaces = @[@{
        @"title": @"ZheJiang University, Zijinggang Campus",
        @"percent": @"11%"
    }, @{
        @"title": @"Incity Shopping Market",
        @"percent": @"8%"
    }, @{
        @"title": @"YunJin Mansion",
        @"percent": @"7%"
    }];
    
    self.hotLines = @[@{
        @"title": @"Bus Line 89",
        @"percent": @"18%"
    }, @{
        @"title": @"Metro Line 1",
        @"percent": @"12%"
    }, @{
        @"title": @"Bus Line 574",
        @"percent": @"9%"
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)circledImageForNumber:(NSInteger)number
{
    CGSize size = {16, 16};
    CGRect rect = CGRectInset((CGRect){{0, 0}, size}, 2, 2);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [[UIColor whiteColor] set];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    cornerRadius:size.width/2];
    [path stroke];
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathStroke);
    NSString *num = [NSString stringWithFormat:@"%ld", (long)number];
    [num drawInRect:CGRectMake(0, 4, size.width, size.height)
           withFont:[UIFont lightFontWithSize:8]
      lineBreakMode:NSLineBreakByClipping
          alignment:NSTextAlignmentCenter];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - UITable

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerTitles[] = {@"HOT PLACE", @"HOT LINE"};
    
    UITableViewHeaderFooterView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    header.textLabel.font = [UIFont boldFontWithSize:14];
    header.textLabel.text = headerTitles[section];
    header.textLabel.textColor = [UIColor whiteColor];
    header.contentView.backgroundColor = [UIColor clearColor];
    header.backgroundView = [[UIView alloc] init];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotCell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont lightFontWithSize:12];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont lightFontWithSize:12];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [self circledImageForNumber:indexPath.row + 1];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.hotPlaces[indexPath.row][@"title"];
        cell.detailTextLabel.text = self.hotPlaces[indexPath.row][@"percent"];
    }
    else {
        cell.textLabel.text = self.hotLines[indexPath.row][@"title"];
        cell.detailTextLabel.text = self.hotLines[indexPath.row][@"percent"];
    }
    return cell;
}

@end
