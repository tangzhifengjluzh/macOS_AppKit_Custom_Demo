//
//  HWSpeedSlider.m
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/18.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import "HWSpeedSliderCell.h"


#define SLIDER_DEFAUT_HEIGHT               3.0
#define SLIDER_DEFAUT_BAR_RADIUS           1.5
#define SLIDER_DEFAUT_KNOB_WIDTH           10.0
#define SLIDER_DEFAUT_KNOB_HEIGHT          21.0
@interface HWSpeedSliderCell()

// save leftBar's frame, and use to caculate Knob's frame
@property (assign) NSRect leftBarRect;

@end
@implementation HWSpeedSliderCell

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
    [kColorFromRGB(0xFED22E) setFill];
    [bg fill];
    
    // Draw Right Part
    NSBezierPath* active = [NSBezierPath bezierPathWithRoundedRect: leftRect xRadius: barRadius yRadius: barRadius];
    [kColorFromRGB(0xFED22E) setFill];
    [active fill];
}

- (void)drawKnob:(NSRect)knobRect {
    
//    if (((NSSlider *)self.controlView).highlighted) {
        NSRect customKnobRect = NSMakeRect(_leftBarRect.size.width, _leftBarRect.origin.y + _leftBarRect.size.height / 2 - self.sliderKnobHeight / 2 , self.sliderKnobWidth, self.sliderKnobHeight );
    
        // Draw Left Part
        NSBezierPath* bg = [NSBezierPath bezierPathWithRoundedRect: customKnobRect xRadius: self.sliderKnobWidth  yRadius: self.sliderKnobWidth / 2.0 ];
    NSShadow *shadow = [NSShadow new];
    shadow.shadowOffset = CGSizeMake(2, 2);
    shadow.shadowColor = [NSColor redColor];
        [[NSColor whiteColor]  setFill];
        [bg fill];
//    }

}
@end
