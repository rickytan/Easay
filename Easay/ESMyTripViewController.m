//
//  ESMyTripViewController.m
//  Easay
//
//  Created by ricky on 14-5-24.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESMyTripViewController.h"
#import "ESTripCell.h"
#import "ESPlaceInputViewController.h"

@interface ESMyTripViewController () <UITextFieldDelegate>
@property (nonatomic, strong) NSArray *trips;
@property (nonatomic, assign) IBOutlet UITextField * fromField, *toField;
@end

@implementation ESMyTripViewController

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

    self.trips = @[@{@"exchanges": @[@"METRO LINE 1"],
                     @"time": @77,
                     @"distance": @11.4,
                     @"price": @2.3},
                   @{@"exchanges": @[@"BUS LINE 79"],
                     @"time": @83,
                     @"distance": @11.9,
                     @"price": @2.7},
                   @{@"exchanges": @[@"BUS LINE 112", @"BUS LINE 84"],
                     @"time": @77,
                     @"distance": @11.4,
                     @"price": @2.3},
                   @{@"exchanges": @[@"METRO LINE 1", @"BUS LINE 5"],
                     @"time": @77,
                     @"distance": @11.4,
                     @"price": @2.3},
                   @{@"exchanges": @[@"BUS LINE 746"],
                     @"time": @77,
                     @"distance": @11.4,
                     @"price": @2.3},
                   @{@"exchanges": @[@"BUS LINE 18", @"BUS LINE 9", @"BUS LINE 211"],
                     @"time": @137,
                     @"distance": @11.4,
                     @"price": @2.3},
                   @{@"exchanges": @[@"BUS LINE 356"],
                     @"time": @136,
                     @"distance": @13.9,
                     @"price": @4.0}];
}

- (NSAttributedString *)mergedExchangeInfo:(NSArray *)exchanges
{
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:[exchanges componentsJoinedByString:@";"]
                                                                                 attributes:nil];
    do {
        NSRange range = [attrStr.string rangeOfString:@";"];
        if (range.location == NSNotFound)
            break;
        
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:@"exchange"];
        attach.bounds = CGRectMake(0, -2, 24, 11);
        [attrStr replaceCharactersInRange:range
                     withAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
    } while (1);
    return attrStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITable

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.fromField.text.length && self.toField.text.length)
        return self.trips.count;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESTripCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripCell" forIndexPath:indexPath];
    cell.exchangeLabel.attributedText = [self mergedExchangeInfo:self.trips[indexPath.row][@"exchanges"]];
    NSInteger h = [self.trips[indexPath.row][@"time"] integerValue] / 60;
    NSInteger m = [self.trips[indexPath.row][@"time"] integerValue] % 60;
    cell.timeLabel.text = [NSString stringWithFormat:@"%02ldh%02ldm", (long)h, (long)m];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.01f km", [self.trips[indexPath.row][@"distance"] floatValue]];
    cell.priceLabel.text = [NSString stringWithFormat:@"$ %.01f", [self.trips[indexPath.row][@"price"] floatValue]];
    return cell;
}

#pragma mark - UITextField

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    ESPlaceInputViewController *input = [[ESPlaceInputViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:input];
    [self presentViewController:nav
                       animated:YES
                     completion:NULL];
    
    return NO;
}

@end
