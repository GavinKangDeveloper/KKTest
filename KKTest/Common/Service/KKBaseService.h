//
//  KKBaseService.h
//  App
//
//  Created by kangkang zhu on 2018/10/22.
//  Copyright © 2018年 xinli001. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, KKNetworkStatus) {
    KKNetworkStatusUnknown             = -1, //未知网络
    KKNetworkStatusNotReachable        = 0,    //没有网络
    KKNetworkStatusReachableViaWWAN    = 1,    //手机自带网络
    KKNetworkStatusReachableViaWiFi    = 2     //wifi
};

typedef void( ^ WGDownloadProgress)(int64_t bytesProgress,
                                    int64_t totalBytesProgress);

/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask WGURLSessionTask;


@interface KKBaseService : NSObject

+ (KKBaseService *)sharedManager;

/**
 *  获取网络
 */
@property (nonatomic,assign)KKNetworkStatus networkStats;

/**
 *  开启网络监测
 */
+ (void)startMonitoring;

/**
 *  get请求方法,block回调
 *  @param showHUDView 显示HUD的View，没有View为不显示
 */

+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success fail:(void (^)(NSError *error))fail showHUDView:(UIView *)showHUDView;

/**
 *  post请求方法,block回调
 *  @param showHUDView 显示HUD的View，没有View为不显示
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success fail:(void (^)(NSError *error))fail showHUDView:(UIView *)showHUDView;

/**
 *  下载文件方法
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 *  @param showHUDView 显示HUD的View，没有View为不显示
 */
+ (void)downloadWithUrl:(NSString *)url saveToPath:(NSString *)saveToPath progress:(WGDownloadProgress )progressBlock success:(void (^)(id response) )success fail:(void (^)(NSError *error) )fail showHUDView:(UIView *)showHUDView;

@end

