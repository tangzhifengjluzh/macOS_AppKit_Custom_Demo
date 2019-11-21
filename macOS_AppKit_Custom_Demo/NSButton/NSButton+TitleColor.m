//
//  NSButton+TitleColor.m
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/13.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import "NSButton+TitleColor.h"

#import <AppKit/AppKit.h>


@implementation NSButton (TitleColor)
- (void)setTitle:(NSString *)title
{
//    self setValue:title forKey:<#(nonnull NSString *)#>
    NSColor *color = kColorFromRGB(0x1c1c1c);
//    if ([title isEqualToString:HWLocalizedString(@"run_online")]) {
//        color = [NSColor whiteColor];
//    }
         NSMutableParagraphStyle *pghStyle = [[NSMutableParagraphStyle alloc] init];
         pghStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *dicAtt = @{ NSParagraphStyleAttributeName: pghStyle,NSFontAttributeName:[NSFont systemFontOfSize:13],NSForegroundColorAttributeName:color};
     //    // 创建NSAttributedString赋值给NSButton的attributedTitle属性
     //    _buttonUpdateAction.attributedTitle = [[NSAttributedString alloc] initWithString:HWLocalizedString(@"update_action") attributes:dicAtt];
     // 创建NSAttributedString赋值给NSButton的attributedTitle属性  处理不居中问题。不要用title赋值
     self.attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:dicAtt];
    
//    NSLog(@"%@",title);
}

//- (void)drawRect:(NSRect)dirtyRect
//{
//    [super drawRect:dirtyRect];
//    if ([[self cell] isHighlighted]) {
//        NSLog(@"444");
//       }
//}
- (void)viewDidMoveToWindow
{

    if (self.tag == 5002) {
        [self addTrackingRect:[self bounds] owner:self userData:nil assumeInside:NO];
    }

}


- (void)mouseEntered:(NSEvent *)event
{
    NSLog(@"mouseEntered");
    self.layer.backgroundColor = [NSColor yellowColor].CGColor;
}
- (void)mouseExited:(NSEvent *)event
{
    NSLog(@"mouseExited");
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;

}
@end
