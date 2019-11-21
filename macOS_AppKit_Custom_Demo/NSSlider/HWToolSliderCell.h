//
//  HWToolSlider.h
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/15.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWToolSliderCell : NSSliderCell
@property (nonatomic, strong) IBInspectable NSColor *sliderProgressColor;
@property (nonatomic, strong) IBInspectable NSColor *sliderBackgroundColor;
@property (nonatomic, strong) IBInspectable NSColor *sliderKnobColor;
@property (nonatomic, assign) IBInspectable CGFloat sliderHeight;
@property (nonatomic, assign) IBInspectable CGFloat sliderBarRadius;
@property (nonatomic, assign) IBInspectable CGFloat sliderKnobWidth;
@property (nonatomic, assign) IBInspectable CGFloat sliderKnobHeight;
@end

NS_ASSUME_NONNULL_END
