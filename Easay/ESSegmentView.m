//
//  ESSegmentView.m
//  Easay
//
//  Created by ricky on 14-5-9.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESSegmentView.h"
#import "UIColor+RExtension.h"

@interface ESSegmentView ()
@property (nonatomic, strong) NSMutableArray * titleLayers;
@property (nonatomic, strong) NSMutableArray * segmentLayers;
@end

@implementation ESSegmentView

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
    self.segments = @[@2, @3, @1, @8];
    
    [self performSelector:@selector(setSegments:)
               withObject:@[@4, @1,@12, @5]
               afterDelay:2];
}

- (NSMutableArray *)segmentLayers
{
    if (!_segmentLayers) {
        _segmentLayers = [[NSMutableArray alloc] init];
    }
    return _segmentLayers;
}

- (NSMutableArray *)titleLayers
{
    if (!_titleLayers) {
        _titleLayers = [[NSMutableArray alloc] init];
    }
    return _titleLayers;
}

- (void)setSegments:(NSArray *)segments
{
    if (_segments != segments) {
        BOOL numEqual = _segments.count == segments.count;
        if (!segments.count)
            return;
        
        _segments = segments;
        
        if (!numEqual) {
            [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
            [self.segmentLayers removeAllObjects];
            
            NSInteger count = _segments.count;
            for (NSNumber *num in _segments) {
                CALayer *layer = [CALayer layer];
                layer.backgroundColor = [UIColor yellowColorForLevel:count--
                                                               total:_segments.count].CGColor;
                [self.segmentLayers addObject:layer];
                [self.layer addSublayer:layer];
            }
        }
        else {
            [self setNeedsLayout];
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    
}

#define SEGMENT_MARGIN  2.0f

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    self.layer.cornerRadius = size.height / 2;
    
    CGFloat sum = 0.f;
    for (NSNumber *num in self.segments) {
        sum += num.floatValue;
    }
    
    [CATransaction setDisableActions:NO];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGFloat width = size.width - (self.segments.count - 1) * SEGMENT_MARGIN;
                         CGRect rect = self.bounds;
                         CGRect split = CGRectZero;
                         CGRect remain = CGRectZero;
                         for (int i=0; i<self.segments.count; ++i) {
                             NSNumber *num = self.segments[i];
                             CALayer *layer = self.segmentLayers[i];
                             CGRectDivide(rect, &split, &remain, num.floatValue / sum * width, CGRectMinXEdge);
                             layer.frame = split;
                             remain.origin.x += SEGMENT_MARGIN;
                             rect = remain;
                         }
                     }
                     completion:NULL];
}

@end
