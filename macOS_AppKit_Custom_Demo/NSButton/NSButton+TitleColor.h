//
//  NSButton+TitleColor.h
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/13.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSButton (TitleColor)
@property (nonatomic, assign) BOOL               touch;
@property (nonatomic, assign) BOOL               allowTouch;
@property (nonatomic, assign) BOOL               imageButton;
@end

NS_ASSUME_NONNULL_END
