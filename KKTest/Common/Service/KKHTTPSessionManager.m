//
//  KKHTTPSessionManager.m
//  KKTest
//
//  Created by ZhuKangKang on 2020/11/19.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "KKUtilityNotice.h"

static NSString *kBaseUrlStr = @"https://yiapi.xinli001.com/";

typedef void (^Failure)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull);

@implementation KKHTTPSessionManager

+ (KKHTTPSessionManager *)sharedManager {
    static KKHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrlStr]];
        /*
         1、NSURLRequestUseProtocolCachePolicy：使用协议指定的缓存策略。
         2、NSURLRequestReloadIgnoringLocalCacheData：忽略缓存，直接发起请求。
         3、NSURLRequestReturnCacheDataElseLoad：不验证缓存过期时间，如果有则使用缓存数据，如果不存在则请求服务器。
         4、NSURLRequestReturnCacheDataDontLoad：不验证缓存过期时间，如果有则使用缓存数据，如果不存在则请求失败。
         5、NSURLRequestReloadIgnoringLocalAndRemoteCacheData：忽略本地缓存，以及代理等中间介质的缓存。
         6、NSURLRequestReloadRevalidatingCacheData：和数据的源服务器验证数据合法性，如果可以用就直接使用缓存数据，否则从服务器请求数据。
         */
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        //        可以接收的数据类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                             @"text/json",
                                                             @"text/javascript",
                                                             @"text/html",
                                                             @"text/plain", nil];
        manager.requestSerializer.timeoutInterval = 30.0;
        //        去除 null 的内容
        ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
        /*
         1、AFSSLPinningModeNone：默认的方式；本地没有保存证书，只验证服务器证书是不是系统受信任证书列表里的证书签发的。
         2、AFSSLPinningModePublicKey：本地存有证书，验证证书的有效期等信息，也就是将本地证书设置为锚点证书，然后验证证书有效性，再判断本地证书和服务器证书是否一致。
         3、AFSSLPinningModeCertificate：是本地存有证书，只是验证时只验证证书里的公钥，不验证证书的有效期等信息
         */
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return manager;
}

#pragma mark - GET
- (NSURLSessionDataTask *_Nullable)kk_GET:(NSString * _Nonnull)URLString
                               parameters:(id _Nullable)parameters
                              showLoading:(BOOL)showLoading
                                  success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                                  failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failure {
    return [[KKHTTPSessionManager sharedManager] kk_GET:URLString
                                             parameters:parameters
                                            showLoading:showLoading
                                                headers:nil
                                               progress:nil
                                                success:success
                                                failure:failure];
}

- (NSURLSessionDataTask *_Nullable)kk_GET:(NSString * _Nonnull)URLString
                               parameters:(id _Nullable)parameters
                              showLoading:(BOOL)showLoading
                                  headers:(NSDictionary<NSString *, NSString *> *)headers
                                 progress:(void (^ _Nullable)(NSProgress * _Nonnull downloadProgress))downloadProgress
                                  success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                                  failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failure {
    if (showLoading) {
        [KKUtilityNotice show];
    }
    NSString *requestUrl = [[KKHTTPSessionManager sharedManager] appendSubUrlStr:URLString];
    NSDictionary *parametersDic = [[KKHTTPSessionManager sharedManager] addBaseParameters:parameters];
    
    return [[KKHTTPSessionManager sharedManager] GET:requestUrl
                                          parameters:parametersDic
                                             headers:headers
                                            progress:downloadProgress
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showLoading) {
            [KKUtilityNotice dismiss];
        }
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showLoading) {
            [KKUtilityNotice dismiss];
        }
        failure(task, error);
    }];
}

#pragma mark - POST
- (NSURLSessionDataTask *_Nullable)kk_POST:(NSString * _Nonnull)URLString
                                parameters:(id _Nullable)parameters
                               showLoading:(BOOL)showLoading
                                   success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                                   failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failure {
    return [[KKHTTPSessionManager sharedManager] kk_POST:URLString
                                              parameters:parameters
                                             showLoading:showLoading
                                                 headers:nil
                                                progress:nil
                                                 success:success
                                                 failure:failure];
}

- (NSURLSessionDataTask *_Nullable)kk_POST:(NSString * _Nonnull)URLString
                                parameters:(id _Nullable)parameters
                               showLoading:(BOOL)showLoading
                                   headers:(NSDictionary<NSString *, NSString *> *)headers
                                  progress:(void (^ _Nullable)(NSProgress * _Nonnull downloadProgress))downloadProgress
                                   success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                                   failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failure {
    if (showLoading) {
        [KKUtilityNotice show];
    }
    NSString *requestUrl = [[KKHTTPSessionManager sharedManager] appendSubUrlStr:URLString];
    NSDictionary *parametersDic = [[KKHTTPSessionManager sharedManager] addBaseParameters:parameters];
    
    return [[KKHTTPSessionManager sharedManager] POST:requestUrl
                                           parameters:parametersDic
                                              headers:headers
                                             progress:downloadProgress
                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showLoading) {
            [KKUtilityNotice dismiss];
        }
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showLoading) {
            [KKUtilityNotice dismiss];
        }
        failure(task, error);
    }];
}

#pragma mark - Private
- (NSString *)appendSubUrlStr:(NSString *)subUrlStr {
    return [NSString stringWithFormat:@"%@%@",kBaseUrlStr,subUrlStr];
}

- (NSDictionary *)addBaseParameters:(NSDictionary *)parameters {
    NSMutableDictionary *parametersDics = [NSMutableDictionary dictionaryWithDictionary:parameters];
    return [parametersDics copy];
}


@end
