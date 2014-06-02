//
//  ESHeaderButton.m
//  Easay
//
//  Created by ricky on 14-4-14.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESHeaderButton.h"
#import <QuartzCore/QuartzCore.h>

@interface ESHeaderButton ()
@property (nonatomic, strong) UIImageView * foregroundImage;
@property (nonatomic, strong) CALayer * maskLayer;
@end

@implementation ESHeaderButton

- (void)commonInit
{
    [self setImage:[UIImage imageNamed:@"header-default"]
          forState:UIControlStateNormal];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.cornerRadius = 8;

    self.maskLayer = [CALayer layer];
    self.maskLayer.borderColor = [UIColor whiteColor].CGColor;
    self.maskLayer.borderWidth = 3.f;
    self.maskLayer.shadowColor = [UIColor blackColor].CGColor;
    self.maskLayer.shadowOpacity = 0.25;
    self.maskLayer.shadowRadius = 2.0;

    [self.layer insertSublayer:self.maskLayer
                       atIndex:0];
}

- (void)awakeFromNib
{
    [self commonInit];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.maskLayer.frame = self.bounds;
    self.maskLayer.cornerRadius = CGRectGetWidth(self.bounds) / 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectOffset(self.bounds, 6, 6)
                                                    cornerRadius:CGRectGetWidth(self.bounds)];

    self.maskLayer.shadowPath = path.CGPath;
    self.imageView.frame = CGRectInset(self.bounds, 2.5, 2.5);
}

@end
