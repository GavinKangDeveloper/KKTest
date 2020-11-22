//
//  KKCommonMethod.m
//  App
//
//  Created by kangkang zhu on 2018/10/18.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKCommonMethodManager.h"
#import "IQKeyboardManager.h"
#import <StoreKit/StoreKit.h>
#import <UserNotifications/UserNotifications.h>
#import <AVFoundation/AVFoundation.h>
#import "KKDateManager.h"

@implementation KKCommonMethodManager


+ (void)makeImageViewAnimate:(UIImageView *)imageView {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyframeAnimation.values = @[ @(0.1), @(0.6), @(1.1) ];
    keyframeAnimation.keyTimes = @[ @(0.0), @(0.5), @(0.8), @(1.0) ];
    keyframeAnimation.calculationMode = kCAAnimationLinear;
    [imageView.layer addAnimation:keyframeAnimation forKey:@"animate"];
}

//+ (void)gotoRate {
//    NSString *rateURLString = kAPIAppStoreEvaluate;
//    if (kkFuncOverSystemNum(10.0)) {
//        rateURLString = kAPIAppStoreEvaluateForOS11OrLater;
//    }
//    [kApplication openURL:[NSURL URLWithString:rateURLString]];
//}

+ (NSArray *)bd_decryptlon:(double)bd_lon latitude:(double)bd_lat {
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * M_PI);
    double theta = atan2(y, x) - 0.000003 * cos(x * M_PI);
    double gg_lon = z * cos(theta);
    double gg_lat = z * sin(theta);
    NSNumber *numLon = [NSNumber numberWithDouble:gg_lon];
    NSNumber *numLat = [NSNumber numberWithDouble:gg_lat];
    NSArray *array = @[ numLon, numLat ];
    return array;
}

+ (NSString *)filterHtmlTag:(NSString *)html {
    NSString *result = html;
    result = [result stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    result = [result stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    result = [result stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    result = [result stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    result = [result stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    return result;
}

+ (void)showAppleGoodPraiseView {
    if (kkFuncOverSystemNum(10.3)) {
        if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
            [SKStoreReviewController requestReview];
        }
    }
}

#pragma mark - 获取当前屏幕显示的 ViewController
+ (UIViewController *)getCurrentViewController {
    UIViewController *appRootVC = kkApplication.keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
        if ([topVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)topVC;
            return [nav.viewControllers lastObject];
        } else {
            return topVC;
        }
    } else {
        if ([topVC isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabBar = (UITabBarController *)topVC;
            if ([tabBar.selectedViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController *)tabBar.selectedViewController;
                return [nav.viewControllers lastObject];
            } else {
                UIViewController *vc = (UIViewController *)tabBar.selectedViewController;
                return vc;
            }
        } else if ([topVC isKindOfClass:[UINavigationController class]]){
            UINavigationController *nav = (UINavigationController *)topVC;
            return [nav.viewControllers lastObject];
        } else {
            return topVC;
        }
    }
}

+ (BOOL)isOpenedNotificationSetting {
    __block BOOL isOpened = NO;
    // 创建信号量（0 会阻塞线程，执行同步操作；从而保证异步 block 执行完成再 return）
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            isOpened = !(settings.authorizationStatus == UNAuthorizationStatusNotDetermined || settings.authorizationStatus == UNAuthorizationStatusDenied);
            // 发出已完成的信号
            dispatch_semaphore_signal(semaphore);
        }];
    } else {
        isOpened = !([kkApplication currentUserNotificationSettings].types == UIUserNotificationTypeNone);
        // 发出已完成的信号
        dispatch_semaphore_signal(semaphore);
    }
    
    // 等待接收到已完成的信号，再接着执行
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return isOpened;
}

+ (KKLimitsType)checkCameraLimits {
    KKLimitsType type = KKLimitsTypeAllow;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问过用户是否进行授权
            type = KKLimitsTypeFirstShowCamera;
            break;
        case AVAuthorizationStatusRestricted:
            //客户端无权访问介质类型的硬件,用户无法更改客户端的状态
            break;
        case AVAuthorizationStatusDenied:
            //用户已经明确拒绝使用麦克风
            type = KKLimitsTypeOpenSetForCamera;
            break;
        case AVAuthorizationStatusAuthorized:
            //用户已授权
            break;
        default:
            break;
    }
    return type;
}

+ (BOOL)showSystemLimitsOfCamera {
    __block BOOL isAllow = YES;
    // 创建信号量（0 会阻塞线程，执行同步操作；从而保证异步 block 执行完成再 return）
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        isAllow = granted;
        // 发出已完成的信号
        dispatch_semaphore_signal(semaphore);
    }];
    // 等待接收到已完成的信号，再接着执行
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return isAllow;
}

