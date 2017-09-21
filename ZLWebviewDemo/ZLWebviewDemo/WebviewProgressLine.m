//
//  WebviewProgressLine.m
//  ZLWebviewDemo
//
//  Created by ZL on 2017/9/20.
//  Copyright © 2017年 zhangli. All rights reserved.
//

#import "WebviewProgressLine.h"
#import "UIView+ZLExtension.h"

#define UI_View_Width   ([UIScreen mainScreen].bounds.size.width) // 屏幕宽度

@implementation WebviewProgressLine

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    
    self.backgroundColor = lineColor;
}

- (void)startLoadingAnimation {
    self.hidden = NO;
    self.width = 0.0;
    
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.width = UI_View_Width * 0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.width = UI_View_Width * 0.8;
        }];
    }];    
}

- (void)endLoadingAnimation {
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.width = UI_View_Width;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}

@end
