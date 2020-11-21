//
//  KKLaunchImageAdView.h
//  App
//
//  Created by kangkang zhu on 2018/10/10.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+WebCache.h"

typedef enum : NSInteger{
    KJLaunchImageLogoAdType = 0,  ///< 带logo的广告
    KJLaunchImageFullScreenAdType,///< 全屏的广告
}KJLaunchImageAdType;

typedef enum : NSInteger{
    KJAdImageClickAdType = 1,  ///< 点击广告
    KJAdImageClickSkipType,    ///< 点击跳过
    KJAdImageClickFinishType   ///< 正常结束
}KJAdImageClickType;

typedef enum : NSInteger{
    KJAdImageLocationType = 1,  ///< 本地图片
    KJAdImageNetworkType,       ///< 网络图片
}KJAdImageType;

typedef void (^LaunchImageClickBlock)(KJAdImageClickType clickType);

@interface KKLaunchImageAdView : UIView

@property(nonatomic, copy) LaunchImageClickBlock clickType;

- (instancetype)initWithWindow:(UIWindow *)window launchImageAdType:(KJLaunchImageAdType)launchImageAdType adImageURL:(NSString *)adImageURL adTime:(NSInteger)adTime;
- (instancetype)initWithWindow:(UIWindow *)window launchImageAdType:(KJLaunchImageAdType)launchImageAdType adImage:(UIImage *)adImage adTime:(NSInteger)adTime;


@end

