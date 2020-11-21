//
//  KKKKBaseService.m
//  App
//
//  Created by kangkang zhu on 2018/10/22.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKBaseService.h"

#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import <MBProgressHUD.h>

static NSMutableArray *arrsTask;
@implementation KKBaseService

+ (KKBaseService *)sharedManager {
    static KKBaseService *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[KKBaseService alloc] init];
    });
    return handler;
}


+(NSMutableArray *)arrsTask {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        arrsTask = [[NSMutableArray alloc] init];
    });
    return arrsTask;
}

+ (void)getWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(void (^)(id response))success
              fail:(void (^)(NSError *error))fail
       showHUDView:(UIView *)showHUDView {
    [self baseRequestType:1 url:url params:params success:success fail:fail showHUDView:showHUDView];
}

+ (void)postWithUrl:(NSString *)url
             params:(NSDictionary *)params
            success:(void (^)(id response))success
               fail:(void (^)(NSError *error))fail
        showHUDView:(UIView *)showHUDView {
    [self baseRequestType:2 url:url params:params success:success fail:fail showHUDView:showHUDView];
}

+ (void)baseRequestType:(NSUInteger)type
                    url:(NSString *)url
                 params:(NSDictionary *)params
                success:(void (^)(id response))success
                   fail:(void (^)(NSError *error))fail
            showHUDView:(UIView *)showHUDView {
    BOOL isShowHUD = NO;
    if ([showHUDView isKindOfClass:[UIView class]]) {
        isShowHUD = YES;
        [MBProgressHUD showHUDAddedTo:showHUDView animated:YES];
    }
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    AFHTTPSessionManager *manager=[self getAFManager];
    NSURLSessionTask *sessionTask=nil;
    if (type==1) {
        sessionTask = [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
            [[self arrsTask] removeObject:sessionTask];
            if (isShowHUD==YES) {
                [MBProgressHUD hideHUDForView:showHUDView animated:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
            [[self arrsTask] removeObject:sessionTask];
            if (isShowHUD==YES) {
                [MBProgressHUD hideHUDForView:showHUDView animated:YES];
            }
        }];
    }else{
        sessionTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
            [[self arrsTask] removeObject:sessionTask];
            if (isShowHUD==YES) {
                [MBProgressHUD hideHUDForView:showHUDView animated:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
            [[self arrsTask] removeObject:sessionTask];
            if (isShowHUD==YES) {
                [MBProgressHUD hideHUDForView:showHUDView animated:YES];
            }
        }];
    }
    if (sessionTask) {
        [[self arrsTask] addObject:sessionTask];
    }
}
+ (void)downloadWithUrl:(NSString *)url
             saveToPath:(NSString *)saveToPath
               progress:(WGDownloadProgress )progressBlock
                success:(void (^)(id response) )success
                   fail:(void (^)(NSError *error) )fail
            showHUDView:(UIView *)showHUDView {
    BOOL isShowHUD = NO;
    if ([showHUDView isKindOfClass:[UIView class]]) {
        isShowHUD = YES;
        [MBProgressHUD showHUDAddedTo:showHUDView animated:YES];
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self getAFManager];
    NSURLSessionTask *sessionTask = nil;
    
    sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载进度--%.1f",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        }else{
            return [NSURL fileURLWithPath:saveToPath];
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self arrsTask] removeObject:sessionTask];
        if (error == nil) {
            if (success) {
                success([filePath path]);//返回完整路径
            }
        } else {
            if (fail) {
                fail(error);
            }
        }
        if (isShowHUD==YES) {
            [MBProgressHUD hideHUDForView:showHUDView animated:YES];
        }
    }];
    //开始启动任务
    [sessionTask resume];
    if (sessionTask) {
        [[self arrsTask] addObject:sessionTask];
    }
}

+ (AFHTTPSessionManager *)getAFManager {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"text/css",
                                                                              @"image/*"]];
        return manager;
}

#pragma makr - 开始监听网络连接
+ (void)startMonitoring {
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                [KKBaseService sharedManager].networkStats = KKNetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [KKBaseService sharedManager].networkStats= KKNetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                [KKBaseService sharedManager].networkStats= KKNetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                [KKBaseService sharedManager].networkStats= KKNetworkStatusReachableViaWiFi;
                break;
        }
    }];
    [mgr startMonitoring];
}


+(NSString *)strUTF8Encoding:(NSString *)str{
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
