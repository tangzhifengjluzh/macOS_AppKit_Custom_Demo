//
//  HWSliderTextFieldView.m
//  macOS_AppKit_Custom_Demo
//
//  Created by xia luzheng on 2019/11/21.
//  Copyright © 2019 xia luzheng. All rights reserved.
//

#import "HWSliderTextFieldView.h"

@interface HWSliderTextFieldView ()
@property (nonatomic, assign)  NSPoint point1;
@property (nonatomic, assign) BOOL  down;

@end
@implementation HWSliderTextFieldView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (instancetype)initWithTag:(NSInteger)tag title:(NSString*)title delegate:(id)delegate
{
    self = [super init];
    if (self) {
        [self setUI];
//        self.title.stringValue = title;
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor yellowColor].CGColor;
        self.delegate = delegate;
//        self.textField.tag = tag;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reSetFrame) name:HWRefreshSliderTextFieldNotification object:nil];

    }
    return self;
}
- (void)setUI
{
            NSTextField *lable = [NSTextField labelWithString:@"点我拖拽"];
            lable.textColor = [NSColor redColor];
            [self addSubview:lable];
            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.centerY.equalTo(self);
    //            make.height.mas_equalTo(30);
            }];
}
- (void)reSetFrame
{
    self.frame = self.orginFrame;
    float height = self.superview.superview.frame.size.height;
    
    HWCenterView *superView = (HWCenterView*)self.superview;
    NSScrollView *scrollView = (NSScrollView*)superView.superview.superview;
    superView.frame = scrollView.bounds;
    scrollView.hasHorizontalScroller = scrollView.hasVerticalScroller = NO;

//    NSRect rectSuper = superView.frame;
//
//    rectSuper.size.height = CGRectGetMaxY(self.frame);
//    if (rectSuper.size.height < height) {
//        rectSuper.size.height = height;
//        scrollView.hasVerticalScroller = NO;
//        superView.frame = rectSuper;
//    }
}


-(void)setFrame:(NSRect)frame
{
    [super setFrame:frame];
//    [HWTools setViewAnchorPoint:CGPointMake(0.5, 0.5) forView:self];

    if (self.orginFrame.size.width == 0) {//记录最初的坐标
        self.orginFrame = frame;
    }
    
//    NSRect rect = self.frame;
//    rect.origin.x = point.x - self.point1.x ;// - ;
//    rect.origin.y = point.y - (rect.size.height - self.point1.y) ;
//
//    self.frame = rect;
    
    float height = self.superview.superview.frame.size.height;
    
    HWCenterView *superView = (HWCenterView*)self.superview;
    NSScrollView *scrollView = (NSScrollView*)superView.superview.superview;
    NSRect rectSuper = superView.frame;
    
//    rectSuper.size.height = CGRectGetMaxY(frame);
//    rectSuper.size.width = CGRectGetMaxX(frame);
//    if (rectSuper.size.height < height) {
////        rectSuper.size.height = height;
//
//    }else{
//        scrollView.hasVerticalScroller = YES;
//        superView.frame = rectSuper;
//    }
    
    if (CGRectGetMaxY(self.frame) > CGRectGetMaxY(superView.maxYView.frame)) {
        superView.maxYView = self;//记录最底的
         NSRect rect = superView.frame;
        rect.size.height = CGRectGetMaxY(superView.maxYView.frame);
        if (CGRectGetHeight(rect) > CGRectGetHeight(scrollView.frame)) {
            superView.frame = rect;
            scrollView.hasVerticalScroller = YES;
        }
    }
    if (CGRectGetMaxX(self.frame) > CGRectGetMaxX(superView.maxXView.frame)) {
        superView.maxXView = self;//记录最右的
        NSRect rect = superView.frame;
        rect.size.width = CGRectGetMaxX(superView.maxXView.frame);
        if (CGRectGetWidth(rect) > CGRectGetWidth(scrollView.frame)) {
            superView.frame = rect;
            scrollView.hasHorizontalScroller = YES;
        }
    }
}

- (void)mouseDown:(NSEvent *)event
{
    //    CGPoint point =  [event locationInWindow];
    //    NSLog(@"down");
    
    //    NSPoint eventLocation = [event locationInWindow];
    //    NSPoint point = [self.superview convertPoint:eventLocation fromView:nil];
    //    //判断当前鼠标位置是否在中心点范围内
    //    if (NSPointInRect(point, self.superview.bounds)) {
    //        //        draged = YES;
    //        NSLog(@"55");
    //    }
    NSPoint eventLocation = [event locationInWindow];
    NSPoint point = [self.superview convertPoint:eventLocation fromView:nil];
    _point1 = [self convertPoint:eventLocation fromView:nil];
    
    //判断当前鼠标位置是否在中心点范围内
    if (NSPointInRect(point, self.superview.bounds)) {
        //        draged = YES;
        //        NSLog(@"%@",NSStringFromPoint(_point1));
        [self.superview addSubview:self positioned:NSWindowAbove relativeTo:self.superview.subviews.lastObject];
        self.down = YES;
        [[NSCursor pointingHandCursor] set];
    }
//    [super mouseDown:event];
}

