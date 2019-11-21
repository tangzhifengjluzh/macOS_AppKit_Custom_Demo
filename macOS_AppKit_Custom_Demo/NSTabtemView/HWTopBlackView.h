//
//  HWTopBlackView.h
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/13.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HWTopBlackViewDelegate <NSObject>

- (void)topBlackViewSelectTitleIndex:(NSInteger)index;

@end
@interface HWTopBlackView : NSView
@property (nonatomic, strong) NSArray  *titles;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<HWTopBlackViewDelegate> delegate;

- (void)reFresh;
@end

NS_ASSUME_NONNULL_END