+ (KKLimitsType)checkMicrophoneLimits {
    KKLimitsType type = KKLimitsTypeAllow;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];//麦克风权限
    switch(authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问过用户是否进行授权
            type = KKLimitsTypeFirstShowMicrophone;
            break;
        case AVAuthorizationStatusRestricted:
            //客户端无权访问介质类型的硬件,用户无法更改客户端的状态
            break;
        case AVAuthorizationStatusDenied:
            //用户已经明确拒绝使用麦克风
            type = KKLimitsTypeOpenSetForMicrophone;
            break;
        case AVAuthorizationStatusAuthorized:
            //用户已授权
            break;
        default:
            break;
    }
    return type;
}

+ (BOOL)showSystemLimitsOfMicrophone {
    __block BOOL isAllow = YES;
    // 创建信号量（0 会阻塞线程，执行同步操作；从而保证异步 block 执行完成再 return）
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        isAllow = granted;
        // 发出已完成的信号
        dispatch_semaphore_signal(semaphore);
    }];
    // 等待接收到已完成的信号，再接着执行
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return isAllow;
}

+ (void)openSetting {
    NSString *URLString = UIApplicationOpenSettingsURLString;
    if (@available(iOS 10.0, *)) {
        [kkApplication openURL:[NSURL URLWithString:URLString]
                      options:@{}
            completionHandler:nil];
    } else {
        [kkApplication openURL:[NSURL URLWithString:URLString]];
    }
}

- (void)closeApp {
    [[UIApplication sharedApplication] performSelector:@selector
     (suspend)];
    [NSThread sleepForTimeInterval:0.2];
    exit(0);
}

+ (NSDate *)localeDate {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    return [date dateByAddingTimeInterval:interval];
}

+ (NSDate *)dateFromString:(NSString *)dateStr withFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    formatter.dateFormat = format ?: @"yyyy-MM-dd HH:mm";
    return [formatter dateFromString:dateStr];
}

+ (NSString *)dateToString:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    formatter.dateFormat = format ?: @"yyyy-MM-dd HH:mm";
    return [formatter stringFromDate:date];
}

+ (void)shakeWithView:(UIView *)view {
    CGRect frame = view.frame;
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef shakePath = CGPathCreateMutable();
    CGPathMoveToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2);
    int index;
    for (index = 3; index >=0; --index) {
        CGPathAddLineToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2 - frame.size.width * 0.02f * index, frame.origin.y+frame.size.height/2);
        CGPathAddLineToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2 + frame.size.width * 0.02f * index, frame.origin.y+frame.size.height/2);
    }
    CGPathCloseSubpath(shakePath);
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = 0.8f;
    shakeAnimation.removedOnCompletion = YES;
    [view.layer addAnimation:shakeAnimation forKey:nil];
    CFRelease(shakePath);
}

//+ (BOOL)checkShouldUpdateWithGotoAPPStore:(BOOL)gotoUpdateAPP showViewController:(UIViewController *)viewController {
//
//    User_Default_SetObjectForKey(kkAppVersion, kUserDefaults_localVersion);
//    NSString *localVersion = [kAppVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//    if (localVersion.length==2) {
//        localVersion  = [localVersion stringByAppendingString:@"0"];
//    }else if (localVersion.length==1){
//        localVersion  = [localVersion stringByAppendingString:@"00"];
//    }
//
//    NSString *appStoreVersion = User_Default_ObjectForKey(kUserDefaults_AppStoreVersion);
//    if ([localVersion floatValue] == [appStoreVersion floatValue]) {
//        return NO;
//    }
//
//    //3从网络获取appStore版本号
//    NSError *error;
//    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",kAppID]]] returningResponse:nil error:nil];
//    if (response == nil) {
//        return YES;
//    }
//    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    NSArray *array = appInfoDic[@"results"];
//    if (array.count == 0) {
//        return YES;
//    }
//
//    NSDictionary *dic = array[0];
//    appStoreVersion = dic[@"version"];
//    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//    if (appStoreVersion.length==2) {
//        appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
//    }else if (appStoreVersion.length==1){
//        appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
//    }
//    User_Default_SetObjectForKey(appStoreVersion, kUserDefaults_AppStoreVersion)
//    //4当前版本号小于商店版本号,就更新
//    if([localVersion floatValue] < [appStoreVersion floatValue]){
////        Show_Two_Button(@"新版本内容更精彩，请更新");
//        if (gotoUpdateAPP) {
//            [[KKCommonMethodManager alloc] onUpdateDataResult:dic
//                                           showViewController:viewController];
//        }
//        return YES;
//    }
//    return NO;
//}

