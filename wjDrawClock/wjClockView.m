//
//  wjClockView.m
//  wjDrawClock
//
//  Created by gouzi on 2017/5/22.
//  Copyright © 2017年 wj. All rights reserved.
//

#import "wjClockView.h"

@implementation wjClockView

- (void)setSeconds:(int)seconds {
    _seconds = seconds;
    [self setNeedsDisplay];
}

- (void)setMinute:(int)minute {
    _minute = minute;
    [self setNeedsDisplay];
}

- (void)setHour:(int)hour {
    _hour = hour;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    [self drawWatchFaceWithRect:rect];
    [self drawNeedleHandWithRect:rect];
//    [self drawSecondHandWithRect:rect];
//    [self drawMinuteHandWithRect:rect];
//    [self drawHourHandWithRect:rect];
}

// 表盘
- (void)drawWatchFaceWithRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 - 10;
    // 圆
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2)];
    [circle setLineWidth:3.0f];
    [[UIColor lightGrayColor] set];
    CGContextAddPath(ctx, circle.CGPath);
    
    // 画刻度
    UIBezierPath *clock = [UIBezierPath bezierPath];
    for (int i = 0; i < 60; ++i) {
        CGFloat angle = -M_PI_2 + i / 60.0f * M_PI * 2;
        // 圆上的点
        CGFloat x = center.x + radius * cos(angle) ;
        CGFloat y = center.y + radius * sin(angle);
        [clock moveToPoint:CGPointMake(x, y)];
        // 刻度线的另一端
        CGFloat x0 = center.x + (radius - 10) * cos(angle);
        CGFloat y0 = center.y + (radius - 10) * sin(angle);
        CGFloat x1 = center.x + (radius - 20) * cos(angle);
        CGFloat y1 = center.y + (radius - 20) * sin(angle);
        // 5的倍数的长度
        if (i % 5 == 0) {
            [clock addLineToPoint:CGPointMake(x1, y1)];
        } else {
            [clock addLineToPoint:CGPointMake(x0, y0)];
        }
        [[UIColor purpleColor] set];
    }
    CGContextAddPath(ctx, clock.CGPath);
    CGContextStrokePath(ctx);
}

- (UIColor *)randomColor {
    CGFloat red = arc4random_uniform(256) / 255.0f;
    CGFloat green = arc4random_uniform(256) / 255.0f;
    CGFloat blue = arc4random_uniform(256) / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}


// 所有的指针进行统一设置
- (void)drawNeedleHandWithRect:(CGRect)rect {
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5;
    NSArray *needleArray = @[
                             @{@"length" : @(radius - 15), @"angle" : @(-M_PI_2 + self.seconds / 60.0 * M_PI * 2)},
                             @{@"length" : @(radius - 30), @"angle" : @(-M_PI_2 + (self.minute / 60.0) * M_PI * 2 + self.seconds / 3600.f * M_PI * 2)},
                             @{@"length" : @(radius - 45), @"angle" : @(-M_PI_2 + (self.hour / 12.0) * M_PI * 2 + self.minute / 720.f * M_PI * 2 + self.seconds / (12 * 3600.f) * M_PI * 2)}
                             ];
    for (NSDictionary *needleDict in needleArray) {
        NSNumber *needleRadius = needleDict[@"length"];
        CGFloat needleRadiusLength = needleRadius.floatValue;
        NSNumber *angle = needleDict[@"angle"];
        CGFloat angleValue = angle.floatValue;
        CGFloat x = center.x + needleRadiusLength * cos(angleValue);
        CGFloat y = center.y + needleRadiusLength * sin(angleValue);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:center];
        [path addLineToPoint:CGPointMake(x, y)];
        [[self randomColor] set];
        [path stroke];
    }
}



// 秒针
- (void)drawSecondHandWithRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 - 15; // 秒针长度
    [path moveToPoint:center];
    
    CGFloat angle = -M_PI_2 + self.seconds / 60.0 * M_PI * 2;
    // 圆上的点
    CGFloat x = center.x + radius * cos(angle) ;
    CGFloat y = center.y + radius * sin(angle);
    [path addLineToPoint:CGPointMake(x, y)];
    [[UIColor redColor] set];
    [path stroke];
}

// 分针
- (void)drawMinuteHandWithRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 - 30; // 分针长度
    [path moveToPoint:center];
    
    CGFloat angle = -M_PI_2 + (self.minute / 60.0) * M_PI * 2 + self.seconds / 3600.f * M_PI * 2;
    // 圆上的点
    CGFloat x = center.x + radius * cos(angle) ;
    CGFloat y = center.y + radius * sin(angle);
    [path addLineToPoint:CGPointMake(x, y)];
    [[UIColor orangeColor] set];
    [path stroke];
}


// 时针
- (void)drawHourHandWithRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 - 45; // 时针长度
    [path moveToPoint:center];
    
    CGFloat angle = -M_PI_2 + (self.hour / 12.0) * M_PI * 2 + self.minute / 720.f * M_PI * 2 + self.seconds / (12 * 3600.f) * M_PI * 2;
    // 圆上的点
    CGFloat x = center.x + radius * cos(angle) ;
    CGFloat y = center.y + radius * sin(angle);
    [path addLineToPoint:CGPointMake(x, y)];
    [[UIColor blueColor] set];
    [path stroke];
}



@end
