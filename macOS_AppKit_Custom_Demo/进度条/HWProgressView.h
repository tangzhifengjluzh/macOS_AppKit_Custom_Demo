//
//  HWProgressView.h
//  Bus Servo Control
//
//  Created by LOBOT on 2019/10/30.
//  Copyright © 2019年 HiWonder. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWProgressView : NSView
- (void)progress:(CGFloat)value;
@property (nonatomic, assign) CGFloat  pro;

@end

NS_ASSUME_NONNULL_END
