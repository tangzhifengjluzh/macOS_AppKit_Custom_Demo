//
//  HWCheckbox.m
//  macOS_AppKit_Custom_Demo
//
//  Created by xia luzheng on 2019/11/21.
//  Copyright © 2019 xia luzheng. All rights reserved.
//

#import "HWCheckbox.h"

@implementation HWCheckbox
@synthesize color;
@synthesize states;
@synthesize alternateStates;



- (void) awakeFromNib
{
    [self setColor: [NSColor whiteColor]];
    self.states = [NSArray arrayWithObjects:
                   [NSImage imageNamed: @"checkbox-line"],
                   [NSImage imageNamed: @"checkbox"],
                   nil];
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self setColor: [NSColor whiteColor]];
        self.states = [NSArray arrayWithObjects:
                       [NSImage imageNamed: @"checkbox-line"],
                       [NSImage imageNamed: @"checkbox"],
                       nil];
    }
    
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //                    [self setColor: [NSColor whiteColor]];
        
        self.states = [NSArray arrayWithObjects:
                       [NSImage imageNamed: @"checkbox-line"],
                       [NSImage imageNamed: @"checkbox"],
                       nil];
    }
    return self;
}
- (void)drawRect:(NSRect)rect
{
    //    self.wantsLayer = YES;
    //    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    if (_imageTip) {
        NSInteger state = [self state];
        NSLog(@"%ld",state);
        if (state == NSControlStateValueMixed) {
            state = 1;
            
        }
        
        NSImage* img = [states objectAtIndex: state];
        //    if ([[self cell] isHighlighted]) {
        //        img = [alternateStates objectAtIndex: state];
        //    }
        
        //    [[self color] set]; // Sets current drawing color.
        //    NSRect newRect = NSMakeRect(2, 2, 12, 12);
        //    NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect:newRect xRadius:3.0 yRadius:3.0];
        //    [path fill];
        [img drawAtPoint: NSMakePoint(rect.origin.x, rect.origin.y)
                fromRect: rect
               operation: NSCompositingOperationSourceOver
                fraction: 1.0];
    }else{
        
        //    [super drawRect:rect];
        if (self.states == nil) {
            [self setColor: [NSColor whiteColor]];
        }
        
        NSInteger state = [self state];
        if (state == NSMixedState) { state = 2; }
        NSImage* img = kGetImage([self.states objectAtIndex: state]) ;
        if ([[self cell] isHighlighted]) {
            img = kGetImage([self.alternateStates objectAtIndex: state]) ;
        }
        
        float width = 10;
        NSRect newRect = NSMakeRect(2, 5, width, width);
        if (state == NSControlStateValueOff) {
            [kColorFromRGB(0xbbbbbb) set];
            NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect:newRect xRadius:1 yRadius:1];
            [path stroke];
        }else{
            [kColorFromRGB(0xff9800) set];
            NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect:newRect xRadius:1 yRadius:1];
            [path fill];
            [path closePath];
            
            [[NSColor whiteColor] set];
            
            NSBezierPath* pathline = [NSBezierPath bezierPath];
            CGPoint point1 = CGPointMake(1 + newRect.origin.x, 5 + 5 );
            CGPoint point2 = CGPointMake(4 + newRect.origin.x, 2 + 5);
            CGPoint point3 = CGPointMake(8 + newRect.origin.x, 7 + 5);
            
            [pathline moveToPoint:point1];
            [pathline lineToPoint:point2];
            [pathline lineToPoint:point3];
            [pathline stroke];
        }
        NSRect recttext = NSMakeRect(newRect.origin.x + 20, newRect.origin.y, 30, newRect.size.height);
        [self.title drawWithRect:recttext options:0 attributes:@{NSForegroundColorAttributeName:kColorFromRGB(0x101010),NSFontAttributeName:[NSFont systemFontOfSize:12]}];
    }
}

- (BOOL) isFlipped
{
    return NO;
}

@end
