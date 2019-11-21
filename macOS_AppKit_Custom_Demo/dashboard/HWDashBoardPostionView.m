//
//  HWDashBoardPostionView.m
//  Bus Servo Control
//
//  Created by LOBOT on 2019/10/11.
//  Copyright © 2019年 HiWonder. All rights reserved.
//

#import "HWDashBoardPostionView.h"
#import <Quartz/Quartz.h>
#define space 1
#define radius1 ((self.frame.size.width-space*2)/2 - 20)
#define radius4 10
#define radius2 (radius1-radius4/2.0)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define lineColor  kColorFromRGB(0xF4CB36)
@interface HWDashBoardPostionView()
//刻度数目
@property (nonatomic,assign)int scaleNumber;
//开始弧度
@property (nonatomic,assign)CGFloat start;
//结束弧度
@property (nonatomic,assign)CGFloat end;
@property (nonatomic, assign) CGPoint  center;
@property (nonatomic, assign) CGFloat angleTip;
@end
@implementation HWDashBoardPostionView

{
    NSView *pointView ;
    
    CGFloat angle;//总弧度
    CGFloat perAngle;
    CAShapeLayer *layer7;
    NSBezierPath *pathpointer;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor clearColor].CGColor;
    // Drawing code here.
    _angleTip = 45;
    _scaleNumber = 101;

    _start = 180 + _angleTip;// M_PI*5/6 -  M_PI/12;
    _end = -_angleTip;// M_PI/6 + M_PI/12;
    angle =  180 + _angleTip * 2;//  计算总弧度

    perAngle = angle/(_scaleNumber-1);//根据数量计算每个刻度占的弧度
   
    self.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    NSBezierPath *bezierPath = [NSBezierPath bezierPath];
    bezierPath.lineWidth = 4;
    [bezierPath appendBezierPathWithArcWithCenter:self.center radius:radius1
                                       startAngle:360
                                         endAngle:0
                                        clockwise:YES];
    
    [lineColor set];
    [bezierPath stroke];
//    NSBezierPath *bezierPath1 = [NSBezierPath bezierPath];
//    [bezierPath1 appendBezierPathWithArcWithCenter:self.center radius:radius1
//                                        startAngle:360
//                                          endAngle:0
//                                         clockwise:YES];
//
//    [kHiWonderDashBroadLightBackColor set];//016D2C
//    [bezierPath1 fill];
//
//
//    NSBezierPath *bezierPath2 = [NSBezierPath bezierPath];
//    [bezierPath2 appendBezierPathWithArcWithCenter:self.center radius:radius1 - 12
//                                        startAngle:360
//                                          endAngle:0
//                                         clockwise:YES];
//
//    [kColorFromRGB(0x016D2C) set];
//    [bezierPath2 fill];
    //画指针
    pointView = [[NSView alloc]initWithFrame:CGRectMake(  self.center.x, self.center.y, radius1 - 20, 2)];
    
    pointView.wantsLayer = YES;
    pointView.layer.backgroundColor = lineColor.CGColor;
    //    [self addSubview:pointView];
    
    //画圆心
    
    NSView *view = [[NSView alloc]initWithFrame:CGRectMake(self.center.x - radius4 , self.center.y - radius4 , radius4 * 2, radius4 * 2)];
    view.wantsLayer = YES;
    view.layer.cornerRadius = radius4;
    
    view.layer.backgroundColor = lineColor.CGColor;
    [self addSubview:view];
    //阴影
//    NSShadow *shadow = [[NSShadow alloc]init];
//    shadow.shadowColor = [NSColor blackColor];
//    shadow.shadowOffset = CGSizeMake(2, -2);
//    shadow.shadowBlurRadius = 2;
//    view.shadow = shadow;
    NSBezierPath *bezierPathlight = [NSBezierPath bezierPath];
    [bezierPathlight appendBezierPathWithArcWithCenter:self.center radius:radius4 + 2
                                       startAngle:360
                                         endAngle:0
                                        clockwise:YES];
    
    [lineColor set];
    [bezierPathlight stroke];
    
    
    layer7 = [[CAShapeLayer alloc]init];
    //
    layer7.frame = CGRectMake(self.center.x - 44 /2.0, self.center.y, 44, 1);
    pointView.layer.mask = layer7;
    layer7.backgroundColor = lineColor.CGColor;
    layer7.anchorPoint = CGPointMake(0, 1);
    
    [self.layer addSublayer:layer7];
    
    for (int i = 0; i< _scaleNumber; i++) {
        CGFloat startAngel = _start-perAngle*i;
        CGFloat endAngel = startAngel - perAngle/2;//刻度线的宽度
        NSBezierPath *path = [NSBezierPath bezierPath];
        if (i % 10 == 0) {
            path.lineWidth = 8;
            [path appendBezierPathWithArcWithCenter:self.center radius:radius2 - 12 startAngle:startAngel endAngle:endAngel clockwise:YES];
            if (i % 50 == 0) {
                CGPoint point = [self calculateTextPositonWithArcCenter:CGPointMake(self.center.x, self.center.y) Angle:M_PI/(180/startAngel)];
                
                NSTextField *title = [[NSTextField alloc]initWithFrame:CGRectMake(point.x-10 - 10, point.y- 5, 34, 18)];
                title.wantsLayer = YES;
                title.backgroundColor = [NSColor clearColor];
                title.textColor = lineColor;
                title.editable = NO;
                title.bordered = NO;
                title.font = [NSFont systemFontOfSize:10];

                title.stringValue = [NSString stringWithFormat:@"%d",i * 10];
                if (i == 50) {
                    title.frame = CGRectMake(point.x-10 - 5, point.y- 10, 32, 12);
                    title.alignment =NSTextAlignmentCenter;
                }else if (i == 100){
                    title.frame = CGRectMake(point.x - 10 - 10 , point.y - 5, 32, 12);
                    //                title.alignment =NSTextAlignmentRight;
                }else if (i == 0){
                    title.frame = CGRectMake(point.x - 2 , point.y - 10, 32, 12);
                }
                [self addSubview:title];
            }
        }else{
            path.lineWidth = 4;
            [path appendBezierPathWithArcWithCenter:self.center radius:radius2 - 12 startAngle:startAngel endAngle:endAngel clockwise:YES];
        }
        [lineColor set];
        [path stroke];
    }
    [self progress:0];

}
- (CGPoint)calculateTextPositonWithArcCenter:(CGPoint)center
                                       Angle:(CGFloat)angel
{
    CGFloat x = (radius2-24) * cosf(angel);
    CGFloat y = (radius2-24) * sinf(angel);
    return CGPointMake(center.x + x, center.y + y);
}

- (void)progress:(CGFloat)value{
    //    CGFloat ang = angle*value/25-angle/2;
    //    NSLog(@"value:%f",RADIANS_TO_DEGREES(ang));
    float _angle = _start / 180.0 * M_PI;// M_PI + M_PI_4;
    float min =  (angle / 180.0 * M_PI) / 100.0;// (M_PI + M_PI_2) / 100.0;
    float ang = _angle - min * value;
    NSLog(@"value:%f",value);
    CGAffineTransform form = CGAffineTransformMakeRotation( ang);
    layer7.affineTransform = form;
}

@end
