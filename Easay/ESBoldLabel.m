//
//  ESBoldLabel.m
//  Easay
//
//  Created by ricky on 14-4-4.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESBoldLabel.h"

@implementation ESBoldLabel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.font = [UIFont fontWithName:@"Nexa Bold"
                                    size:self.font.pointSize];
    }
    return self;
}

@end

@implementation ESLightLabel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.font = [UIFont fontWithName:@"Nexa Light"
                                    size:self.font.pointSize];
    }
    return self;
}

@end

@implementation ESBoldButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.titleLabel.font = [UIFont fontWithName:@"Nexa Bold"
                                               size:self.titleLabel.font.pointSize];
        [self setNeedsLayout];
    }
    return self;
}

@end