//
//  UIColor+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FMCategory)
#pragma mark 通用方法
/**
 *根据16进制生成UIColor
 *@hexString：16进制颜色
 *@return 返回颜色值
 */
+ (UIColor*)fm_colorWithHexString:(NSString *)hexString;
/**
 @return 随机颜色
 */
+ (UIColor *)fm_randomColor;
/**
 * 解析16进制颜色
 * @completeBlock：解析回调
 */
+(void)fm_colorWithHexStringBackRGBWithHexstring:(NSString *)hexString completeBlock:(void(^)(CGFloat R,CGFloat G,CGFloat B))completeBlock;

@end

NS_ASSUME_NONNULL_END
