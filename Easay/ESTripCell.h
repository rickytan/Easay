//
//  ESTripCell.h
//  Easay
//
//  Created by ricky on 14-5-24.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESTripCell : UITableViewCell
@property (nonatomic, assign) IBOutlet UILabel * exchangeLabel;
@property (nonatomic, assign) IBOutlet UILabel * timeLabel;
@property (nonatomic, assign) IBOutlet UILabel * distanceLabel;
@property (nonatomic, assign) IBOutlet UILabel * priceLabel;
@end
