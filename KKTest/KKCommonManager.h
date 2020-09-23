//
//  KKCommonManager.h
//  KKTest
//
//  Created by ZhuKangKang on 2020/9/23.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKCommonManager : NSObject

/// 初始化单例
+ (KKCommonManager *)sharedManager;

/// 销毁单例,让单例无效
- (void)invalidate;
@end

NS_ASSUME_NONNULL_END
