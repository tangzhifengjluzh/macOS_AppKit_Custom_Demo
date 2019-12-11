//
//  AppDelegate.m
//  macOS_AppKit_Custom_Demo
//
//  Created by xia luzheng on 2019/11/21.
//  Copyright © 2019 xia luzheng. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/CAAnimation.h>

@interface AppDelegate ()<HWSegmentedControlDelegate,HWTopBlackViewDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) NSSlider  *sliderOne;
@property (nonatomic, strong) NSSlider  *sliderTwo;
@property (nonatomic, strong) NSSlider  *sliderThree;
@property (nonatomic, strong) NSSlider  *sliderFour;
@property (nonatomic, strong) NSSlider  *sliderFive;
@property (nonatomic, strong) HWDashBoardTemperatureView *dashTemperatur;
@property (nonatomic, strong) NSTextField * lableCurrentTemperature;
@property (nonatomic, strong) HWCenterScrollView  *viewCenter;
@property (nonatomic, strong) NSMutableArray      *arraySliderTextViews;
@property (nonatomic, assign) float                widthCenter;
@property (nonatomic, strong) HWSegmentedControl        *sege;
@property (nonatomic, strong) HWProgressView            *myprogress;
@property (nonatomic, strong) HWTopBlackView  *viewTop;
@property (nonatomic, strong) NSTextField             *labelsave_file_tips;
@property (nonatomic, strong) CAKeyframeAnimation *animationShake;
@property (nonatomic, strong) HWDashBoardPostionView    *dashPostion;
@property (nonatomic, strong) NSTextField               *textCurrentPosition;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    kContentView.wantsLayer = YES;
    kContentView.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
    [self showSlider];
    [self showButton];
    [self showDashBoard];
    [self showCheckBox];
    [self showDragView];
    [self showSege];
    [self showDashLine];
    [self showProgress];
    [self showTopView];
    [self showAnimation];
    [self showShadow];
}

