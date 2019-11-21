//
//  HWTopBlackView.m
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/13.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import "HWTopBlackView.h"
@interface HWTopBlackView()
@property (nonatomic, strong) NSMutableArray  *paths;
@property (nonatomic, assign) float  maginLeftOne;//第一个坐标距离左边的位置
@property (nonatomic, assign) float  maginLeftTwo;//第一个坐标距离左边的位置

@end
@implementation HWTopBlackView

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}
- (void)initData
{
    self.titles = @[@"normal_mode",@"servo_adjust"];
    self.maginLeftOne = 20;
    self.maginLeftTwo = 20;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:HWChangeLanguageNotification object:nil];
}

- (void)changeLanguage:(NSNotification*)noti
{
    [self setNeedsDisplay:YES];
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    self.wantsLayer = YES;
    self.layer.backgroundColor = kColorFromRGB(0x181819).CGColor;
    self.layer.masksToBounds = YES;
    //    self.index = 3;
    // Drawing code here.
    [self reFresh];
}
- (NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (CGSize)getTitleSize:(NSString *)title
{
    NSDictionary *dict = @{NSFontAttributeName:[NSFont systemFontOfSize:14]};
    NSSize size = [title boundingRectWithSize:NSMakeSize(MAXFLOAT, self.frame.size.height) options:0 attributes:dict context:nil].size;
    return size;
}

- (void)reFresh
{
    [self.paths removeAllObjects];
    NSString *title = self.titles[0];
    //    NSDictionary *dict = @{NSFontAttributeName:[NSFont systemFontOfSize:kPointMake(14)]};
    //    NSSize size = [title boundingRectWithSize:NSMakeSize(MAXFLOAT, kPointMake(36)) options:0 attributes:dict context:nil].size;
    //    NSLog(@"%f",kPointMake(14));
    float lineWidth = 1;
    
    float point1_x = self.maginLeftOne;
    float point1_y = 0;
    CGPoint point1 = CGPointMake(point1_x, point1_y);
    
    float point2_x = self.maginLeftOne + self.maginLeftTwo;
    float point2_y = self.frame.size.height - 4 + lineWidth / 2.0 ;
    CGPoint point2 = CGPointMake(point2_x, point2_y);
    
    float point3_x = point2_x + [self getTitleSize:title].width + self.maginLeftTwo;
    float point3_y = point2_y;
    CGPoint point3 = CGPointMake(point3_x, point3_y);
    
    float point4_x = point3_x - self.maginLeftTwo;
    float point4_y = point1_y;
    CGPoint point4 = CGPointMake(point4_x, point4_y);
    
    NSColor *textColorBlack = kColorFromRGB(0x101010);
    NSColor *textColorWhite = kColorFromRGB(0xfdfefe);
    NSColor *textColor = textColorBlack;
    for (int i = 0; i<self.titles.count; i++) {
        NSString *title = self.titles[i];
        NSSize size = [self getTitleSize:title];
        
        NSBezierPath *path = [NSBezierPath bezierPath];
        path.lineWidth = lineWidth;
        
        if (i != 0) {
            point1 = point4;
            point2 = CGPointMake(point3.x, point3.y - lineWidth / 2.0);
            if (self.index != 0 && i == self.index) {
                point2_y = point2.y + lineWidth ;
                point2 = CGPointMake(point2.x, point2_y);
            }
            point3_x = point3_x + size.width + self.maginLeftTwo;
            point3_y = point3_y ;
            point3 = CGPointMake(point3_x, point3_y);
            
            point4_x = point4_x + size.width + self.maginLeftTwo;
            point4_y = point4_y;
            point4 = CGPointMake(point4_x, point4_y);
        }
        
        [path moveToPoint:point1];
        [path lineToPoint:point2];
        [path lineToPoint:point3];
        [path lineToPoint:point4];
        [path lineToPoint:point1];
        [[NSColor whiteColor]set];
        path.lineCapStyle = NSLineCapStyleRound;
        path.lineJoinStyle = NSLineJoinStyleRound;
        
        if (self.index == i) {
            [path fill];
            textColor = textColorBlack;
        }else{
            [path stroke];
            textColor = textColorWhite;
        }
        //        self.index == i ? [path fill]:[path stroke];
        //        textColor = self.index == i ? textColorBlack:textColorWhite;
        NSDictionary *dicAtt = @{NSFontAttributeName:[NSFont systemFontOfSize:14],NSForegroundColorAttributeName:textColor};
        [title drawAtPoint:NSMakePoint(point2.x, (self.frame.size.height - 4 - size.height) / 2.0) withAttributes:dicAtt];
        [self.paths addObject:path];
    }
}

- (void)mouseDown:(NSEvent *)event
{
    CGPoint eventLocation = [event locationInWindow];
    NSPoint point = [self convertPoint:eventLocation fromView:nil];
    [self.paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSBezierPath *path = obj;
        if ([path containsPoint:point]) {
            NSLog(@"mouseDown  %ld",idx);
            if (self.index != idx) {
                self.index = idx;
                [self setNeedsDisplay:YES];
                if ([self.delegate respondsToSelector:@selector(topBlackViewSelectTitleIndex:)]) {
                    [self.delegate topBlackViewSelectTitleIndex:self.index];
                }
            }
        }
    }];
}
/*创建方法：
 
 + (instancetype)bezierPath;使用比较多，因为这方法创建的对象，我们可以根据我们的需要任意定制样式，可以画任何我们想画的图形。
 
 + (instancetype)bezierPathWithRect:(CGRect)rect;这方法根据一个矩形画贝塞尔曲线。
 
 + (instancetype)bezierPathWithOvalInRect:(CGRect)rect;这方法根据一个矩形画内切曲线。通常用它来画圆或者椭圆。
 
 + (NSBezierPath *)bezierPathWithRoundedRect:(NSRect)rect xRadius:(CGFloat)xRadius yRadius:(CGFloat)yRadius NS_AVAILABLE_MAC(10_5);
 构建一个path：
 
 - (void)moveToPoint:(CGPoint)point; 设置第一个起始点到接收器
 
 - (void)addLineToPoint:(CGPoint)point;附加一条直线到接收器的路径
 
 - (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2; 该方法就是画三次贝塞尔曲线的关键方法，以三个点画一段曲线，一般和moveToPoint:配合使用。其实端点为moveToPoint:设置，终止端点位为endPoint；。控制点1的坐标controlPoint1，这个参数可以调整。控制点2的坐标是controlPoint2。
 
 - (void)closePath;闭合线
 
 - (void)removeAllPoints;移除所有的点
 
 相对path 构建
 
 - (void)relativeMoveToPoint:(NSPoint)point;将接收器的当前点移动，偏移坐标为point的坐标
 
 - (void)relativeLineToPoint:(NSPoint)point;关联坐标点，从当前点偏移point的坐标，在这两点之间连线。该方法需要用到在使用- (void)relativeMoveToPoint:(NSPoint)point后使用
 
 - (void)relativeCurveToPoint:(NSPoint)endPoint controlPoint1:(NSPoint)controlPoint1 controlPoint2:(NSPoint)controlPoint2;该方法就是画三次贝塞尔曲线的关键方法，以三个点画一段曲线，一般和moveToPoint:配合使用。其实端点为moveToPoint:设置，终止端点位为endPoint；。控制点1的坐标controlPoint1，这个参数可以调整。控制点2的坐标是controlPoint2。
 
 path 信息：
 
 @property (getter=isEmpty, readonly) BOOL empty;;该值指示路径是否有任何有效的元素。
 
 @property (readonly) NSRect bounds;路径包括的矩形。
 
 @property (readonly) NSPoint currentPoint;图形路径中的当前点。
 
 @property (readonly) NSRect controlPointBounds;
 
 Hit detection.接收器检测
 - (BOOL)containsPoint:(NSPoint)point;接收器是否包含指定的点。
 绘制属性：
 
 @property CGFloat lineWidth; 线宽。
 
 @property NSLineCapStyle lineCapStyle; 端点类型。
 typedef NS_ENUM(NSUInteger, NSLineCapStyle) {
 NSButtLineCapStyle = 0,//默认的
 NSRoundLineCapStyle = 1,//轻微圆角
 NSSquareLineCapStyle = 2//正方形
 };
 @property NSLineJoinStyle lineJoinStyle; 连接类型。
 typedef NS_ENUM(NSUInteger, NSLineJoinStyle) {
 NSMiterLineJoinStyle = 0,//默认的表示斜接
 NSRoundLineJoinStyle = 1,//圆滑衔接
 NSBevelLineJoinStyle = 2 //斜角连接
 };
 
 
 @property CGFloat miterLimit; 这个限制值有助于避免在连接线段志坚的尖峰
 
 @property CGFloat flatness;确定弯曲路径短的绘制精度的因素
 
 @property NSWindingRule windingRule;
 
 // Default path rendering parameters.
 
 @property (class) CGFloat defaultMiterLimit;
 @property (class) CGFloat defaultFlatness;
 
 @property (class) NSWindingRule defaultWindingRule;
 @property (class) NSLineCapStyle defaultLineCapStyle;
 @property (class) NSLineJoinStyle defaultLineJoinStyle;
 @property (class) CGFloat defaultLineWidth;
 
 - (void)setLineDash:(nullable const CGFloat *)pattern count:(NSInteger)count phase:(CGFloat)phase; 设置线型
 
 - (void)getLineDash:(nullable CGFloat *)pattern count:(nullable NSInteger *)count phase:(nullable CGFloat *)phase; 检索线型
 当前图形上下文中的路径操作：
 
 - (void)fill;  填充颜色
 
 - (void)stroke; 各个点连线
 
 - (void)addClip;与封闭的接收器的路径与当前徒刑上下文的裁剪路径的面积
 - (void)setClip;
 + (void)fillRect:(NSRect)rect;
 + (void)strokeRect:(NSRect)rect;
 + (void)clipRect:(NSRect)rect;
 + (void)strokeLineFromPoint:(NSPoint)point1 toPoint:(NSPoint)point2;
 + (void)drawPackedGlyphs:(const char *)packedGlyphs atPoint:(NSPoint)point;
 */

@end
