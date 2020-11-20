//
//  UIImage+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (FMCategory)
#pragma mark 通用方法
/**
 图片尺寸修改
 
 @param image 原图片
 @param newSize 新尺寸
 @return 修改后的图片
 */
- (UIImage*)fm_imageScaledToSize:(CGSize)newSize;
/**
 压缩图片至指定尺寸大小

 @param maxLength 最大字节数
 @return 压缩后的图片
 */
- (UIImage *)fm_compressImageToBype:(NSInteger)maxLength;
/**
  给定图片需要宽度按一定比例压缩图片
 @param defineWidth 给定的尺寸
 @return 返回一个新的图片
 */
- (UIImage *)fm_imageCompressScaleWithWidth:(CGFloat)defineWidth;
/** 指定大小和位置的裁剪*/
- (UIImage*)fm_imageScaledToSize:(CGSize)newSize withPoint:(CGPoint)point;
/**
 绘制名字头像
 @param nickName 昵称
 @return 头像图片
 */
+ (UIImage *)fm_createAvatarImageWithNickName:(NSString *)nickName AndBgColor:(UIColor *)bgColor textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize subStringAtIndex:(NSInteger)index;

/** 绘制颜色图片*/
+ (UIImage *)fm_imageWithColor:(UIColor *)color;



@end

NS_ASSUME_NONNULL_END
