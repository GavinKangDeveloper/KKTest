//
//  KKLoginManger.h
//  App
//
//  Created by kangkang zhu on 2018/10/22.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKLoginManger : NSObject

@property(nonatomic, assign, readonly) BOOL isLogin; ///< 是否登录，YES：已登录


+ (KKLoginManger *)sharedManager;
/**
 退出 账号
 */
+ (void)outLogin;

- (BOOL)isCheckLoginAction:(UIViewController *)vc successAction:(void (^)(BOOL isBindingPhone))successAction;

@end

NS_ASSUME_NONNULL_END
