//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGJSController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface YZGJSController ()<UIWebViewDelegate>
@property (strong, nonatomic)  UIWebView *webView;

@end

@implementation YZGJSController

#pragma mark ************** 懒加载控件
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }
    return _webView;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    [self getData];
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"JS_OC";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"调JS" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark ************** 获取数据
- (void)getData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"my" ofType:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
    [self.webView loadRequest:request];
    
}
#pragma mark ************** JS 调用 OC
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, share就是调用的share方法名
    ESWeakSelf;
    context[@"share"] = ^() {
        
        NSArray *args = [JSContext currentArguments];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"方式二" message:@"这是OC原生的弹出窗" delegate:__weakSelf cancelButtonTitle:@"收到" otherButtonTitles:nil];
        [alertView show];

        for (JSValue *jsVal in args)
        {
            NSLog(@"%@", jsVal.toString);
        }
        
    };
}
#pragma mark ************** OC 调用 JS
- (void)rightAction
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *textJS = @"showAlert('这里是JS中alert弹出的message')";
    [context evaluateScript:textJS];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   
  [self.view addSubview:self.webView];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    self.view.backgroundColor = [UIColor redColor];
    
    
}
@end
