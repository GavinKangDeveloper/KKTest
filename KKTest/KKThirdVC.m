//
//  KKThirdVC.m
//  KKTest
//
//  Created by ZhuKangKang on 2021/1/18.
//  Copyright © 2021 ZKKMBP. All rights reserved.
//

#import "KKThirdVC.h"
#import "KKWebView.h"

@interface KKThirdVC ()

@end

@implementation KKThirdVC

#pragma mark - LifeCycle
- (void)dealloc {
    [self removeNotificationObserver];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据和变量
    [self initData];
    
    //设置导航栏
    [self setupNavBar];
    
    //设置view
    [self setupView];
   
    //请求数据
    [self requestData];
    
    //添加通知
    [self addNotificationObserver];
}

#pragma mark - 初始化数据和变量
- (void)initData {
    
}

#pragma mark - View
- (void)setupNavBar {
    
}

- (void)setupView {
    self.view.backgroundColor = [UIColor yellowColor];
    NSString *urlStr = @"https://www.baidu.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    [KKWebView sharedManager].webView.frame = CGRectMake(0, 0, kkWidthOfMainScreen, kkHeightOfMainScreen);
    [self.view addSubview:[KKWebView sharedManager].webView];
    [[KKWebView sharedManager].webView loadRequest:request];
}

#pragma mark - Network
- (void)requestData {
    
}

#pragma mark- Delegate
#pragma mark UITableDatasource & UITableviewDelegate


#pragma mark - Private


#pragma mark - Event


#pragma mark - Public


#pragma mark - NSNotificationCenter
- (void)addNotificationObserver {
    
}

- (void)removeNotificationObserver {
    
}

#pragma mark - Setter


#pragma mark - Getter


#pragma mark - MemoryWarning
- (void)didReceiveMemoryWarning {
    
}

@end
