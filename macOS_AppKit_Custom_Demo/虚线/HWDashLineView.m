//
//  HWHDashLineView.m
//  Bus Servo Control
//
//  Created by LOBOT on 2019/10/9.
//  Copyright © 2019年 HiWonder. All rights reserved.
//

#import "HWDashLineView.h"

@implementation HWDashLineView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSBezierPath *path = [NSBezierPath bezierPath];
    CGFloat array[2];
    array[0] = 4.0;
    array[1] = 2.0;
    
    [path setLineDash:array count:2 phase:0];
    NSPoint pt1 = NSMakePoint(0, 0);
    NSPoint pt2 = NSMakePoint(dirtyRect.size.width, 0);
    if (dirtyRect.size.width < dirtyRect.size.height) {
         pt2 = NSMakePoint(0, dirtyRect.size.height);
    }
    [path moveToPoint:pt1];
    [path relativeLineToPoint:pt2];
    [path setLineWidth:1];
    [[NSColor redColor] set];
    [path stroke];
}

@end
