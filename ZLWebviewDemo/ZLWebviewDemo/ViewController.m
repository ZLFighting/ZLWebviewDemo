//
//  ViewController.m
//  ZLWebviewDemo
//
//  Created by ZL on 2017/9/20.
//  Copyright © 2017年 zhangli. All rights reserved.
//

#import "ViewController.h"
#import "WebviewProgressLine.h"
#import "UIView+ZLExtension.h"

#define UI_View_Width   ([UIScreen mainScreen].bounds.size.width) // 屏幕宽度

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic,strong) UIWebView  *web;

@property (nonatomic,strong) WebviewProgressLine  *progressLine;

@end

@implementation ViewController

#pragma mark - 懒加载

- (UIWebView *)web {
    if (!_web) {
        UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
        // UIWebView加载过程中，在页面没有加载完毕前，会显示一片空白。为解决这个问题，方法如下：让UIWebView背景透明。
        web.backgroundColor = [UIColor clearColor];
        web.opaque = NO;
        [web setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"webbg.png"]]];
        [self.view addSubview:web];
        
        _web = web;
    }
    return _web;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.progressLine = [[WebviewProgressLine alloc] initWithFrame:CGRectMake(0, 64, UI_View_Width, 3)];
    self.progressLine.lineColor = [UIColor blueColor];
    [self.view addSubview:self.progressLine];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    [self.web loadRequest:[NSURLRequest requestWithURL:url]];
    self.web.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

// 网页开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [MBProgressHUD showMessage:@"稍等,玩命加载中"];
    
    [self.progressLine startLoadingAnimation];
}

// 网页完成加载
- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [MBProgressHUD hideHUD];
    
    [self.progressLine endLoadingAnimation];
}

// 网页加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [MBProgressHUD hideHUD];
    
    [self.progressLine endLoadingAnimation];
}


@end
