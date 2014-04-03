//
//  ESTextField.m
//  Easay
//
//  Created by ricky on 14-4-4.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESTextField.h"

@implementation ESTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.placeholderTextColor = [UIColor whiteColor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.placeholderTextColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    [self.placeholderTextColor set];
    CGSize size = [self.placeholder sizeWithFont:self.font];
    [self.placeholder drawInRect:CGRectMake(rect.origin.x, rect.origin.y + (CGRectGetHeight(rect) - size.height) / 2, size.width, size.height)
                                      withFont:self.font];
}

@end
