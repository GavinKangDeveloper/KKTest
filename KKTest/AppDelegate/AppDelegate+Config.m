//
//  AppDelegate+Config.m
//  KKTest
//
//  Created by ZhuKangKang on 2020/11/23.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "AppDelegate+Config.h"
#import <AvoidCrash.h>
#import "KKUtilityNotice.h"

#import "KKBaseTabBarController.h"

@implementation AppDelegate (Config)

- (void)initConfigureWithOptions:(NSDictionary *)launchOptions {

    // 防崩溃
    [AvoidCrash becomeEffective];
    
    // 初始化 SVProgressHUD；设置提示框的背景色和前景色
    [KKUtilityNotice initSVProgressHUD];
    
    // 解决 button 频繁点击的问题
    [UIControl kk_exchangeClickMethod];
    
    // 初始化 home
//    [self creatTabBarController];
}

- (void)creatTabBarController {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    KKBaseTabBarController * tabBar = [[KKBaseTabBarController alloc] init];
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
}

@end
