//
//  ESChartView.h
//  Easay
//
//  Created by ricky on 14-5-20.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESDataView : UIView
@property (nonatomic, readonly, assign) BOOL touchDown;
@property (nonatomic, readonly, assign) CGPoint touchPoint;
@property (nonatomic, strong) UIColor * titleBackgroundColor;   // Default clear;

- (CGFloat)lineMinY;
- (CGFloat)lineMaxY;
- (CGRect)drawableRect;
- (NSString *)pointTitle;

@end

@interface ESLineChartView : ESDataView
@property (nonatomic, strong) NSArray * data;
@end

@interface ESBarChartView : ESDataView
- (CGPoint)basePositionForIndex:(NSInteger)index;
- (CGFloat)heightForIndex:(NSInteger)index;
- (UIColor *)barColorForIndex:(NSInteger)index;

- (NSInteger)numberOfTitles:(NSInteger)index;
- (NSString *)titleForIndex:(NSInteger)index;
- (CGPoint)titlePositionForIndex:(NSInteger)index;
@end

@interface ESYearBarChartView : ESBarChartView

@end;