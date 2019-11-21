//
//  HWSliderTextFieldView.h
//  macOS_AppKit_Custom_Demo
//
//  Created by xia luzheng on 2019/11/21.
//  Copyright © 2019 xia luzheng. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN
@class HWSliderTextFieldView;

@protocol HWSliderTextFieldViewDelegate <NSObject>

- (void)sliderTextFieldView:(HWSliderTextFieldView*)view andValue:(NSInteger)value withType:(BOOL)angle;

@end
@interface HWSliderTextFieldView : NSView
@property (nonatomic, weak) id <HWSliderTextFieldViewDelegate> delegate;
@property (nonatomic, assign) NSRect  orginFrame;

- (instancetype)initWithTag:(NSInteger)tag title:(NSString*)title delegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
