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
@end

@implementation ESHeaderButton

- (void)commonInit
{
    self.foregroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header-border"]];
    [self addSubview:self.foregroundImage];
    
    [self setImage:[UIImage imageNamed:@"header-default"]
          forState:UIControlStateNormal];
    self.imageView.layer.cornerRadius = 8;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
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
    CGSize size = self.bounds.size;
    self.foregroundImage.center = CGPointMake(size.width / 2, size.height / 2);
}
@end
