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
@end

@implementation ESMenuViewController

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

    self.cellItems = @[@{@"image": @"today", @"title": @"TODAY"},
                       @{@"image": @"activity", @"title": @"AVTIVITY"},
                       @{@"image": @"friends", @"title": @"FRIENDS"},
                       @{@"image": @"my-trip", @"title": @"MY TRIP"},
                       @{@"image": @"the-hot", @"title": @"THE HOT"},
                       @{@"image": @"settings", @"title": @"SETTINGS"}];
    //[self.tableView reloadData];
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
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