- (void)mouseDragged:(NSEvent *)event
{
    //    NSLog(@"mouseDragged");
    NSPoint eventLocation = [event locationInWindow];
    NSPoint point = [self.superview convertPoint:eventLocation fromView:nil];
    //判断当前鼠标位置是否在中心点范围内
    //    if (NSPointInRect(point, self.superview.bounds)) {
    //        //        draged = YES;
    //        //        NSLog(@"%@",NSStringFromPoint(point1));
    //        //        NSLog(@"mouseDragged");
    //        NSRect rect = self.frame;
    //        rect.origin.x = point.x - self.point1.x ;// - ;
    //        rect.origin.y = point.y - (rect.size.height - self.point1.y) ;
    ////        rect.origin.x = point.x  ;// - ;
    ////        rect.origin.y = point.y  ;
    //        self.frame = rect;
    //
    //
    //        //        [self setFrameOrigin:point];
    ////        [[NSCursor currentSystemCursor] set];
    //    }
    
    //        draged = YES;
    //        NSLog(@"%@",NSStringFromPoint(point1));
    //        NSLog(@"mouseDragged");
    NSRect rect = self.frame;
    rect.origin.x = point.x - self.point1.x ;// - ;
    rect.origin.y = point.y - (rect.size.height - self.point1.y) ;

    
    if (rect.origin.x < 0) {
        rect.origin.x = 0;
    }
    
    if (rect.origin.y < 0) {
        rect.origin.y = 0;
    }
    
    self.frame = rect;
    
    float height = self.superview.superview.frame.size.height;
    float width = self.superview.superview.frame.size.width;

    HWCenterView *superView = (HWCenterView*)self.superview;
    NSScrollView *scrollView = (NSScrollView*)superView.superview.superview;
    NSRect rectSuper = superView.frame;
    
    rectSuper.size.height = CGRectGetMaxY(rect);
    rectSuper.size.width = CGRectGetMaxX(rect);
//    if (height > superView.maxY) {
//        superView.maxY = height;
//    }
    
    if (rectSuper.size.height < height) {
        rectSuper.size.height = height;
        scrollView.hasVerticalScroller = NO;
    }else{
        scrollView.hasVerticalScroller = YES;
    }
    
    if (rectSuper.size.width < width) {
        rectSuper.size.width = width;
        scrollView.hasHorizontalScroller = NO;
    }else{
        scrollView.hasHorizontalScroller = YES;
    }
    
    
    superView.frame = rectSuper;
    //        NSLog(@"point %@",NSStringFromPoint(point));
    //        NSLog(@"mouseDragged");
    //    NSLog(@"eventLocation %@",NSStringFromPoint(eventLocation));
}

- (void)mouseUp:(NSEvent *)event;
{
    self.down = NO;
    [[NSCursor arrowCursor] set];
     HWCenterView *superView = (HWCenterView*)self.superview;
    if (CGRectGetMaxY(self.frame) > CGRectGetMaxY(superView.maxYView.frame)) {
        if (superView.maxYView != nil) {
            superView.maxYViewSecond = superView.maxYView;
        }
        superView.maxYView = self;
    }else if (superView.maxYView != nil){
        NSRect rect = superView.frame;
        NSScrollView *scrollView = (NSScrollView*)superView.superview.superview;
        if (CGRectGetMaxY(superView.maxYViewSecond.frame) > CGRectGetMaxY(superView.maxYView.frame)) {
            rect.size.height = CGRectGetMaxY(superView.maxYViewSecond.frame);
            superView.frame = rect;
            scrollView.hasVerticalScroller = YES;
        }else if(CGRectGetMaxY(rect) < CGRectGetMaxY(superView.maxYView.frame)){
            rect.size.height = CGRectGetMaxY(superView.maxYView.frame);
            superView.frame = rect;
            scrollView.hasVerticalScroller = YES;
        }
    }
    
    if (CGRectGetMaxX(self.frame) > CGRectGetMaxX(superView.maxXView.frame)) {
        if (superView.maxXView != nil) {
            superView.maxXViewSecond = superView.maxXView;
        }
        superView.maxXView = self;
    }else if (superView.maxXView != nil){
        NSRect rect = superView.frame;
        NSScrollView *scrollView = (NSScrollView*)superView.superview.superview;
        if (CGRectGetMaxX(superView.maxXViewSecond.frame) > CGRectGetMaxX(superView.maxXView.frame) && CGRectGetMaxX(superView.maxXViewSecond.frame) > CGRectGetWidth(scrollView.frame)) {
            rect.size.width = CGRectGetMaxX(superView.maxXViewSecond.frame);
            superView.frame = rect;
            scrollView.hasHorizontalScroller = YES;
        }else if(CGRectGetMaxX(rect) < CGRectGetMaxX(superView.maxXView.frame)){
            rect.size.width = CGRectGetMaxX(superView.maxXView.frame);
            superView.frame = rect;
            scrollView.hasHorizontalScroller = YES;
        }
    }
}

@end
