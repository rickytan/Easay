//
//  ESPrivacyCell.m
//  Easay
//
//  Created by ricky on 14-5-10.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESPrivacyCell.h"
#import "UIFont+ES.h"

@implementation ESPrivacyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont lightFontWithSize:14];
        self.textLabel.textColor = [UIColor whiteColor];
        self.detailTextLabel.font = [UIFont lightFontWithSize:11];
        self.detailTextLabel.textColor = [UIColor whiteColor];
        self.detailTextLabel.numberOfLines = 0;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //CGRect rect = {0};
    
    self.imageView.center = CGPointMake(20, 24);
    CGPoint center = self.textLabel.center;
    center.x = CGRectGetMaxX(self.imageView.frame) + 4 + CGRectGetWidth(self.textLabel.bounds) / 2;
    center.y = 24;
    self.textLabel.center = center;
    
    CGRect slice, remainder;
    CGRectDivide(self.contentView.bounds, &slice, &remainder, CGRectGetMaxY(self.imageView.frame), CGRectMinYEdge);
    slice = CGRectInset(remainder, 10, 10);
    self.detailTextLabel.frame = slice;
}

@end
