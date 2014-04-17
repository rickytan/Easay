//
//  UIFont+ES.m
//  Easay
//
//  Created by ricky on 14-4-18.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "UIFont+ES.h"

@implementation UIFont (ES)

+ (instancetype)lightFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Nexa Light"
                           size:size];
}

+ (instancetype)boldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Nexa Bold"
                           size:size];
}


@end
