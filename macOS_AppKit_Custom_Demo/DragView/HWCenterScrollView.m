//
//  HWCenterScrollView.m
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/14.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import "HWCenterScrollView.h"

@implementation HWCenterScrollView
{
    CALayer *subLayer;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
//    self.wantsLayer = YES;
//    self.layer.backgroundColor = kColorFromRGB(0xd2d2d2).CGColor;
    self.layer.cornerRadius = 8;
    
//    NSShadow *shadow = [[NSShadow alloc]init];
//              shadow.shadowColor = [NSColor lightGrayColor];//kColorFromRGB(0xd7d7d7)
//              shadow.shadowOffset = CGSizeMake(2, 2);
//              shadow.shadowBlurRadius = 2;
//              self.subviews.firstObject.shadow = shadow;
//
//    NSShadow *shadow2 = [[NSShadow alloc]init];
//              shadow2.shadowColor = [NSColor lightGrayColor];//kColorFromRGB(0xd7d7d7)
//              shadow2.shadowOffset = CGSizeMake(2, 2);
//              shadow2.shadowBlurRadius = 2;
//              self.shadow = shadow;
    
    if (subLayer == nil) {
        subLayer=[CALayer layer];
        CGRect fixframe = self.frame;
        subLayer.frame= fixframe;
        subLayer.cornerRadius=6;
        subLayer.backgroundColor=[[NSColor blackColor] colorWithAlphaComponent:0.46].CGColor;
        subLayer.masksToBounds=NO;
        subLayer.shadowColor = [NSColor blackColor].CGColor;//shadowColor阴影颜色
        subLayer.shadowOffset = CGSizeMake(0,-2);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
        subLayer.shadowOpacity = 0.46;//阴影透明度，默认0
        subLayer.shadowRadius = 4;//阴影半径，默认3
        [self.superview.layer insertSublayer:subLayer below:self.layer];
    }

}

@end
