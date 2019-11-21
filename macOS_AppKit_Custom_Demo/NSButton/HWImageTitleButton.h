//
//  HWImageTitleButton.h
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/15.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import <Cocoa/Cocoa.h>
typedef NS_ENUM(NSInteger,HWImageTitleButtonType){
//    HWImageTitleButtonTypeDefault = 0,//图片在左
    HWImageTitleButtonTypeLeft = 0,//图片在左
    HWImageTitleButtonTypeTop ,//图片在上
    HWImageTitleButtonTypeRight ,
    HWImageTitleButtonTypeBottom ,
};
NS_ASSUME_NONNULL_BEGIN

@interface HWImageTitleButton : NSButton
- (instancetype)initWithFrame:(NSRect)frameRect title:(NSString *)title image:(NSImage *)image target:(id)target action:(SEL)action tag:(NSInteger)tag superView:(NSView *)superView;
@property (nonatomic, assign) HWImageTitleButtonType type;
@property (nonatomic, assign) CGFloat top;//图片距离上 或下 或左  可自行修改


+ (HWImageTitleButton *)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action tag:(NSInteger)tag superView:(NSView *)superView;
@end

NS_ASSUME_NONNULL_END
