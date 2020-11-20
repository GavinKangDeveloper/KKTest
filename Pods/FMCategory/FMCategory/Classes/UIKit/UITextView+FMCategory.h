//
//  UITextView+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (FMCategory)
#pragma mark 通用方法
/**
 设置行距
 @space：行距宽度
 */
- (void)fm_setLineSpace:(CGFloat)space;
/**
 设置局部颜色
 @textColor：字体颜色
 @range：内容
 */
- (void)fm_setTextColor:(UIColor *)textColor range:(NSRange)range;

/**
 根据textView的当前的text以及width计算出显示所有文字的高度

 @return 高度
 */
- (CGFloat)fm_HeightToThisFit;
@end

NS_ASSUME_NONNULL_END