- (void)showShadow{
    HWToolView *view = [HWToolView new];
    [kContentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sliderFive.mas_top).with.offset(-5);
        make.centerX.equalTo(self.sliderFive).with.offset(20);
        make.width.mas_equalTo(@(100));
        make.height.mas_equalTo(@(60));
    }];
}
- (void)showAnimation
{
//    [kContentView addSubview:self.labelsave_file_tips];
    [self.labelsave_file_tips.layer addAnimation:self.animationShake forKey:nil];
}
- (CAKeyframeAnimation *)animationShake
{
    if (_animationShake == nil) {
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
        anim.keyPath = @"position.x";
        anim.duration = 20;
        anim.repeatCount = MAXFLOAT;
        anim.removedOnCompletion = NO;
        //        anim.delegate = self;
        //        anim.fillMode = kCAFillModeBackwards;
        _animationShake = anim;
    }
    _animationShake.values = @[@(self.labelsave_file_tips.frame.origin.x),@(self.window.maxSize.width - self.labelsave_file_tips.frame.size.width),@(self.labelsave_file_tips.frame.origin.x)];//self.window.maxSize.width是label轨道的总长度
    
    return _animationShake;
}
-(NSTextField *)labelsave_file_tips
{
    if (_labelsave_file_tips == nil) {
        _labelsave_file_tips = [[NSTextField alloc]initWithFrame:CGRectMake(20, 10, 200, 15)];
//        _labelsave_file_tips.hidden = YES;
        _labelsave_file_tips.wantsLayer = YES;
//        _labelsave_file_tips.layer.backgroundColor = [NSColor greenColor].CGColor;
        _labelsave_file_tips.stringValue = NSLocalizedString(@"save_file_tips", nil);
        _labelsave_file_tips.font = [NSFont systemFontOfSize:30];
        _labelsave_file_tips.textColor = [NSColor redColor];
        [kContentView addSubview:_labelsave_file_tips];
        [_labelsave_file_tips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.viewCenter);
            make.top.equalTo(self.sege.mas_bottom).with.offset(15);
//            make.width.mas_equalTo(100);
            make.height.mas_equalTo(@(40));
        }];
    }
    _labelsave_file_tips.stringValue = NSLocalizedString(@"save_file_tips", nil);;
    return _labelsave_file_tips;
}
- (void)showTopView
{
    self.viewTop = [[HWTopBlackView alloc]initWithFrame:CGRectMake(0, 0, 600, 48)];
    [kContentView addSubview:self.viewTop];
    self.viewTop.delegate = self;

    [self.viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(kContentView).with.offset(0);
         make.left.equalTo(kContentView).with.offset(0);
         make.right.equalTo(kContentView).with.offset(0);
         make.height.mas_equalTo(@(48));
     }];
    [_viewTop setNeedsDisplay:YES];
}
- (void)showProgress
{
    
}
- (HWProgressView *)myprogress
{
    if (_myprogress == nil) {
        _myprogress = [[HWProgressView alloc]init];
        [kContentView addSubview:_myprogress];
        _myprogress.hidden = YES;
        [_myprogress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.viewCenter.mas_bottom).with.offset(60);
            make.centerX.equalTo(self.viewCenter);
            make.width.mas_equalTo(kProgressWidth);
            make.height.mas_equalTo(30);
        }];
    }
    return _myprogress;
}
- (void)showDashLine
{
    HWDashLineView *line = [HWDashLineView new];
    [kContentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.sege.mas_bottom).with.offset(10);
           make.centerX.equalTo(self.viewCenter);
           make.width.mas_equalTo(@(200));
           make.height.mas_equalTo(@(1));
       }];
}
- (void)showSege
{
    self.sege = [HWSegmentedControl new];
      [kContentView addSubview:self.sege];
      self.sege.delegate = self;
      [self.sege mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self.viewCenter.mas_bottom).with.offset(10);
          make.centerX.equalTo(self.viewCenter);
          make.width.mas_equalTo(@(200));
          make.height.mas_equalTo(@(26));
      }];
      
}
- (void)showDragView
{
    _widthCenter = kSliderTextViewMaginLeft * 2 + kSliderTextViewPadding * 7 + kHWSliderTextFieldViewWidth * 8 + 0;//15
    [kContentView addSubview:self.viewCenter];
    [self.viewCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kContentView).with.offset(5);
        make.top.equalTo(kContentView).with.offset(60);
        make.width.mas_equalTo(@(self.widthCenter));
//        make.bottom.equalTo(kContentView);
        make.height.mas_equalTo(250);

    }];

}
-(HWCenterScrollView *)viewCenter
{
    if (_viewCenter == nil) {
        _viewCenter = [HWCenterScrollView new];
        HWCenterView *view = [HWCenterView new];
        _viewCenter.documentView = view;
        view.frame = CGRectMake(0, 0, _widthCenter , 600);
        self.arraySliderTextViews = [self SliderTextViewSuperView:view withChecks:nil delegate:self];
    }
    return _viewCenter;
}
- (NSMutableArray *)SliderTextViewSuperView:(NSView*)superView withChecks:(NSMutableArray *)checks delegate:(id <HWSliderTextFieldViewDelegate>) delegate
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        //        NSMutableArray *row = [NSMutableArray array];
        for (int j = 1; j <= 8; j++) {
            NSString *title = [NSString stringWithFormat:@"ID:%d",i * 8 + j];
            HWSliderTextFieldView *sliderText1 = [[HWSliderTextFieldView alloc]initWithTag:i * 8 + j + 1000 title:title delegate:delegate];
            
            sliderText1.frame = NSMakeRect(  (j - 1) * kSliderTextViewMaginLeft + kHWSliderTextFieldViewWidth * (j -1),   2 + i * kSliderTextViewPadding  + kHWSliderTextFieldViewHeight * i , kHWSliderTextFieldViewWidth, kHWSliderTextFieldViewHeight);
            [superView addSubview:sliderText1];
            //            [row addObject:sliderText1];
            [array addObject:sliderText1];
            //            NSButton *button = checks[i * 8 + j - 1];
            ////            [sliderText1 bind:@"hidden" toObject:button withKeyPath:@"state" options:0];
            //            [button bind:@"state" toObject:sliderText1 withKeyPath:@"textField.hidden" options:0];
        }
        //        [array addObject:row];
    }
    return array;
}

