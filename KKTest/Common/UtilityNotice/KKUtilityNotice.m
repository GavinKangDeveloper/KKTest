//
//  KKUtilityNotice.m
//  KKTest
//
//  Created by ZhuKangKang on 2020/11/19.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKUtilityNotice.h"

NSTimeInterval const kDefaultMinimumDismissTimeInterval = 1.0;
static void (^_dismissSuccess)(); ///< 目前用于 SVProgressHUD 关闭提示时回调

typedef enum : NSUInteger {
    SVProgressHUDShowTypeInfo = 0,
    SVProgressHUDShowTypeSuccess,
    SVProgressHUDShowTypeError
} SVProgressHUDShowType;

@implementation KKUtilityNotice

+ (void)showAlert:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - SVProgressHUD
+ (void)initSVProgressHUD {
    // 用于 Info、Success、Error 提示
    [SVProgressHUD setMinimumDismissTimeInterval:kDefaultMinimumDismissTimeInterval];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.100 alpha:0.850]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDisappearNotification:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
}

+ (void)didDisappearNotification:(NSNotification *)notify {
    // 用于 Info、Success、Error 提示
    [SVProgressHUD setMinimumDismissTimeInterval:kDefaultMinimumDismissTimeInterval];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
    if (_dismissSuccess) {
        _dismissSuccess();
        
        _dismissSuccess = nil;
    }
}

+ (void)show {
    [SVProgressHUD show];
}

+ (void)showWithStatus:(NSString *)status {
    [SVProgressHUD showWithStatus:status];
}

+ (void)showWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD setDefaultMaskType:maskType];
    [self showWithStatus:status];
}

+ (void)dismiss {
    [SVProgressHUD dismissWithDelay:0.2];
}

+ (void)showInfoWithStatus:(NSString *)status {
    [self showInfoWithStatus:status
                    maskType:SVProgressHUDMaskTypeNone];
}

+ (void)showInfoWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType {
    [self showInfoWithStatus:status
                    maskType:maskType
  minimumDismissTimeInterval:kDefaultMinimumDismissTimeInterval];
}

+ (void)showInfoWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval {
    [self showInfoWithStatus:status
                    maskType:maskType
  minimumDismissTimeInterval:kDefaultMinimumDismissTimeInterval
              dismissSuccess:nil];
}

+ (void)showInfoWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval dismissSuccess:(void (^)(void))dismissSuccess {
    [self showWithType:SVProgressHUDShowTypeInfo
                status:status
              maskType:maskType
minimumDismissTimeInterval:minimumDismissTimeInterval
        dismissSuccess:dismissSuccess];
}

+ (void)showSuccessWithStatus:(NSString *)status {
    [self showSuccessWithStatus:status
                       maskType:SVProgressHUDMaskTypeNone];
}

+ (void)showSuccessWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType {
    [self showSuccessWithStatus:status
                       maskType:maskType
     minimumDismissTimeInterval:kDefaultMinimumDismissTimeInterval];
}

+ (void)showSuccessWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval {
    [self showSuccessWithStatus:status
                       maskType:maskType
     minimumDismissTimeInterval:kDefaultMinimumDismissTimeInterval
                 dismissSuccess:nil];
}

+ (void)showSuccessWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval dismissSuccess:(void (^)(void))dismissSuccess {
    [self showWithType:SVProgressHUDShowTypeSuccess
                status:status
              maskType:maskType
minimumDismissTimeInterval:minimumDismissTimeInterval
        dismissSuccess:dismissSuccess];
}

+ (void)showErrorWithStatus:(NSString *)status {
    [self showErrorWithStatus:status
                     maskType:SVProgressHUDMaskTypeNone];
}

+ (void)showErrorWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType {
    [self showErrorWithStatus:status
                     maskType:maskType
   minimumDismissTimeInterval:kDefaultMinimumDismissTimeInterval];
}

+ (void)showErrorWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval {
    [self showErrorWithStatus:status
                     maskType:maskType
   minimumDismissTimeInterval:kDefaultMinimumDismissTimeInterval
               dismissSuccess:nil];
}

+ (void)showErrorWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval dismissSuccess:(void (^)(void))dismissSuccess {
    [self showWithType:SVProgressHUDShowTypeError
                status:status
              maskType:maskType
minimumDismissTimeInterval:minimumDismissTimeInterval
        dismissSuccess:dismissSuccess];
}

+ (void)showWithType:(SVProgressHUDShowType)showType status:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval dismissSuccess:(void (^)(void))dismissSuccess {
    // 必须延时操作；解决多个 show 无法全显示的情况
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD setDefaultMaskType:maskType];
        [SVProgressHUD setMinimumDismissTimeInterval:minimumDismissTimeInterval];
        
        switch (showType) {
                case SVProgressHUDShowTypeInfo:
                [SVProgressHUD showInfoWithStatus:status];
                break;
                case SVProgressHUDShowTypeSuccess:
                [SVProgressHUD showSuccessWithStatus:status];
                break;
                case SVProgressHUDShowTypeError:
                [SVProgressHUD showErrorWithStatus:status];
                break;
        }
        
        _dismissSuccess = dismissSuccess;
    });
}

@end
