//
//  HWImageTitleButton.m
//  Bus Servo Control
//
//  Created by xia luzheng on 2019/11/15.
//  Copyright © 2019 HiWonder. All rights reserved.
//

#import "HWImageTitleButton.h"
@interface HWImageTitleButton()
@property (nonatomic, copy) NSString  *myTitle;
@property (nonatomic, strong) NSImage  *myImage;
@end
@implementation HWImageTitleButton

- (instancetype)initWithFrame:(NSRect)frameRect title:(NSString *)title image:(NSImage *)image target:(id)target action:(SEL)action tag:(NSInteger)tag superView:(NSView *)superView
{
    self = [super init];
    if (self) {
        self.top = 4;
        self.myTitle = title;
        self.myImage = image;
        self.target = target;
        self.action = action;
        self.tag = tag;
        [self setBordered:NO];
        self.wantsLayer = YES;
        self.layer.cornerRadius = 4;
        self.bezelColor = [NSColor redColor];
        [self setValue:@(YES) forKey:@"allowTouch"];
        [self setValue:@(YES) forKey:@"imageButton"];
        self.layer.backgroundColor = kColorFromRGB(0xFFA500).CGColor;
        if (superView) {
            [superView addSubview:self];
        }
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    self.top = self.frame.size.height / 5.0;
    // Drawing code here.
    NSSize sizetitle = [self.myTitle  boundingRectWithSize:NSMakeSize(self.frame.size.width, self.frame.size.height) options:0 attributes:@{NSFontAttributeName:[NSFont systemFontOfSize:14]} context:nil].size;
    NSSize sizeimage1 = self.myImage.size;
    
    float imageheight =  (self.frame.size.height - _top * 2) * sizeimage1.height / sizeimage1.width;
    float imagewidth =  (self.frame.size.height - _top * 2) * sizeimage1.width / sizeimage1.height;

    NSSize sizeimage = CGSizeMake(imagewidth , imageheight);// 根据原始图片大小计算
    float magin = (self.frame.size.width - sizetitle.width - sizeimage.width) / 7.0;
    
    
    switch (_type) {
    case HWImageTitleButtonTypeTop:
    case HWImageTitleButtonTypeBottom:
        {
            _top = 3;
             imageheight =  (self.frame.size.height - _top * 3 - sizetitle.height) * sizeimage1.height / sizeimage1.width;
             imagewidth =  (self.frame.size.height - _top * 3 - sizetitle.height) * sizeimage1.width / sizeimage1.height;
            sizeimage = CGSizeMake(imagewidth , imageheight);// 根据原始图片大小计算
            magin = 3;//(self.frame.size.width - sizetitle.width - sizeimage.width) / 7.0;
        }
            break;
            
        default:
            break;
    }
    
    
    NSRect rectImage = CGRectMake(magin * 3, _top, sizeimage.width, sizeimage.height);
    NSRect rectTitle = CGRectMake(magin * 4 + sizeimage.width, (self.frame.size.height - sizetitle.height) / 2.0 - 1, sizetitle.width, sizetitle.height);
    switch (_type) {
        case HWImageTitleButtonTypeLeft:
        {
            
        }
            break;
        case HWImageTitleButtonTypeTop:
        {
            rectImage = CGRectMake((self.frame.size.width - sizeimage.width ) / 2.0, _top, sizeimage.width, sizeimage.height);
            rectTitle = CGRectMake((self.frame.size.width - sizetitle.width ) / 2.0, _top * 2 + sizeimage.height, sizetitle.width, sizetitle.height);
        }
            break;
        case HWImageTitleButtonTypeRight:
        {
            rectImage = CGRectMake(self.frame.size.width -  magin * 3 - sizeimage.width, _top, sizeimage.width, sizeimage.height);
            rectTitle = CGRectMake(magin * 3, (self.frame.size.height - sizetitle.height) / 2.0 - 1, sizetitle.width, sizetitle.height);
        }
            break;
        case HWImageTitleButtonTypeBottom:
        {
            rectImage = CGRectMake((self.frame.size.width - sizeimage.width ) / 2.0, _top * 2 + sizetitle.height , sizeimage.width, sizeimage.height);
            rectTitle = CGRectMake((self.frame.size.width - sizetitle.width ) / 2.0, _top , sizetitle.width, sizetitle.height);
        }
            break;
            
        default:
            break;
    }
    [self.myImage drawInRect:rectImage];
    [self.myTitle drawInRect:rectTitle withAttributes:@{NSForegroundColorAttributeName:[NSColor whiteColor],NSFontAttributeName:[NSFont systemFontOfSize:14]}];
}


+ (HWImageTitleButton *)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action tag:(NSInteger)tag superView:(NSView *)superView
{
    NSButton *button = [NSButton buttonWithTitle:title target:target action:action];
    button.tag = tag;
    [button setBordered:NO];
    button.wantsLayer = YES;
    button.layer.cornerRadius = 4;
    button.bezelColor = [NSColor redColor];
    button.layer.backgroundColor = [NSColor whiteColor].CGColor;
    if (superView) {
        [superView addSubview:button];
    }
    //    NSMutableParagraphStyle *pghStyle = [[NSMutableParagraphStyle alloc] init];
    //    pghStyle.alignment = NSTextAlignmentCenter;
    //    NSDictionary *dicAtt = @{ NSParagraphStyleAttributeName: pghStyle};
    //    // 创建NSAttributedString赋值给NSButton的attributedTitle属性
    //    _buttonUpdateAction.attributedTitle = [[NSAttributedString alloc] initWithString:HWLocalizedString(@"update_action") attributes:dicAtt];
    return button;
}
@end