- (void)showCheckBox
{
    HWCheckbox *itemImage = [HWCheckbox buttonWithTitle:@"开" target:self action:@selector(buttonClick:)];
    itemImage.imageTip = YES;
    [kContentView addSubview:itemImage];
    itemImage.font = [NSFont systemFontOfSize:10];
    [itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.dashTemperatur.mas_top).with.offset(-20);
        make.centerX.equalTo(self.dashTemperatur);
        make.width.mas_equalTo(@(12));
        make.height.mas_equalTo(12);
    }];
    
    HWCheckbox *item = [HWCheckbox buttonWithTitle:@"开" target:self action:@selector(buttonClick:)];
    [kContentView addSubview:item];
    item.font = [NSFont systemFontOfSize:10];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(itemImage.mas_top).with.offset(-20);
        make.centerX.equalTo(self.dashTemperatur);
        make.width.mas_equalTo(@(40));
        make.height.mas_equalTo(12);
    }];
}
- (void)showDashBoard
{
    float temWidth = 50;
    _dashTemperatur = [[HWDashBoardTemperatureView alloc]initWithFrame:CGRectMake(500, 100, 170, 170)];
    [kContentView addSubview:_dashTemperatur];
    [_dashTemperatur mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(kContentView).with.offset(-50);
        make.left.equalTo(kContentView).with.offset(350);
        make.width.mas_equalTo(@(temWidth));
        make.height.mas_equalTo(@(621 * temWidth / 139.0));
    }];
    
    _lableCurrentTemperature= [NSTextField labelWithString:@"当前温度"];
    [kContentView addSubview:_lableCurrentTemperature];
    [_lableCurrentTemperature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dashTemperatur.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.dashTemperatur);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(@(20));
    }];
    
    _dashPostion = [[HWDashBoardPostionView alloc]initWithFrame:CGRectMake(500, 100, 170, 170)];
    [kContentView addSubview:_dashPostion];
    [_dashPostion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dashTemperatur);
        make.left.equalTo(self.dashTemperatur.mas_right).with.offset(0);
        make.width.mas_equalTo(@(200));
        make.height.mas_equalTo(@(200));
    }];
    
    _textCurrentPosition = [NSTextField labelWithString:@"0"];
    [kContentView addSubview:_textCurrentPosition];
    [_textCurrentPosition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dashPostion);
        make.top.equalTo(self.dashPostion.mas_bottom).with.offset(5);
                    make.height.mas_equalTo(@(20));
    }];
}
- (void)showButton
{
    HWImageTitleButton *buttonLeft = [[HWImageTitleButton alloc]initWithFrame:NSZeroRect title:@"点击恢复坐标" image:kGetImage(@"download") target:self action:@selector(buttonClick:) tag:5002 superView:kContentView];
    [buttonLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sliderOne.mas_right).with.offset(20);
        make.bottom.equalTo(self.sliderOne);
        make.width.mas_equalTo(@(160));
        make.height.mas_equalTo(@(36));
    }];
    
    HWImageTitleButton *buttonRight = [[HWImageTitleButton alloc]initWithFrame:NSZeroRect title:@"演示进度条" image:kGetImage(@"download") target:self action:@selector(buttonClick:) tag:5003 superView:kContentView];
    buttonRight.type = HWImageTitleButtonTypeRight;
    [buttonRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buttonLeft);
        make.bottom.equalTo(buttonLeft.mas_top).with.offset(-10);
        make.width.mas_equalTo(@(160));
        make.height.mas_equalTo(@(36));
    }];
    
    HWImageTitleButton *buttonTop = [[HWImageTitleButton alloc]initWithFrame:NSZeroRect title:@"改变仪表盘值" image:kGetImage(@"download") target:self action:@selector(buttonClick:) tag:5004 superView:kContentView];
    buttonTop.type = HWImageTitleButtonTypeTop;
    [buttonTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(buttonLeft);
        make.bottom.equalTo(buttonRight.mas_top).with.offset(-10);
        make.width.mas_equalTo(@(100));
        make.height.mas_equalTo(@(50));
    }];
    
    HWImageTitleButton *buttonBottom = [[HWImageTitleButton alloc]initWithFrame:NSZeroRect title:@"图片在下" image:kGetImage(@"download") target:self action:@selector(buttonClick:) tag:5001 superView:kContentView];
    buttonBottom.type = HWImageTitleButtonTypeBottom;
    [buttonBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(buttonLeft);
        make.bottom.equalTo(buttonTop.mas_top).with.offset(-10);
        make.width.mas_equalTo(@(100));
        make.height.mas_equalTo(@(50));
    }];
    
   HWImageTitleButton *_buttonRun = [HWImageTitleButton buttonWithTitle:@"点击恢复坐标" target:self action:@selector(buttonClick:) tag:5002 superView:kContentView];
    [_buttonRun setValue:@(YES) forKey:@"allowTouch"];

    float width = 100;
    [_buttonRun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(buttonBottom.mas_top).with.offset(-5);
        make.centerX.equalTo(buttonTop);
        make.width.mas_equalTo(@(width));
        make.height.mas_equalTo(@(50));
    }];
}

