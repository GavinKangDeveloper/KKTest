//
//  NSString+KKEncryption.m
//  KKTest
//
//  Created by ZhuKangKang on 2020/11/23.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "NSString+KKEncryption.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

typedef NS_ENUM(NSInteger, KKEncryptionType) {
    KKEncryptionTypeMD5 = 0,
    KKEncryptionTypeSHA1 ,
};

@implementation NSString (KKEncryption)

+ (NSString *)kk_encryptByMD5:(NSString *)strSource {
    NSString *strResult = nil;
    if (strSource && strSource.length > 0) {
        strResult = [self encrypt:strSource KKEncryptionType:KKEncryptionTypeMD5];
    }
    return strResult;
}

+ (NSString *)kk_encryptBySHA1:(NSString *)strSource {
    NSString *strResult = nil;
    if (strSource && strSource.length > 0) {
        strResult = [self encrypt:strSource KKEncryptionType:KKEncryptionTypeSHA1];
    }
    return strResult;
}

+ (NSData *)kk_encryptByAES256:(NSString *)strSource withKey:(NSString *)strKey {
    NSData *dataResult = nil;
    if (strSource && strSource.length > 0 && strKey && strKey.length == 32) {
        dataResult = [strSource dataUsingEncoding:NSUTF8StringEncoding]; // 编码
        dataResult = [self operationByAES256:dataResult
                                     withKey:strKey
                                   isEncrypt:YES];
    }
    return dataResult;
}

+ (NSString *)kk_encryptByAES256ToString:(NSString *)strSource withKey:(NSString *)strKey {
    NSData *dataResult = [self kk_encryptByAES256:strSource withKey:strKey];
    return [dataResult base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

+ (NSData *)kk_decryptByAES256:(NSString *)strSource withKey:(NSString *)strKey {
    NSData *dataResult = nil;
    if (strSource && strSource.length > 0 && strKey && strKey.length == 32) {
        dataResult = [[NSData alloc] initWithBase64EncodedString:strSource
                                                         options:NSDataBase64DecodingIgnoreUnknownCharacters]; // 解码
        dataResult = [self operationByAES256:dataResult
                                     withKey:strKey
                                   isEncrypt:NO];
    }
    return dataResult;
}

+ (NSString *)kk_decryptByAES256ToString:(NSString *)strSource withKey:(NSString *)strKey {
    NSData *dataResult = [self kk_decryptByAES256:strSource withKey:strKey];
    return [[NSString alloc] initWithData:dataResult encoding:NSUTF8StringEncoding];
}

+ (NSString *)kk_encodeBase64String:(NSString *)strSource {
    NSData *data = [strSource dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

+ (NSString *)kk_decodeBase64String:(NSString *)strSource {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:strSource
                                                       options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)kk_decodeBase64ForDictionaryWithString:(NSString *)strSource {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:strSource
                                                       options: NSDataBase64DecodingIgnoreUnknownCharacters];
    NSDictionary *dicJSON;
    if (data) {
        NSError *error;
        dicJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        if (error) {
            dicJSON = nil;
        }
    }
    return dicJSON;
}

#pragma mark - Private Method
/**
 *  KKEncryptionTypeMD5或KKEncryptionTypeSHA1加密
 *
 *  @param strSource   需要被加密的明文字符串
 *  @param KKEncryptionType 加密类型；例如：KKEncryptionTypeMD5、KKEncryptionTypeSHA1
 *
 *  @return 加密后的密文字符串
 */
+ (NSString *)encrypt:(NSString *)strSource KKEncryptionType:(KKEncryptionType)KKEncryptionType {
    NSString *strResult = nil;
    const char *cSource = [strSource UTF8String]; // 等同于[strSource cStringUsingEncoding:NSUTF8StringEncoding]
    CC_LONG cSourceLen = (CC_LONG)strlen(cSource);
    NSUInteger digestLen = 16;
    unsigned char arrOutputDigest[digestLen];
    
    switch (KKEncryptionType) {
        case KKEncryptionTypeMD5: {
            CC_MD5(cSource, cSourceLen, arrOutputDigest);
            break;
        }
        case KKEncryptionTypeSHA1: {
            CC_SHA1(cSource, cSourceLen, arrOutputDigest);
            break;
        }
        default: {
            break;
        }
    }
    
    NSMutableString *mStrResult = [[NSMutableString alloc] init];
    for (NSUInteger i=0; i<digestLen; i++) {
        [mStrResult appendFormat:@"%02x", arrOutputDigest[i]]; // 每个字符数组元素以（不足2位就补0的）16进制输出，16*2=32位
    }
    strResult = mStrResult;
    return strResult;
}

/**
 *  AES256加密解密
 *
 *  @param data      需要被加密解密的数据
 *  @param strKey    用于加密解密的32字节的密钥字符串（如不是32字节，就无法解密）
 *  @param isEncrypt 是否加密操作；YES为加密，NO为解密
 *
 *  @return AES256加密解密后的数据
 */
+ (NSData *)operationByAES256:(NSData *)data withKey:(NSString *)strKey isEncrypt:(BOOL)isEncrypt {
    NSData *dataResult = nil;
    NSUInteger dataLen = [data length];
    
    char keyPtr[kCCKeySizeAES256+1]; //kCCKeySizeAES256=32
    bzero(keyPtr, sizeof(keyPtr));
    [strKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t bufferSize = dataLen + kCCBlockSizeAES128; // kCCBlockSizeAES128=16；对于块加密算法，输出大小总是等于或小于输入大小加上一个块的大小，所以在下边需要再加上一个块的大小
    void *buffer = malloc(bufferSize);
    size_t numBytesOperated = 0;
    CCCryptorStatus cryptStatus = CCCrypt(isEncrypt ? kCCEncrypt : kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLen, //输入
                                          buffer, bufferSize, //输出
                                          &numBytesOperated);
    if (cryptStatus == kCCSuccess) {
        dataResult = [NSData dataWithBytesNoCopy:buffer length:numBytesOperated];
    }
    return dataResult;
}

+ (NSString *)kk_encodeURLString:(NSString *)strSource {
    return [strSource stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+ (NSString *)kk_decodeURLString:(NSString *)strSource {
    return [strSource stringByRemovingPercentEncoding];
}


@end
