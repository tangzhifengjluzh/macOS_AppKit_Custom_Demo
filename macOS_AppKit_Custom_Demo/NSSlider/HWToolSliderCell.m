//
//  HWToolSlider.m
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/15.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import "HWToolSliderCell.h"
#define SLIDER_DEFAUT_HEIGHT               6.0
#define SLIDER_DEFAUT_BAR_RADIUS           3
#define SLIDER_DEFAUT_KNOB_WIDTH           22.0
#define SLIDER_DEFAUT_KNOB_HEIGHT          22.0
@interface HWToolSliderCell()

// save leftBar's frame, and use to caculate Knob's frame
@property (assign) NSRect leftBarRect;
//@property (nonatomic, assign) BOOL vertical;

@end
@implementation HWToolSliderCell
- (instancetype)init
{
    self = [super init];
    if (self) {
//              self.sliderProgressColor = SLIDER_PROGRESS_DEFAUT_COLOR;
//              self.sliderBackgroundColor = SLIDER_BACKGROUND_DEFAUT_COLOR;
//              self.sliderKnobColor = SLIDER_KNOB_DEFAUT_COLOR;
              self.sliderHeight = SLIDER_DEFAUT_HEIGHT;
              self.sliderBarRadius = SLIDER_DEFAUT_BAR_RADIUS;
              self.sliderKnobWidth = SLIDER_DEFAUT_KNOB_WIDTH;
              self.sliderKnobHeight = SLIDER_DEFAUT_KNOB_HEIGHT;
    }
    return self;
}
- (void)drawBarInside:(NSRect)rect flipped:(BOOL)flipped
{
    if (rect.size.width > rect.size.height) {//水平
       rect.size.height = self.sliderHeight;
         // Bar radius
         CGFloat barRadius = self.sliderBarRadius;
         // Knob position depending on control min/max value and current control value.
         CGFloat value = ([self doubleValue]  - [self minValue]) / ([self maxValue] - [self minValue]);
         // Final Left Part Width
         CGFloat finalWidth = value * ([[self controlView] frame].size.width - self.sliderKnobWidth);
         
         // Left Part Rect
         NSRect leftRect = rect;
         leftRect.size.width = finalWidth;
         self.leftBarRect = leftRect;
         
         // Draw Left Part
         NSBezierPath* bg = [NSBezierPath bezierPathWithRoundedRect: rect xRadius: barRadius yRadius: barRadius];
         [kColorFromRGB(0xffa500) setFill];
         [bg fill];
         
         // Draw Right Part
         NSBezierPath* active = [NSBezierPath bezierPathWithRoundedRect: leftRect xRadius: barRadius yRadius: barRadius];
         [kColorFromRGB(0xffa500) setFill];
         [active fill];
    }else{//垂直
      rect.size.width = self.sliderHeight;
         // Bar radius
         CGFloat barRadius = self.sliderBarRadius;
         // Knob position depending on control min/max value and current control value.
         CGFloat value = ([self doubleValue]  - [self minValue]) / ([self maxValue] - [self minValue]);
         // Final Left Part Width
         CGFloat finalWidth = value * ([[self controlView] frame].size.height - self.sliderKnobHeight);
         
         // Left Part Rect
         NSRect leftRect = rect;
         leftRect.size.height = finalWidth;
         self.leftBarRect = leftRect;
         
         // Draw Left Part
         NSBezierPath* bg = [NSBezierPath bezierPathWithRoundedRect: rect xRadius: barRadius yRadius: barRadius];
         [kColorFromRGB(0xffa500) setFill];
         [bg fill];
         
         // Draw Right Part
         NSBezierPath* active = [NSBezierPath bezierPathWithRoundedRect: leftRect xRadius: barRadius yRadius: barRadius];
         [kColorFromRGB(0xffa500) setFill];
         [active fill];
    }
}
- (void)drawKnob:(NSRect)knobRect {
    
//    if (((NSSlider *)self.controlView).highlighted) {
    if (self.vertical) {
//        [super drawKnob:knobRect];
        NSRect customKnobRect = NSMakeRect(_leftBarRect.origin.x + _leftBarRect.size.width / 2 - self.sliderKnobHeight / 2, knobRect.origin.y, self.sliderKnobWidth , self.sliderKnobHeight);
        if (_leftBarRect.size.height == 0) {
            customKnobRect.origin.y = customKnobRect.origin.y - 1;
        }
        // Draw Left Part
//        self.
        NSBezierPath* bg = [NSBezierPath bezierPathWithRoundedRect: customKnobRect xRadius: self.sliderKnobWidth  yRadius: self.sliderKnobHeight ];
        NSShadow *shadow = [NSShadow new];
        shadow.shadowOffset = CGSizeMake(2, 2);
        
        [[NSColor whiteColor]  setFill];
        [bg fill];
    }else{
        
        NSRect customKnobRect = NSMakeRect(_leftBarRect.size.width, _leftBarRect.origin.y + _leftBarRect.size.height / 2 - self.sliderKnobHeight / 2, self.sliderKnobWidth , self.sliderKnobHeight);
        
        // Draw Left Part
        
        NSBezierPath* bg = [NSBezierPath bezierPathWithRoundedRect: customKnobRect xRadius: self.sliderKnobWidth  yRadius: self.sliderKnobHeight ];
        
        NSShadow *shadow = [NSShadow new];
        shadow.shadowOffset = CGSizeMake(2, 2);
        
        [[NSColor whiteColor]  setFill];
        [bg fill];
    }
    
//    }

}

