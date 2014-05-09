//
//  ESSegmentView.m
//  Easay
//
//  Created by ricky on 14-5-9.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESSegmentView.h"

@interface ESSegmentView ()
@property (nonatomic, strong) NSArray * titleLayers;
@property (nonatomic, strong) NSArray * segmentLayers;
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
}

- (void)setSegments:(NSArray *)segments
{
    if (![_segments isEqual:segments]) {
        _segments = segments;

        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        for (NSNumber *num in _segments) {
            
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    self.layer.cornerRadius = size.height / 2;
    
}

@end
