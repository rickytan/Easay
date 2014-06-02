//
//  ESChartView.m
//  Easay
//
//  Created by ricky on 14-5-20.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESChartView.h"
#import "UIColor+RExtension.h"
#import "UIFont+ES.h"

@implementation ESLineChartView
{
    BOOL        _touchDown;
    CGPoint     _touchPoint;
}

- (void)awakeFromNib
{
    self.data = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                  [NSValue valueWithCGPoint:CGPointMake(0.1, 0.3)],
                  [NSValue valueWithCGPoint:CGPointMake(0.2, 0.4)],
                  [NSValue valueWithCGPoint:CGPointMake(0.24, 0.33)],
                  [NSValue valueWithCGPoint:CGPointMake(0.4, 0.9)],
                  [NSValue valueWithCGPoint:CGPointMake(0.5, 1.0)],
                  [NSValue valueWithCGPoint:CGPointMake(0.56, 0.95)],
                  [NSValue valueWithCGPoint:CGPointMake(0.64, 0.6)],
                  [NSValue valueWithCGPoint:CGPointMake(0.7, 0.64)],
                  [NSValue valueWithCGPoint:CGPointMake(0.8, 0.34)],
                  [NSValue valueWithCGPoint:CGPointMake(0.86, 0.38)],
                  [NSValue valueWithCGPoint:CGPointMake(0.94, 0.2)],
                  [NSValue valueWithCGPoint:CGPointMake(1.0, 0.0)]];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.data && self.data.count > 1) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:[self convertToDrawPoint:[self.data[0] CGPointValue]]];
        for (int i=1; i<self.data.count; ++i) {
            [path addLineToPoint:[self convertToDrawPoint:[self.data[i] CGPointValue]]];
        }
        [[UIColor colorWithHexString:@"#ffe400"] setStroke];
        [path setLineWidth:3];
        [path setLineCapStyle:kCGLineCapRound];
        [path setLineJoinStyle:kCGLineJoinRound];
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        UIColor* fillColor = [UIColor clearColor];
        UIColor* strokeColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.2];
        
        //// Gradient Declarations
        NSArray* gradientColors = [NSArray arrayWithObjects:
                                   (id)strokeColor.CGColor,
                                   (id)fillColor.CGColor, nil];
        CGFloat gradientLocations[] = {0, 0.7};
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradientColors, gradientLocations);
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, rect.size.height), 0);
        CGContextRestoreGState(context);
        
        [path stroke];
    }
    NSDictionary *textAttr = @{NSFontAttributeName: [UIFont lightFontWithSize:10],
                               NSForegroundColorAttributeName: [UIColor whiteColor]};
    [@"12pm" drawAtPoint:CGPointMake(10, rect.size.height - 10)
          withAttributes:textAttr];
    [@"12am" drawAtPoint:CGPointMake(rect.size.width / 2 - 12, rect.size.height - 10)
          withAttributes:textAttr];
    [@"12pm" drawAtPoint:CGPointMake(rect.size.width - 24 - 10, rect.size.height - 10)
          withAttributes:textAttr];
    
    if (_touchDown) {
        [[UIColor colorWithHexString:@"#ffe400"] setFill];
        CGContextFillEllipseInRect(context, CGRectMake(_touchPoint.x - 2, _touchPoint.y - 2, 4, 4));
        [[UIColor whiteColor] setStroke];
        CGContextSetLineWidth(context, 1);
        CGContextMoveToPoint(context, _touchPoint.x, CGRectGetMaxY([self drawableRect]));
        CGPoint p = [self calMinY];
        CGContextAddLineToPoint(context, p.x, p.y);
        CGContextDrawPath(context, kCGPathStroke);
    }
}

- (CGPoint)calMinY
{
    CGPoint p = [self convertToDataPoint:_touchPoint];
    CGFloat minY = 0.f;
    for (int i=0; i < self.data.count - 1; ++i) {
        CGPoint q0 = [self.data[i] CGPointValue];
        CGPoint q1 = [self.data[i+1] CGPointValue];
        if (q0.x <= p.x && p.x < q1.x) {
            minY = (q1.y - q0.y) / (q1.x - q0.x) * (p.x - q0.x) + q0.y;
            break;
        }
    }
    return [self convertToDrawPoint:CGPointMake(p.x, minY)];
}

- (CGRect)drawableRect
{
    CGRect rect = CGRectInset(self.bounds, 18, 10);
    rect = CGRectOffset(rect, 0, -8);
    return rect;
}

- (CGPoint)convertToDrawPoint:(CGPoint)point
{
    CGRect rect = [self drawableRect];
    CGSize size = rect.size;
    CGPoint origin = rect.origin;
    return CGPointMake(point.x * size.width + origin.x, size.height - point.y * size.height + origin.y);
}

- (CGPoint)convertToDataPoint:(CGPoint)point
{
    CGRect rect = [self drawableRect];
    CGSize size = rect.size;
    CGPoint p = CGPointMake(_touchPoint.x - rect.origin.x, _touchPoint.y - rect.origin.y);
    return CGPointMake(p.x / size.width, 1.f - p.y / size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchDown = YES;
    _touchPoint = [[touches anyObject] locationInView:self];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchPoint = [[touches anyObject] locationInView:self];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchDown = NO;
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchDown = NO;
    [self setNeedsDisplay];
}

@end

@implementation ESBarChartView

- (void)drawRect:(CGRect)rect
{
    
}

@end