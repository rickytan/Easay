//
//  ESChartView.h
//  Easay
//
//  Created by ricky on 14-5-20.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESLineChartView : UIView
@property (nonatomic, strong) NSArray * data;
@end

@interface ESBarChartView : UIView
- (CGPoint)basePositionForIndex:(NSInteger)index;
- (CGFloat)heightForIndex:(NSInteger)index;
- (UIColor *)barColorForIndex:(NSInteger)index;

- (NSInteger)numberOfTitles:(NSInteger)index;
- (NSString *)titleForIndex:(NSInteger)index;
- (CGPoint)titlePositionForIndex:(NSInteger)index;
@end

@interface ESYearBarChartView : ESBarChartView

@end;