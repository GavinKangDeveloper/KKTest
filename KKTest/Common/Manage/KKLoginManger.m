//
//  KKLoginManger.m
//  App
//
//  Created by kangkang zhu on 2018/10/22.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKLoginManger.h"

@implementation KKLoginManger

+ (KKLoginManger *)sharedManager {
    static KKLoginManger *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

- (BOOL)isLogin {
    return YES;
}

+ (void)outLogin {
    
    
}

- (BOOL)isCheckLoginAction:(UIViewController *)vc successAction:(void (^)(BOOL isBindingPhone))successAction {
    if (self.isLogin) {
        return YES;
    }
    
    // 「登录」视图控制器
//    KMLoginViewController *loginVC = [KMLoginViewController new];
//    loginVC.successAction = successAction;
//    [vc.navigationController pushViewController:loginVC animated:YES];
    return NO;
}

@end
