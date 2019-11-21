//
//  HWCenterView.m
//  Bus Servo Control
//
//  Created by LOBOT on 2019/9/30.
//  Copyright © 2019年 HiWonder. All rights reserved.
//

#import "HWCenterView.h"

@implementation HWCenterView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    //    self.wantsLayer = YES;
    ////    self.layer.borderWidth = 1;
    ////    self.layer.borderColor =  kColorFromRGB(0xC0E0EB).CGColor;// [NSColor cyanColor].CGColor;
    //    self.layer.backgroundColor = kHiWonderToolViewBackColor.CGColor;
    //    self.layer.cornerRadius = 8;
    
    
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = kColorFromRGB(0xd9d9d9);
    shadow.shadowOffset = CGSizeMake(2, 2);
    shadow.shadowBlurRadius = 2;
    self.shadow = shadow;
    // Drawing code here.
}

- (BOOL)isFlipped
{
    return YES;
}

-(void)setFrame:(NSRect)frame
{
    [super setFrame:frame];
    if (self.orginFrame.size.width == 0) {//记录最初的坐标
        self.orginFrame = frame;
    }
    //    if (CGRectGetWidth(frame) < CGRectGetWidth(self.orginFrame) || CGRectGetHeight(frame) < CGRectGetHeight(self.orginFrame)) {
    //        self.frame = self.orginFrame;
    //    }
}

@end
