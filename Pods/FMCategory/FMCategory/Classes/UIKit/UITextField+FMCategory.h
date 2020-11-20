//
//  UITextField+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (FMCategory)
#pragma mark 通用方法
/**
 *  设置UITextFieldPlaceholder字体大小和颜色
 *
 *  @param font             字体
 *  @param placeholderColor 颜色
 */
- (void)fm_setPlaceholderWithFont:(UIFont *)font color:(UIColor *)placeholderColor;
@end

NS_ASSUME_NONNULL_END