//- (void)drawBarInside:(NSRect)rect flipped:(BOOL)flipped
//{
//    if (rect.size.width > rect.size.height) {//水平
//        rect.size.height = kPointMake(8);// 5.0;
//        // Bar radius
//        CGFloat barRadius = rect.size.height / 2.0;
//        // Knob position depending on control min/max value and current control value.
//        CGFloat value = ([self doubleValue]  - [self minValue]) / ([self maxValue] - [self minValue]);
//        // Final Left Part Width
//        CGFloat finalWidth = value * ([[self controlView] frame].size.width - kPointMake(8));
//        
//        // Left Part Rect
//        NSRect leftRect = rect;
//        leftRect.size.width = finalWidth;
//        //    self.leftBarRect = rect;
//        // Draw Left Part
//        NSBezierPath* bg = [NSBezierPath bezierPathWithRoundedRect: rect xRadius: barRadius yRadius: barRadius];
//        [kColorFromRGB(0xffa500) setFill];
//        [bg fill];
//        
//        // Draw Right Part
//        NSBezierPath* active = [NSBezierPath bezierPathWithRoundedRect: leftRect xRadius: barRadius yRadius: barRadius];
//        [kColorFromRGB(0xffa500) setFill];
//        [active fill];
//    }else{//垂直
//        rect.size.width = kPointMake(8);// 5.0;
//        // Bar radius
//        CGFloat barRadius = rect.size.width / 2.0;
//        // Knob position depending on control min/max value and current control value.
//        CGFloat value = ([self doubleValue]  - [self minValue]) / ([self maxValue] - [self minValue]);
//        // Final Left Part Width
//        CGFloat finalWidth = value * ([[self controlView] frame].size.height - kPointMake(8));
//        
//        // Left Part Rect
//        NSRect leftRect = rect;
//        leftRect.size.height = finalWidth;
//        //    self.leftBarRect = rect;
//        // Draw Left Part
//        NSBezierPath* bg = [NSBezierPath bezierPathWithRoundedRect: rect xRadius: barRadius yRadius: barRadius];
//        [kColorFromRGB(0xffa500) setFill];
//        [bg fill];
//        
//        // Draw Right Part
//        NSBezierPath* active = [NSBezierPath bezierPathWithRoundedRect: leftRect xRadius: barRadius yRadius: barRadius];
//        [kColorFromRGB(0xffa500) setFill];
//        [active fill];
//    }
//}
@end
