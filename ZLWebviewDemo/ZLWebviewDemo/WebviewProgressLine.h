//
//  WebviewProgressLine.h
//  ZLWebviewDemo
//
//  Created by ZL on 2017/9/20.
//  Copyright © 2017年 zhangli. All rights reserved.
//  加载网页时的进度条

#import <UIKit/UIKit.h>

@interface WebviewProgressLine : UIView

// 进度条颜色
@property (nonatomic,strong) UIColor *lineColor;

// 开始加载
- (void)startLoadingAnimation;

// 结束加载
- (void)endLoadingAnimation;

@end
