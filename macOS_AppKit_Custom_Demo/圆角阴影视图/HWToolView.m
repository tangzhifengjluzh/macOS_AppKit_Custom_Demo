//
//  HWToolView.m
//  Bus Servo Control
//
//  Created by LOBOT on 2019/10/9.
//  Copyright © 2019年 HiWonder. All rights reserved.
//

#import "HWToolView.h"

@implementation HWToolView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    self.wantsLayer = YES;
//    self.layer.borderWidth = 1;
//    self.layer.borderColor =  kHiWonderToolBackBorderColor.CGColor;// [NSColor cyanColor].CGColor;
    self.layer.backgroundColor = [NSColor cyanColor].CGColor;
    self.layer.cornerRadius = 8;
    
    self.layer.backgroundColor = kColorFromRGB(0xe8e8e8).CGColor;
    if (self.backColor) {
            self.layer.backgroundColor = self.backColor.CGColor;
    }

               NSShadow *shadow = [[NSShadow alloc]init];
                   shadow.shadowColor = [NSColor redColor];//kColorFromRGB(0xd7d7d7)
                   shadow.shadowOffset = CGSizeMake(1, -1);
                   shadow.shadowBlurRadius = 1;
                   self.shadow = shadow;
    // Drawing code here.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
//    NSView *viewTop = [NSView new];
//    viewTop.wantsLayer = YES;
//    viewTop.layer.backgroundColor = kHiWonderToolBackColor.CGColor;
//    [self addSubview:viewTop];
//    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).with.offset(0);
//        make.left.equalTo(self).with.offset(0);
//        make.right.equalTo(self).with.offset(0);
//        make.height.mas_equalTo(@(18));
//    }];
//    self.lableTitle = [[UILabel alloc]initWithFrame:NSMakeRect(0, kHWSliderTextFieldViewHeight - 17, kHWSliderTextFieldViewWidth, 17)];
    self.lableTitle = [NSTextField labelWithString:@"ID"];
    self.lableTitle.font = [NSFont systemFontOfSize:18];
    self.lableTitle.alignment = NSTextAlignmentCenter;
//    self.lableTitle.editable = NO;
//    self.lableTitle.bordered = NO;
//    self.lableTitle.backgroundColor = kHiWonderMaingColor;//[NSColor clearColor];
//    [self.lableTitle setNeedsDisplay:YES];
    [self addSubview:self.lableTitle];
    [self.lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
//        make.height.equalTo(@18);
    }];
}
@end
