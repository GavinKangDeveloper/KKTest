//
//  KKSecondVC.m
//  KKTest
//
//  Created by ZKKMBP on 2020/7/22.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKSecondVC.h"
#import <NSTimer+KKWeakTimer.h>
#import <WebKit/WebKit.h>
#import "KKWebView.h"
#import "KKThirdVC.h"

@interface KKSecondVC ()
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation KKSecondVC

- (void)dealloc {
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"--KKSecondVC-------viewWillAppear--");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"--KKSecondVC------viewWillDisappear---");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    self.navigationController.title = @"TWO";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"下一页"
                                                             style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(gotoPage)];
    self.navigationController.navigationItem.rightBarButtonItem = item;
    
    NSString *urlStr = @"http://www.dianzhuan666.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    if (self.isLoaded) {
        [[KKWebView sharedManager].webView loadRequest:request];
    } else {
        [self.webView loadRequest:request];
    }
}

- (void)gotoPage {
    KKThirdVC *VC = [[KKThirdVC alloc] init];
    
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
