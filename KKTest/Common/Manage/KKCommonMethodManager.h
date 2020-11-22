//
//  KKCommonMethod.h
//  App
//
//  Created by kangkang zhu on 2018/10/18.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KKLimitsType) {
    KKLimitsTypeAllow = 0,///< 允许使用
    KKLimitsTypeFirstShowMicrophone,///< 第一次弹出 「 麦克风 」 的权限
    KKLimitsTypeOpenSetForMicrophone,///<因为「 麦克风 」的权限跳到系统设置
    KKLimitsTypeFirstShowCamera,///< 第一次弹出 「 相机 」 的权限
    KKLimitsTypeOpenSetForCamera,///<因为「 相机 」的权限跳到系统设置
};

@interface KKCommonMethodManager : NSObject


#pragma mark - 图片视图执行缩放动画效果
+ (void)makeImageViewAnimate:(UIImageView *)imageView;

#pragma mark - 给好评
+ (void)gotoRate;

#pragma mark - 百度坐标转成高德坐标
+ (NSArray *)bd_decryptlon:(double)longitude latitude:(double)lat;

#pragma mark - 转换html转义符
+ (NSString *)filterHtmlTag:(NSString *)html;

#pragma mark - 展示苹果应用内评价视图（仅限iOS10.3以上，10.3以下不做处理）
+ (void)showAppleGoodPraiseView;

#pragma mark - 获取当前屏幕显示的 ViewController
+ (UIViewController *)getCurrentViewController;

#pragma mark - 是否已打开远程消息推送设置,YES:已打开
+ (BOOL)isOpenedNotificationSetting;

#pragma mark - 检测「 相机 」的权限
+ (KKLimitsType)checkCameraLimits;

#pragma mark - 弹出系统 「 相机 」权限, YES :允许
+ (BOOL)showSystemLimitsOfCamera;

#pragma mark -  检测「麦克风」的权限
+ (KKLimitsType)checkMicrophoneLimits;

#pragma mark -  弹出系统 「 麦克风 」权限 ,YES :允许
+ (BOOL)showSystemLimitsOfMicrophone;

#pragma mark - 打开跳转到对应 App 系统的设置界面
+ (void)openSetting;

#pragma mark - 0.2 秒后强制关闭 App
- (void)closeApp;

#pragma mark - 时间相关
//获取本地当前时间
+ (NSDate *)localeDate;

//根据时间字符串和其格式，获取对应的时间 时间字符串格式（默认值为@"yyyy-MM-dd HH:mm"）
+ (NSDate *)dateFromString:(NSString *)dateStr withFormat:(NSString *)format;

//根据时间和其格式，获取对应的时间字符串  时间字符串格式（默认值为@"yyyy-MM-dd HH:mm"）
+ (NSString *)dateToString:(NSDate *)date withFormat:(NSString *)format;

#pragma mark-- 左右震动效果
+(void)shakeWithView:(UIView *)view;

#pragma mark - 上架控制的测试,YES是开发使用
+ (BOOL)checkShouldUpdateWithGotoAPPStore:(BOOL)gotoUpdateAPP showViewController:(UIViewController *)viewController;

#pragma mark - 上架的隐私条例
+ (void)showAppPrivacyRegulationsWithTitle:(NSString *)title content:(NSString *)content viewController:(UIViewController *)viewController;

#pragma mark - 关闭 App
+ (void)closeApp;



@end

