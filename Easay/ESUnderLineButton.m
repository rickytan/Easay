//
//  ESUnderLineButton.m
//  Easay
//
//  Created by ricky on 14-5-17.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESUnderLineButton.h"
#import "UIColor+RExtension.h"

@implementation ESUnderLineButton

- (void)awakeFromNib
{
    NSString *title = [self titleForState:UIControlStateNormal];
    NSDictionary *attr = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                           NSUnderlineColorAttributeName: [UIColor whiteColor]};
    [self setAttributedTitle:[[NSAttributedString alloc] initWithString:title
                                                             attributes:attr]
                    forState:UIControlStateSelected];
    [self setTitleColor:[UIColor whiteColor]
               forState:UIControlStateSelected];
    [self setTitleColor:[UIColor colorWithHexString:@"#16579f"]
               forState:UIControlStateNormal];
}

@end
