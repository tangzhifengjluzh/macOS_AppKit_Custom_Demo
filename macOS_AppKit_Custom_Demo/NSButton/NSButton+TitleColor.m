//
//  NSButton+TitleColor.m
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/13.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import "NSButton+TitleColor.h"
#import <objc/runtime.h>

#import <AppKit/AppKit.h>

static char touchKey; //touch的key
static char allowTouchKey; //那么的key
static char imageButtonKey; //那么的key
@implementation NSButton (TitleColor)
- (void)setTitle:(NSString *)title
{
//    self setValue:title forKey:<#(nonnull NSString *)#>
    NSColor *color = kColorFromRGB(0x1c1c1c);
    if (self.touch) {
         color = [NSColor whiteColor];
     }
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
- (BOOL)touch
{
    return [objc_getAssociatedObject(self, &touchKey) boolValue];
}

- (BOOL)allowTouch
{
    return [objc_getAssociatedObject(self, &allowTouchKey) boolValue];
}

- (BOOL)imageButton
{
    return [objc_getAssociatedObject(self, &imageButtonKey) boolValue];
}

- (void)setTouch:(BOOL)touch
{
    objc_setAssociatedObject(self, &touchKey, @(touch), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setAllowTouch:(BOOL)allowTouch
{
    objc_setAssociatedObject(self, &allowTouchKey, @(allowTouch), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setImageButton:(BOOL)imageButton
{
    objc_setAssociatedObject(self, &imageButtonKey, @(imageButton), OBJC_ASSOCIATION_ASSIGN);
}
-(void)setFrame:(NSRect)frame
{
    [super setFrame:frame];
    NSTrackingArea *area =[[NSTrackingArea alloc] initWithRect:self.bounds options:NSTrackingMouseEnteredAndExited|NSTrackingActiveInKeyWindow owner:self userInfo:nil];
    [self addTrackingArea:area];
}



- (void)mouseEntered:(NSEvent *)event
{
    NSLog(@"mouseEntered");
    self.layer.backgroundColor = [NSColor orangeColor].CGColor;
    self.touch = YES;
         [self setTitle:self.title];
}
- (void)mouseExited:(NSEvent *)event
{
    NSLog(@"mouseExited");
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.touch = NO;
     [self setTitle:self.title];
}
@end
