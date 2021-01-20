//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"
#import "KKSecondVC.h"
#import <WebKit/WebKit.h>
#import "KKWebView.h"
#import "KKThirdVC.h"

@interface ViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@end

@implementation ViewController

/// 测试 git 添加、推送的流程
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *urlStr = @"http://people.mozilla.org/~rnewman/fennec/mem.html";
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//
//    self.webView.navigationDelegate = self;
//    [self.webView loadRequest:request];
    
    [KKWebView sharedManager].webView;
}
- (IBAction)rightButtonAction:(UIBarButtonItem *)sender {
    KKThirdVC *VC = [[KKThirdVC alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)) {
    NSLog(@"---------");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self gotoSecondVC:NO];
}

- (void)gotoSecondVC:(BOOL)isLoad {
    KKSecondVC * VC = [[KKSecondVC  alloc]init];
    VC.isLoaded = isLoad;
    [self.navigationController pushViewController:VC animated:YES];
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.frame = CGRectMake(0, 0, kkWidthOfMainScreen, kkHeightOfMainScreen);
        [self.view addSubview:_webView];
    }
    return _webView;
}

@end
