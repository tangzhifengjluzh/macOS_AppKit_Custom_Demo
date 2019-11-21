//
//  HWCenterView.h
//  Bus Servo Control
//
//  Created by LOBOT on 2019/9/30.
//  Copyright © 2019年 HiWonder. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HWSliderTextFieldView.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWCenterView : NSView
@property (nonatomic, assign) float  maxY;
@property (nonatomic, assign) float  maxX;
@property (nonatomic, strong) HWSliderTextFieldView  *maxYView;
@property (nonatomic, strong) HWSliderTextFieldView  *maxYViewSecond;
@property (nonatomic, strong) HWSliderTextFieldView  *maxXView;
@property (nonatomic, strong) HWSliderTextFieldView  *maxXViewSecond;
@property (nonatomic, assign) NSRect  orginFrame;
@end

NS_ASSUME_NONNULL_END
