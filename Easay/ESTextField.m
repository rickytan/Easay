//
//  ESTextField.m
//  Easay
//
//  Created by ricky on 14-4-4.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESTextField.h"
#import "UIFont+ES.h"

@implementation ESTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.placeholderTextColor = [UIColor whiteColor];
        self.placeholderFont = [UIFont lightFontWithSize:self.font.pointSize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.placeholderTextColor = [UIColor whiteColor];
        self.placeholderFont = [UIFont lightFontWithSize:self.font.pointSize];
    }
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    [self.placeholderTextColor set];
    UIFont * font = (self.placeholderFont) ? self.placeholderFont : self.font;
    CGSize size = [self.placeholder sizeWithFont:font];
    [self.placeholder drawInRect:CGRectMake(rect.origin.x, rect.origin.y + (CGRectGetHeight(rect) - size.height) / 2, size.width, size.height)
                                      withFont:font];
}

@end
