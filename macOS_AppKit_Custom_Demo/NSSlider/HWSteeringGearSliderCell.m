//
//  HWSteeringGearSlider.m
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/13.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import "HWSteeringGearSliderCell.h"
@interface HWSteeringGearSliderCell()

// save leftBar's frame, and use to caculate Knob's frame
@property (assign) NSRect leftBarRect;

@end
@implementation HWSteeringGearSliderCell
- (void)drawBarInside:(NSRect)rect flipped:(BOOL)flipped
{
    rect.size.height = 8;// 5.0;
    // Bar radius
    CGFloat barRadius = rect.size.height / 2.0;
    // Knob position depending on control min/max value and current control value.
    CGFloat value = ([self doubleValue]  - [self minValue]) / ([self maxValue] - [self minValue]);
    // Final Left Part Width
    CGFloat finalWidth = value * ([[self controlView] frame].size.width - 8);
    
    // Left Part Rect
    NSRect leftRect = rect;
    leftRect.size.width = finalWidth;
    self.leftBarRect = rect;
    // Draw Left Part
    NSBezierPath* bg = [NSBezierPath bezierPathWithRoundedRect: rect xRadius: barRadius yRadius: barRadius];
    [kColorFromRGB(0x575757) setFill];
    [bg fill];
    
    // Draw Right Part
    NSBezierPath* active = [NSBezierPath bezierPathWithRoundedRect: leftRect xRadius: barRadius yRadius: barRadius];
    [kColorFromRGB(0x575757) setFill];
    [active fill];
}

//- (void)drawKnob:(NSRect)knobRect {
//
////    [super drawKnob:knobRect];
//
//
//        // Draw Left Part
//            NSRect customKnobRect = NSMakeRect(knobRect.origin.x + (knobRect.size.width - 15) / 2.0, knobRect.origin.y + (knobRect.size.height - 15) / 2.0, 15, 15);
//        NSBezierPath* bg = [NSBezierPath bezierPathWithRoundedRect: customKnobRect xRadius: customKnobRect.size.width / 2.0 yRadius: customKnobRect.size.width / 2.0];
//        [[NSColor redColor]  setFill];
//        [bg fill];
//
//
//}
@end
