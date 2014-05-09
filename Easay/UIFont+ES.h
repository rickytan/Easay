//
//  UIFont+ES.h
//  Easay
//
//  Created by ricky on 14-4-18.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (ES)
+ (instancetype)lightFontWithSize:(CGFloat)size;
+ (instancetype)boldFontWithSize:(CGFloat)size;
+ (NSString *)lightFontName;
+ (NSString *)boldFontName;
@end
