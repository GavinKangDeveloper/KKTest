//
//  UILabel+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FMCategory)
#pragma mark 设置富文本字体属性
/*!
 *  @brief 设置属性
 *
 *  @param attributes 属性
 *  @param range      范围
 */
- (void)fm_addAttributes:(NSDictionary *)attributes range:(NSRange)range;
/*!
 *  @brief 设置字体颜色
 *
 *  @param textColor 字体颜色
 *  @param range     范围
 */
- (void)fm_setTextColor:(UIColor *)textColor range:(NSRange)range;
/*!
 *  @brief 设置字体大小
 *
 *  @param font  字号
 *  @param range 范围
 */
- (void)fm_setFont:(UIFont *)font range:(NSRange)range;
/*!
 *  @brief 设置行距
 *
 *  @param space 行距
 */
- (void)fm_setLineSpace:(CGFloat)space;
/*!
 *  @brief 设置行距
 *
 *  @param space 行距
 *  @param range 范围
 */
- (void)fm_setLineSpace:(CGFloat)space range:(NSRange)range;

/*!
 *  @brief 设置字间距
 *
 *  @param space 字间距
 */
- (void)fm_setWordSpace:(CGFloat)space range:(NSRange)range;

/*!
 *  @brief 设置基线偏移量
 *
 *  @param space 字间距
 */
- (void)fm_setBaselineOffset:(CGFloat)offset range:(NSRange)range;

/*!
 *  @brief 根据普通文本获取label高度
 *
 *  @return 高度
 */
- (CGFloat)fm_contentHeight NS_AVAILABLE_IOS(7_0);
/**
 @return label的行数
 */
- (NSUInteger)fm_lineNumbers;

@end

NS_ASSUME_NONNULL_END