- (void)showSlider
{
    self.sliderOne = [[NSSlider alloc]initWithFrame:NSMakeRect(20, 20,
                                                               100 , 22)];
    HWSteeringGearSliderCell *slidercell = [HWSteeringGearSliderCell new];
    [self.sliderOne setCell:slidercell];
    self.sliderOne.minValue = 0;
    self.sliderOne.maxValue = 1000;
    self.sliderOne.doubleValue = 500;
    self.sliderOne.action = @selector(sliderClick:);
    self.sliderOne.target = self;
    self.sliderOne.wantsLayer = YES;
    self.sliderOne.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.sliderOne.layer.cornerRadius = 5;
    [self.sliderOne setNeedsDisplay:YES];
    [kContentView addSubview:self.sliderOne];
    
    
    self.sliderTwo = [[NSSlider alloc]initWithFrame:NSMakeRect(20, CGRectGetMinY(self.sliderOne.frame) + 20,
                                                               100, 20)];
    [self.sliderTwo setCell:[HWAngleDeviationSliderCell new]];
    self.sliderTwo.minValue = -100;
    self.sliderTwo.maxValue = 100;
    self.sliderTwo.integerValue = 0;
    self.sliderTwo.action =  @selector(sliderClick:);
    self.sliderTwo.target = self;
    self.sliderTwo.tag = 101;
    self.sliderTwo.layer.backgroundColor = [NSColor redColor].CGColor;
    [self.sliderTwo setNeedsDisplay:YES];
    //    self.slider.numberOfTickMarks = 10;
    //    self.slider.sliderType = NSSliderTypeLinear;
    //    self.slider.tickMarkPosition = NSTickMarkPositionBelow;  //刻度位置
    [kContentView addSubview:self.sliderTwo];
    
    self.sliderThree = [NSSlider new];
    self.sliderThree.minValue = 1;
    self.sliderThree.maxValue = 1000;
    self.sliderThree.doubleValue = 1000;
    self.sliderThree.vertical = NO;
    self.sliderThree.action = @selector(sliderClick:);
    self.sliderThree.target = self;
    [self.sliderThree setCell:[HWToolSliderCell new]];
    //    [NSView initSliderWithFrame:NSZeroRect Min:1 maxValue:1000 stringValue:@"1000" vertical:NO action:@selector(sliderClick:) target:self tag:1001 cell:[HWToolSlider new]];
    [kContentView addSubview:self.sliderThree];
    [self.sliderThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sliderTwo.mas_top).with.offset(-10);
        make.centerX.equalTo(self.sliderTwo);
        make.width.equalTo(self.sliderTwo);
        make.height.mas_equalTo(@(20));
    }];
    
    self.sliderFour = [NSSlider new];
    self.sliderFour.minValue = 1;
    self.sliderFour.maxValue = 1000;
    self.sliderFour.doubleValue = 1000;
    self.sliderFour.vertical = YES;
    self.sliderFour.action = @selector(sliderClick:);
    self.sliderFour.target = self;
    [self.sliderFour setCell:[HWToolSliderCell new]];
    [kContentView addSubview:self.sliderFour];
    [self.sliderFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sliderThree.mas_top).with.offset(-10);
        make.centerX.equalTo(self.sliderTwo);
        make.height.mas_equalTo(@(140));
        make.width.mas_equalTo(@(20));
    }];
    
    self.sliderFive = [NSSlider new];
    self.sliderFive.minValue = 1;
    self.sliderFive.maxValue = 1000;
    self.sliderFive.doubleValue = 1000;
    self.sliderFive.vertical = NO;
    self.sliderFive.action = @selector(sliderClick:);
    self.sliderFive.target = self;
    [self.sliderFive setCell:[HWSpeedSliderCell new]];
    [kContentView addSubview:self.sliderFive];
    [self.sliderFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sliderFour.mas_top).with.offset(-10);
        make.centerX.equalTo(self.sliderTwo);
        make.width.mas_equalTo(@(100));
        make.height.mas_equalTo(@(38));
    }];
    
}

- (void)sliderClick:(NSSlider*)slider
{
    NSLog(@"value = %ld",slider.integerValue);

}

- (void)buttonClick:(NSButton*)sender
{
    int _currentTemperature = arc4random() % 130;
    _dashTemperatur.pro =  _currentTemperature + 10;
    [_dashTemperatur setNeedsDisplay:YES];
    //    _lableCurrentTemperature.stringValue = [NSString stringWithFormat:@"%@%ld℃",HWLocalizedString(@"temperature_value"), _currentTemperature ];
    self.lableCurrentTemperature.stringValue = [NSString stringWithFormat:@"当前温度：%d℃", _currentTemperature];
    if (sender.tag == 5002) {
        [[NSNotificationCenter defaultCenter] postNotificationName:HWRefreshSliderTextFieldNotification object:nil];

    }
    if (sender.tag == 5003) {
                 self.myprogress.pro = 0.1;
           sender.enabled = NO;
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               sender.enabled = YES;
           });
    }
    if (sender.tag == 5004) {
        NSInteger _currentPosition = arc4random() % 1000;
        [_dashPostion progress: _currentPosition / 10];
        //    _lableCurrentPostion.stringValue = [NSString stringWithFormat:@"%@%ld",HWLocalizedString(@"cur_position"), (long)_currentPosition];
        _textCurrentPosition.stringValue = [NSString stringWithFormat:@"当前角度：%ld", _currentPosition];
        
    }
    
}
#pragma mark - HWSegmentedControlDelegate
- (void)selectTitleIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld个item",index);
}

- (void)topBlackViewSelectTitleIndex:(NSInteger)index{
    NSLog(@"顶部点击了第%ld个item",index);

}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
