//
//  KKUtilityNotice.h
//  KKTest
//
//  Created by ZhuKangKang on 2020/11/19.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKUtilityNotice : NSObject

/**
 *  显示弹出框
 *
 *  @param msg 提示内容
 */
+ (void)showAlert:(NSString *)msg;

/**
 *  初始化 SVProgressHUD；设置提示框的背景色和前景色
 */
+ (void)initSVProgressHUD;

/**
 *  显示 Loading; 显示后需要调用 dismiss 手动关闭
 */
+ (void)show;

/**
 *  显示提示框；显示后需要调用 dismiss 手动关闭
 *
 *  @param status 提示内容
 */
+ (void)showWithStatus:(NSString *)status;

/**
 *  显示提示框
 *
 *  @param status   提示内容
 *  @param maskType 遮罩类型；默认为 SVProgressHUDMaskTypeNone，例如：SVProgressHUDMaskTypeClear；避免使用 SVProgressHUDMaskTypeBlack，因为多个 show 时存在问题
 */
+ (void)showWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType;

/**
 *  关闭提示框
 */
+ (void)dismiss;

/**
 显示信息提示框；显示后自动关闭
 
 @param status 提示内容
 */
+ (void)showInfoWithStatus:(NSString *)status;

/**
 根据「遮罩类型」显示信息提示框；显示后自动关闭
 
 @param status 提示内容
 @param maskType 遮罩类型；默认为 SVProgressHUDMaskTypeNone，例如：SVProgressHUDMaskTypeClear
 */
+ (void)showInfoWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType;

/**
 根据「遮罩类型」和「弹窗消失延时（秒）」显示信息提示框；显示后自动关闭
 
 @param status 提示内容
 @param maskType 遮罩类型；默认为 SVProgressHUDMaskTypeNone，例如：SVProgressHUDMaskTypeClear
 @param minimumDismissTimeInterval 弹窗消失延时（秒）
 */
+ (void)showInfoWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval;

/**
 根据「遮罩类型」和「弹窗消失延时（秒）」显示信息提示框；显示后自动关闭，然后执行关闭成功后的回调
 
 @param status 提示内容
 @param maskType 遮罩类型；默认为 SVProgressHUDMaskTypeNone，例如：SVProgressHUDMaskTypeClear
 @param minimumDismissTimeInterval 弹窗消失延时（秒）
 @param dismissSuccess 关闭成功后的回调
 */
+ (void)showInfoWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval dismissSuccess:(void (^)(void))dismissSuccess;

/**
 显示成功提示框；显示后自动关闭
 
 @param status 提示内容
 */
+ (void)showSuccessWithStatus:(NSString *)status;

/**
 根据「遮罩类型」显示成功提示框；显示后自动关闭
 
 @param status 提示内容
 @param maskType 遮罩类型；默认为 SVProgressHUDMaskTypeNone，例如：SVProgressHUDMaskTypeClear
 */
+ (void)showSuccessWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType;

/**
 根据「遮罩类型」和「弹窗消失延时（秒）」显示成功提示框；显示后自动关闭
 
 @param status 提示内容
 @param maskType 遮罩类型；默认为 SVProgressHUDMaskTypeNone，例如：SVProgressHUDMaskTypeClear
 @param minimumDismissTimeInterval 弹窗消失延时（秒）
 */
+ (void)showSuccessWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval;

/**
 根据「遮罩类型」和「弹窗消失延时（秒）」显示成功提示框；显示后自动关闭，然后执行关闭成功后的回调
 
 @param status 提示内容
 @param maskType 遮罩类型；默认为 SVProgressHUDMaskTypeNone，例如：SVProgressHUDMaskTypeClear
 @param minimumDismissTimeInterval 弹窗消失延时（秒）
 @param dismissSuccess 关闭成功后的回调
 */
+ (void)showSuccessWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval dismissSuccess:(void (^)(void))dismissSuccess;

/**
 显示失败提示框；显示后自动关闭
 
 @param status 提示内容
 */
+ (void)showErrorWithStatus:(NSString *)status;

/**
 根据「遮罩类型」和「弹窗消失延时（秒）」显示失败提示框；显示后自动关闭
 
 @param status 提示内容
 @param maskType 遮罩类型；默认为 SVProgressHUDMaskTypeNone，例如：SVProgressHUDMaskTypeClear
 */
+ (void)showErrorWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType;

/**
 根据「遮罩类型」和「弹窗消失延时（秒）」显示失败提示框；显示后自动关闭
 
 @param status 提示内容
 @param maskType 遮罩类型；默认为 SVProgressHUDMaskTypeNone，例如：SVProgressHUDMaskTypeClear
 @param minimumDismissTimeInterval 弹窗消失延时（秒）
 */
+ (void)showErrorWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval;

/**
 根据「遮罩类型」和「弹窗消失延时（秒）」显示失败提示框；显示后自动关闭，然后执行关闭成功后的回调
 
 @param status 提示内容
 @param maskType 遮罩类型；默认为 SVProgressHUDMaskTypeNone，例如：SVProgressHUDMaskTypeClear
 @param minimumDismissTimeInterval 弹窗消失延时（秒）
 @param dismissSuccess 关闭成功后的回调
 */
+ (void)showErrorWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType minimumDismissTimeInterval:(NSTimeInterval)minimumDismissTimeInterval dismissSuccess:(void (^)(void))dismissSuccess;

@end

NS_ASSUME_NONNULL_END
