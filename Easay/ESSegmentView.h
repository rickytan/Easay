//
//  ESSegmentView.h
//  Easay
//
//  Created by ricky on 14-5-9.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSegmentView : UIView
@property (nonatomic, strong) NSArray * segments;
@property (nonatomic, strong) NSString * titles;    // Assert titles.count == segments.count
@end
