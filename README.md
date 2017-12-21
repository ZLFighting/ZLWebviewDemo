# ZLWebviewDemo
iOS-仿支付宝加载web网页添加进度条

目前市场上APP常会嵌入不少的h5页面，参照支付宝显示web页面的方式, 做了一个导航栏下的加载进度条. 因为项目最低支持iOS7,所以不能使用WKWebView来加载网页, 只能使用 UIWebView, 但是查看 UIWebView的API, 并没有代理或是通知告诉我们webView加载了多少, 所以这个进度条我决定用**模拟进度-俗称假进度**(虚拟的方式来做,就是假装知道加载了多少).

>**实现原理：**
自定义一个UIView的加载进度条，添加到Nav标题栏下方，提供两个方法：(开始加载/结束加载), 在网页加载适当的时候使用.

目前市场上APP常会嵌入不少的h5页面，参照支付宝显示web页面的方式, 做了一个导航栏下的加载进度条. 因为项目最低支持iOS7,所以不能使用WKWebView来加载网页, 只能使用 UIWebView, 但是查看 UIWebView的API, 并没有代理或是通知告诉我们webView加载了多少, 所以这个进度条我决定用**模拟进度-俗称假进度**(虚拟的方式来做,就是假装知道加载了多少).

>**实现原理：**
自定义一个UIView的加载进度条，添加到Nav标题栏下方，提供两个方法：(开始加载/结束加载), 在网页加载适当的时候使用.


##Step1. 自定义加载进度条WebviewProgressLine:

###1、startLoadingAnimation  开始加载
开始加载，先动画模拟一个0.4s的加载，加载宽度为0.6倍屏幕宽度，动画结束，接着0.4s实现，共0.8倍的屏幕宽度。
```
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
```
###2、endLoadingAnimation   结束加载
结束动画，动画模拟1.0倍数的屏幕宽度，实现全部加载完成，并最后隐藏进度条。
```
- (void)endLoadingAnimation {
__weak UIView *weakSelf = self;
[UIView animateWithDuration:0.2 animations:^{
weakSelf.width = UI_View_Width;
} completion:^(BOOL finished) {
weakSelf.hidden = YES;
}];
}
```
###3、自定义线条颜色
```
// 进度条颜色
@property (nonatomic,strong) UIColor *lineColor;
```
```
- (void)setLineColor:(UIColor *)lineColor {
_lineColor = lineColor;

self.backgroundColor = lineColor;
}
```

##Step2. web页面使用进度条方法：

###1、初始化进度条
```
self.progressLine = [[WebviewProgressLine alloc] initWithFrame:CGRectMake(0, 64, UI_View_Width, 3)];
self.progressLine.lineColor = [UIColor blueColor];
[self.view addSubview:self.progressLine];
```
###2、初始化网页并使用代理
懒加载:
```
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
```
获取网址并加载:
```
NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
[self.web loadRequest:[NSURLRequest requestWithURL:url]];
self.web.delegate = self;
```
使用代理UIWebViewDelegate:
```
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
```

这时候测试一下效果图:

![](https://github.com/ZLFighting/ZLWebviewDemo/blob/master/ZLWebviewDemo/nstimer.gif)

可根据自己项目自定义进度条颜色! 希望对您有所帮助!


思路详情请移步技术文章:[iOS-仿支付宝加载web网页添加进度条](http://blog.csdn.net/smilezhangli/article/details/78547959)

您的支持是作为程序媛的我最大的动力, 如果觉得对你有帮助请送个Star吧,谢谢啦

我创建了一个群,
可以在群里互相讨论学习
如果需要可以加群:619216102 
群名称备注: 职业|所在城市|姓名或昵称
