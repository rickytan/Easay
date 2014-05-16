//
//  ESSegmentView.m
//  Easay
//
//  Created by ricky on 14-5-9.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESSegmentView.h"
#import "UIColor+RExtension.h"
#import "UIFont+ES.h"

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
            [self.segmentLayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
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

- (void)setTitles:(NSArray *)titles
{
    if (_titles != titles) {
        BOOL numEqual = _titles.count == titles.count;
        if (!titles.count)
            return;
        _titles = titles;
        
        if (!numEqual) {
            [self.titleLayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
            [self.titleLayers removeAllObjects];
            
            for (NSString *str in _titles) {
                CATextLayer *layer = [CATextLayer layer];
                layer.string = str;
                layer.fontSize = 8;
                layer.contentsGravity = kCAGravityBottom;
                layer.font = (__bridge CFTypeRef)([UIFont boldFontName]);
                layer.contentsScale = [UIScreen mainScreen].scale;
                layer.alignmentMode = kCAAlignmentCenter;
                [self.titleLayers addObject:layer];
                [self.layer addSublayer:layer];
            }
        }
        else {
            for (int i=0; i < _titles.count; ++i) {
                ((CATextLayer *)self.titleLayers[i]).string = _titles[i];
            }
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
                             CATextLayer *textLayer = self.titleLayers.count > 0 ? self.titleLayers[i] : nil;
                             CGRectDivide(rect, &split, &remain, num.floatValue / sum * width, CGRectMinXEdge);
                             layer.frame = split;
                             split = layer.frame;
                             split.size = textLayer.preferredFrameSize;
                             textLayer.bounds = split;
                             textLayer.position = layer.position;
                             remain.origin.x += SEGMENT_MARGIN;
                             rect = remain;
                         }
                     }
                     completion:NULL];
}

@end
