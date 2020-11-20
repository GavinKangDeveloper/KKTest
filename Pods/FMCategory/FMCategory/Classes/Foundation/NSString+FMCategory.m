//
//  NSString+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "NSString+FMCategory.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (FMCategory)
- (NSAttributedString *)fm_attributeWithFirstLineIndent:(CGFloat)indent
{
    if (!self || self.length <= 0) return nil;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.firstLineHeadIndent = indent;
    paragraphStyle.lineSpacing = 3;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    return [attributedString copy];
}
- (NSAttributedString *)fm_attributeForDeleteLineWithFont:(UIFont *)font lineColor:(UIColor *)lineColor
{
    if (!self || self.length <= 0) return nil;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    
    [attributedString addAttributes:@{NSFontAttributeName               : font,
                                      NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                                      NSBaselineOffsetAttributeName     : @(0.5),
                                      NSStrikethroughColorAttributeName : lineColor
                                      } range:NSMakeRange(0, self.length)];
    
    return [attributedString copy];
}
- (NSAttributedString *)fm_attributeForDecimalScaleWithFont:(UIFont *)font
{
    if (!self || self.length <= 0) return nil;
    NSArray *priceArray = [self componentsSeparatedByString:@"."];
    NSRange range = NSMakeRange(0, 0);
    if (priceArray.count == 2)
    {
        NSString *priceStr1 = priceArray[0];
        NSString *priceStr2 = priceArray[1];
        range = NSMakeRange(priceStr1.length + 1, priceStr2.length);
    }
    return [self attributeWithFont:font scaleRange:range scale:0.8];
}
- (NSString *)fm_filterStringWithDropPattern:(NSString *)pattern
{
    if (!self || self.length <= 0) return nil;
    NSString *filterStr = nil;
    //创建一个正则表达式对象，存储匹配规则
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    if (regex != nil) {
        //用该方法解析出所有
        NSArray* array = [regex matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
        NSMutableArray* stringArray = [[NSMutableArray alloc] init];
        
        //当解析出的数组至少有一个对象时，即原文本中存在至少一个符合规则的字段
        if (array.count != 0) {
            for (NSTextCheckingResult* result in array) {
                //从NSTextCheckingResult类中取出range属性
                NSRange range = result.range;
                //从原文本中将字段取出并存入一个NSMutableArray中
                [stringArray addObject:[self substringWithRange:range]];
            }
        }
        filterStr = [stringArray componentsJoinedByString:@""];
    }
    return filterStr;
}
#pragma mark privte
- (NSAttributedString *)attributeWithFont:(UIFont *)font scaleRange:(NSRange)range scale:(CGFloat)scale
{
    if (scale > 1) {
        scale = 1;
    }
    if (scale < 0.5) {
        scale = 0.5;
    }
    NSMutableAttributedString *attrbutedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attrbutedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    UIFont *newFont = [UIFont fontWithName:font.fontName size:font.pointSize*scale];
    [attrbutedString addAttribute:NSFontAttributeName value:newFont range:range];
    return [attrbutedString copy];
}

- (BOOL)fm_validateMobile
{
    if (self.length != 11)
    {
        return NO;
    }
    else
    {
        return YES;
    }
    
#if 0  // 暂时不做严格限制
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
#endif
    
}

- (NSDictionary *)fm_stringToJson
{
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark --- Base64编码字符串
- (NSString *)fm_encodeBase64
{
    NSData *textData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodeString = [textData base64EncodedStringWithOptions:0];
    return encodeString;
}

#pragma mark --- Base64解码字符串
- (NSString *)fm_decodeBase64
{
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *decodeString = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    return decodeString;
}

#pragma mark --- md5加密
- (NSString *)fm_md5Encryption
{
    const char *cStr = [self UTF8String];//转换成utf-8
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5( cStr, (int)strlen(cStr), result);
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ].lowercaseString;
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}


@end