//- (void)onUpdateDataResult:(NSDictionary *)dic showViewController:(UIViewController *)viewController {
//    NSString *newVersionStr = funcGetSafeStringFromDic(dic, @"version");
//    // 是否进行显示提示框（新版本提示）
//    if ([self isShowAlertViewWithNewVersionString:newVersionStr]) {
//        // 新版本发布时间；例如：2018-05-23T02:09:16Z，少了 8 小时
//        NSString *newVersionReleaseDateStr = [[funcGetSafeStringFromDic(dic, @"currentVersionReleaseDate") stringByReplacingOccurrencesOfString:@"T" withString:@" "]  stringByReplacingOccurrencesOfString:@"Z" withString:@""];
//        NSDate *newVersionReleaseDate = [KKDateManager dateFromString:newVersionReleaseDateStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
//        if (newVersionReleaseDate) {
//            // 新增 8 小时
//            newVersionReleaseDate = [[NSDate date] initWithTimeInterval:8 * 60 * 60 sinceDate:newVersionReleaseDate];
//            NSArray *arrMonthAndDay = [newVersionReleaseDate kk_monthAndDayBetweenTwoDates:[KKDateManager localeDate]];
//            if ([arrMonthAndDay[0] integerValue] > 0 || [arrMonthAndDay[1] integerValue] > 0) {
//                // 1 天后才提醒有新版本，解决「App 内提醒存在新版本，点击跳转到 App Store 没有显示对应更新状态的按钮」问题
//                NSString *releaseNote = funcGetSafeStringFromDic(dic, @"releaseNotes");
//                NSString *newVersionTip = [NSString stringWithFormat:@"有可用的更新版本:%@", newVersionStr];
//
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:newVersionTip
//                                                                                         message:releaseNote
//                                                                                  preferredStyle:UIAlertControllerStyleAlert];
//
//                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"立即开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", kAppID]];
//                    [[UIApplication sharedApplication] openURL:url];
//                }];
//                [alertController addAction:okAction];
//                [viewController presentViewController:alertController animated:YES completion:nil];
//            }
//        }
//    }
//}
//
//- (BOOL)isShowAlertViewWithNewVersionString:(NSString *)newVersionString {
//    // 如果 App Store 上版本高于当前版本，就显示提示框
//    double newVersionNum = [self correctedVersionNumFromVersionString:newVersionString];
//    double localVersionNum = [self correctedVersionNumFromVersionString:kAppVersion];
//    return newVersionNum > localVersionNum;
//}
//
//- (double)correctedVersionNumFromVersionString:(NSString *)versionString {
//    // 转换规则：4.4 -> 4.04, 4.3.1 -> 4.0301, 10.10.1 -> 10.1001, 10.9.10 -> 10.0910
//    NSArray *arrNum = [versionString componentsSeparatedByString:@"."];
//    if (arrNum.count == 2) {
//        versionString = [NSString stringWithFormat:@"%@.%02zd", arrNum[0], [arrNum[1] integerValue]];
//    } else {
//        versionString = [NSString stringWithFormat:@"%@.%02zd%02zd", arrNum[0], [arrNum[1] integerValue], [arrNum[2] integerValue]];
//    }
//    return [versionString doubleValue];
//}
//
//+ (void)showAppPrivacyRegulationsWithTitle:(NSString *)title content:(NSString *)content viewController:(UIViewController *)viewController {
//
//    NSString *clauseStr = User_Default_ObjectForKey(kUserDefaults_AppPrivacyRegulations);
//    if (![clauseStr isEqualToString:@"1"]) {
//        UIAlertController * clauseAlertV = [UIAlertController alertControllerWithTitle:title
//                                                                               message:content
//                                                                        preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction * detailAction = [UIAlertAction actionWithTitle:@"以后再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        }];
//        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            User_Default_SetObjectForKey(@"1",kUserDefaults_AppPrivacyRegulations)
//        }];
//        [clauseAlertV addAction:detailAction];
//        [clauseAlertV addAction:cancelAction];
//        [viewController presentViewController:clauseAlertV animated:YES completion:nil];
//    }
//}

+ (void)closeApp {
    [[UIApplication sharedApplication] performSelector:@selector
     (suspend)];
    [NSThread sleepForTimeInterval:0.5];
    exit(0);
}


@end
