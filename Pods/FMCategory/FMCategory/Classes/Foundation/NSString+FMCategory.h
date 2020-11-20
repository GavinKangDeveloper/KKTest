//
//  NSString+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FMCategory)
#pragma mark 富文本快速创建方法
/**
 根据将首航设置为缩进样式
 @param indent 缩进尺寸
 @return NSAttributedString 富文本内容
 */
- (NSAttributedString *)fm_attributeWithFirstLineIndent:(CGFloat)indent;
/**
 删除线颜色可以自配
 @param font 文本字体大小
 @param lineColor 线颜色
 @return NSAttributedString 富文本内容
 */
- (NSAttributedString *)fm_attributeForDeleteLineWithFont:(UIFont *)font lineColor:(UIColor *)lineColor;

/**
 小数点后字体缩小
 @param font 文本字体大小
 @return NSAttributedString 富文本内容
 */
- (NSAttributedString *)fm_attributeForDecimalScaleWithFont:(UIFont *)font;
#pragma mark 通用方法
/**
 过滤掉指定的正则匹配数据
 @param pattern 过滤规则
 @return NSString 过滤后的字符串
 */
- (NSString *)fm_filterStringWithDropPattern:(NSString *)pattern;
/**
 验证手机号
 @return YesOrNo
 */
- (BOOL)fm_validateMobile;
/**
 json字符串转字典
 @return 返回字典/解析失败返回nil
 */
- (NSDictionary *__nullable)fm_stringToJson;

/**
 *  @brief 对字符串进行base64编码
 *
 *  @param text 要编码的字符串
 *
 *  @return 编码后的字符串
 */
- (NSString *__nullable)fm_encodeBase64;

/**
 *  @brief 对base64格式字符串进行解码
 *
 *  @param text 要解码的base64格式字符串
 *
 *  @return 解码后的字符串
 */
- (NSString *__nullable)fm_decodeBase64;

/**
 *  @brief 对字符串进行md5加密
 *
 *  @param beforeString 加密前的字符串
 *
 *  @return 加密后字符串
 */
- (NSString *__nullable)fm_md5Encryption;
@end

NS_ASSUME_NONNULL_END
