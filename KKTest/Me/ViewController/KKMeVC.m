//
//  KKMeVC.m
//  KKTest
//
//  Created by ZhuKangKang on 2020/11/23.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKMeVC.h"

@interface KKMeVC ()

@end

@implementation KKMeVC

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
    
    //设置导航栏
    [self setupNavBar];
    
    //设置view
    [self setupView];
   
    //请求数据
    [self requestData];
    
    //添加通知
    [self addNotificationObserver];
}

#pragma mark - View
- (void)setupNavBar {
    
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)setupView {
    
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
