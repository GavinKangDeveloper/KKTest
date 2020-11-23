//
//  NSString+KKEncryption.h
//  KKTest
//
//  Created by ZhuKangKang on 2020/11/23.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KKEncryption)

/**
 *  MD5加密
 *
 *  @param strSource 需要被加密的明文字符串
 *
 *  @return MD5加密后的密文字符串
 */
+ (NSString *)kk_encryptByMD5:(NSString *)strSource;

/**
 *  SHA1加密
 *
 *  @param strSource 需要被加密的明文字符串
 *
 *  @return SHA1加密后的密文字符串
 */
+ (NSString *)kk_encryptBySHA1:(NSString *)strSource;

/**
 *  AES256加密；返回密文字符串数据
 *
 *  @param strSource 需要被加密的明文字符串
 *  @param strKey    用于加密解密的32字节的密钥字符串（如不是32字节，就无法加密）
 *
 *  @return AES256加密后的密文字符串数据
 */
+ (NSData *)kk_encryptByAES256:(NSString *)strSource withKey:(NSString *)strKey;

/**
 *  AES256加密；返回密文字符串
 *
 *  @param strSource 需要被加密的明文字符串
 *  @param strKey    用于加密解密的32字节的密钥字符串（如不是32字节，就无法加密）
 *
 *  @return AES256加密后的密文字符串
 */
+ (NSString *)kk_encryptByAES256ToString:(NSString *)strSource withKey:(NSString *)strKey;

/**
 *  AES256解密；返回明文字符串数据
 *
 *  @param strSource 需要被解密的密文字符串
 *  @param strKey    用于加密解密的32字节的密钥字符串（如不是32字节，就无法解密）
 *
 *  @return AES256解密后的明文字符串数据
 */
+ (NSData *)kk_decryptByAES256:(NSString *)strSource withKey:(NSString *)strKey;

/**
 *  AES256解密；返回明文字符串
 *
 *  @param strSource 需要被解密的密文字符串
 *  @param strKey    用于加密解密的32字节的密钥字符串（如不是32字节，就无法解密）
 *
 *  @return AES256解密后的明文字符串
 */
+ (NSString *)kk_decryptByAES256ToString:(NSString *)strSource withKey:(NSString *)strKey;

/**
 *  Base64编码
 *
 *  @param strSource 需要被编码的字符串
 *
 *  @return Base64编码后的字符串
 */
+ (NSString *)kk_encodeBase64String:(NSString *)strSource;

/**
 *  Base64解码
 *
 *  @param strSource 需要被解码的字符串
 *
 *  @return Base64解码后的字符串
 */
+ (NSString *)kk_decodeBase64String:(NSString *)strSource;

/**
 *  Base64解码
 *
 *  @param strSource 需要被解码的字符串
 *
 *  @return Base64解码后的字典
 */
+ (NSDictionary *)kk_decodeBase64ForDictionaryWithString:(NSString *)strSource;

/**
 *  URL编码
 *
 *  @param strSource 需要被编码的字符串
 *
 *  @return url-8编码后的字符串
 */
+ (NSString *)kk_encodeURLString:(NSString *)strSource;

/**
 *  URL解码
 *
 *  @param strSource 需要被解码的字符串
 *
 *  @return url-8解码后的字符串
 */
+ (NSString *)kk_decodeURLString:(NSString *)strSource;

@end

NS_ASSUME_NONNULL_END
