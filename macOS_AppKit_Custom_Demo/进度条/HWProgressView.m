//
//  HWProgressView.m
//  Bus Servo Control
//
//  Created by LOBOT on 2019/10/30.
//  Copyright © 2019年 HiWonder. All rights reserved.
//

#import "HWProgressView.h"
//
//  HWDashBoareTemperatureView.m
//  Bus Servo Control
//
//  Created by LOBOT on 2019/10/11.
//  Copyright © 2019年 HiWonder. All rights reserved.
//

#import <QuartzCore/CAAnimation.h>
@interface HWProgressView()
@property (nonatomic, copy)   NSString            *title;
@end
@implementation HWProgressView
{
    NSSize imageSize;
    float scale;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"设置中。。。";
    }
    return self;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.layer.cornerRadius = 2;
    
    //    self.pro = 140;
    [self progress:self.pro];
    //(1)NSString绘制字符串
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    //字体类型和大小
    [md setObject:[NSFont fontWithName:@"Arial" size:15] forKey:NSFontAttributeName];
    //字体颜色
    [md setObject:[NSColor redColor] forKey:NSForegroundColorAttributeName];
    
    CGSize textSize = [self.title boundingRectWithSize:self.bounds.size options:NSStringDrawingTruncatesLastVisibleLine attributes:md context:nil].size;
    CGPoint point = CGPointMake((self.bounds.size.width - textSize.width) / 2.0, (self.bounds.size.height - textSize.height) / 2.0) ;
    [self.title drawAtPoint:point withAttributes:md];
    
}
- (void)progress:(CGFloat)value{
    NSRect rect1 = NSMakeRect(0, 0, value, self.frame.size.height);
    //    NSBezierPath *thePath1 = [NSBezierPath bezierPathWithRect:rect1];
    NSBezierPath *thePath1 = [NSBezierPath bezierPathWithRoundedRect:rect1 xRadius:2 yRadius:2];
    
    [[NSColor greenColor] set];
    [thePath1 setLineCapStyle:NSRoundLineCapStyle];
    [thePath1 fill];
}

- (void)setPro:(CGFloat)pro
{
    _pro = pro;
    if (pro > 0) {
        self.hidden = NO;
        float time = 0;
        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
        while (time < 1) {
            [self performSelector:@selector(showProgress:) withObject:self afterDelay:time];
            time = time + 1 / kProgressWidth;
        }
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime) * 1000;
        NSLog(@"－－－－－－cost time = %f ms(毫秒)", linkTime);// －－－－－－cost time = 30968.497992 ms(毫秒)
        
    }else{
        self.hidden = YES;
        [self setNeedsDisplay:YES];
        //        self.hidden = YES;
    }
}

- (void)showProgress:(HWProgressView*)progress
{
    //    static float pro = 0;
    //    pro = pro + 1 ;
    //        NSLog(@"进度 = %f",_pro);
    
    if (_pro < kProgressWidth  ) {
        self.title = @"设置中。。。";
    }else{
        self.title = @"设置完成";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.pro = 0;
            self.title = @"设置中。。。";
        });
    }
    [self setNeedsDisplay:YES];
    _pro = _pro + 1;
}
@end
