//
//  ESOptionSelectViewController.h
//  Easay
//
//  Created by ricky on 14-5-10.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ESOptionSelectViewController;

@protocol ESOptionSelectDelegate <NSObject>
@optional
- (void)optionSelectViewController:(ESOptionSelectViewController *)controller
                didSelectIndexPath:(NSIndexPath *)indexPath;

@end

@interface ESOptionSelectViewController : UITableViewController
@property (nonatomic, assign) id<ESOptionSelectDelegate> delegate;
@property (nonatomic, strong) NSArray * options;
@property (nonatomic, strong) NSIndexPath * selectedIndexPath;
@end
