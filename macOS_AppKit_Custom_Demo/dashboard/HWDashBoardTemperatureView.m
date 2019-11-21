//
//  HWDashBoareTemperatureView.m
//  Bus Servo Control
//
//  Created by LOBOT on 2019/10/11.
//  Copyright © 2019年 HiWonder. All rights reserved.
//

#import "HWDashBoardTemperatureView.h"
#import <QuartzCore/CAAnimation.h>

@implementation HWDashBoardTemperatureView
{
    NSSize imageSize;
    float scale;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
//    self.wantsLayer = YES;
//    self.layer.backgroundColor = [NSColor redColor].CGColor;
    NSImage *image = kGetImage(@"temperature");
    imageSize = image.size;
    scale = self.frame.size.width / imageSize.width;
    [image drawInRect:dirtyRect];
//    self.pro = 140;
    [self progress:self.pro];
//    float value = 50;
//    float min =  195.0 / 140.0;
//    NSRect rect1 = NSMakeRect(26, 45, 13, min * value);
//    NSBezierPath *thePath1 = [NSBezierPath bezierPathWithRect:rect1];
////    NSBezierPath *thePath1 = [NSBezierPath bezierPathWithRoundedRect:rect1 xRadius:2 yRadius:6];
//
////    [thePath1 setLineJoinStyle:NSLineJoinStyleRound];
//    [[NSColor redColor] setStroke];
////    [thePath1 setLineCapStyle:NSRoundLineCapStyle];
//    [thePath1 stroke];

}
- (void)progress:(CGFloat)value{
    NSLog(@"tem = %f  刻度 = %f",value - 10,value);
     float min =  507.0 / 140.0 * scale;
    
    //背景
//    NSRect rectBack = NSMakeRect(76 * scale, 97 * scale - 4, 20 * scale, min * 140 + 4);
//    //    NSBezierPath *thePath1 = [NSBezierPath bezierPathWithRect:rect1];
//    NSBezierPath *thePathBack = [NSBezierPath bezierPathWithRoundedRect:rectBack xRadius:10 * scale yRadius:10 * scale];
//    
//    [kColorFromRGB(0xcccccc) set];
//    [thePathBack setLineCapStyle:NSRoundLineCapStyle];
//    [thePathBack fill];
    
    
    
   
    NSRect rect1 = NSMakeRect(39.5 * scale, 92 * scale, 10 * scale, min * value);
    //    NSBezierPath *thePath1 = [NSBezierPath bezierPathWithRect:rect1];
    NSBezierPath *thePath1 = [NSBezierPath bezierPathWithRoundedRect:rect1 xRadius:5 * scale yRadius:5 * scale];

    [kColorFromRGB(0xEA5514) set];
    [thePath1 setLineCapStyle:NSRoundLineCapStyle];
    [thePath1 fill];
    
    NSRect rect = NSMakeRect(39.5 * scale, 78 * scale, 10 * scale, 16 * scale);
    if (value <= 4) {
        rect.size.height = value;
    }
    NSBezierPath *thePath = [NSBezierPath bezierPathWithRect:rect];
    [kColorFromRGB(0xEA5514) set];
    [thePath setLineCapStyle:NSRoundLineCapStyle];
    [thePath fill];


}
@end
