//
//  ESWeekDataView.m
//  Easay
//
//  Created by ricky on 14-5-17.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESWeekDataView.h"
#import "UIColor+RExtension.h"
#import "UIFont+ES.h"

@implementation ESWeekDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.layer.masksToBounds = YES;
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.backgroundColor = [UIColor clearColor];
    self.weekData = @[@0, @0, @0, @0, @0, @0, @0];
    
    for (id obj in self.weekData) {
        CALayer *layer = [CALayer layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = 8;
        layer.anchorPoint = CGPointMake(0.5, 1.0);
        [self.layer addSublayer:layer];
    }
}

#define PADDING 44.f

- (void)drawRect:(CGRect)rect
{
    CGFloat space = (self.bounds.size.width - PADDING * 2) / (self.layer.sublayers.count  - 1);
    for (int i=0; i < self.weekData.count; ++i) {
        NSString *s = [NSString stringWithFormat:@"%d", i+1];
        [s drawAtPoint:CGPointMake(PADDING + i * space - 3, 76)
        withAttributes:@{NSFontAttributeName: [UIFont boldFontWithSize:12],
                         NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [CATransaction setDisableActions:NO];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGFloat space = (self.bounds.size.width - PADDING * 2) / (self.layer.sublayers.count  - 1);
                         CGFloat max = 0.0f;
                         for (NSNumber *n in self.weekData) {
                             if (max < n.floatValue)
                                 max = n.floatValue;
                         }
                         if (max <= 0.0)
                             max = 1.0f;
                         for (int i=0; i<self.weekData.count; ++i) {
                             CALayer *layer = self.layer.sublayers[i];
                             CGFloat value = [self.weekData[i] floatValue];
                             layer.bounds = CGRectMake(0, 0, 16, value * 54 / max);
                             layer.backgroundColor = [UIColor yellowColorForLevel:max - value
                                                                            total:max].CGColor;
                             layer.position = CGPointMake(PADDING + i * space, 72);
                         }
                     }
                     completion:NULL];
}

- (void)setWeekData:(NSArray *)weekData
{
    if (_weekData != weekData) {
        _weekData = weekData;
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
}

@end
