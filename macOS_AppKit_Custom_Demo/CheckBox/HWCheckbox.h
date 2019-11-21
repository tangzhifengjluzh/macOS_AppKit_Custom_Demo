//
//  HWCheckbox.h
//  macOS_AppKit_Custom_Demo
//
//  Created by xia luzheng on 2019/11/21.
//  Copyright © 2019 xia luzheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWCheckbox : NSButton

{
    @private
    NSArray* states;
    NSArray* alternateStates;
}


@property (strong,nonatomic) NSColor* color;
@property (strong,nonatomic) NSArray* states;
@property (strong,nonatomic) NSArray* alternateStates;
@property (nonatomic, assign) BOOL imageTip;//是否用图片 yes为是用图片 no为绘图

@end
NS_ASSUME_NONNULL_END
