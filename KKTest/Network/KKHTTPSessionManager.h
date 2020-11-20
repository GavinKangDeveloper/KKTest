//
//  KKHTTPSessionManager.h
//  KKTest
//
//  Created by ZhuKangKang on 2020/11/19.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKHTTPSessionManager : AFHTTPSessionManager

+ (KKHTTPSessionManager * _Nullable)sharedManager;

#pragma mark - GET
- (NSURLSessionDataTask *_Nullable)kk_GET:(NSString * _Nonnull)URLString
                               parameters:(id _Nullable)parameters
                              showLoading:(BOOL)showLoading
                                  success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                                  failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failure;
- (NSURLSessionDataTask *_Nullable)kk_GET:(NSString * _Nonnull)URLString
                               parameters:(id _Nullable)parameters
                              showLoading:(BOOL)showLoading
                                  headers:(NSDictionary<NSString *, NSString *> *)headers
                                 progress:(void (^ _Nullable)(NSProgress * _Nonnull downloadProgress))downloadProgress
                                  success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                                  failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failure;

#pragma mark - POST
- (NSURLSessionDataTask *_Nullable)kk_POST:(NSString * _Nonnull)URLString
                                parameters:(id _Nullable)parameters
                               showLoading:(BOOL)showLoading
                                   success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                                   failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failure;

- (NSURLSessionDataTask *_Nullable)kk_POST:(NSString * _Nonnull)URLString
                                parameters:(id _Nullable)parameters
                               showLoading:(BOOL)showLoading
                                   headers:(NSDictionary<NSString *, NSString *> *)headers
                                  progress:(void (^ _Nullable)(NSProgress * _Nonnull downloadProgress))downloadProgress
                                   success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                                   failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failure;

@end

NS_ASSUME_NONNULL_END
