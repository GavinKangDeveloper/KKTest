//
//  KKServiceTool.h
//  App
//
//  Created by kangkang zhu on 2018/10/22.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKServiceTool : NSObject

+ (void)postWithUrl:(NSString *)url params:(NSDictionary*)params showHUDView:(UIView *)showHUDView  success:(void (^)(id  results))success fail:(void (^)(NSError *error))fail;

+ (void)getWithUrl:(NSString *)url params:(NSDictionary*)params showHUDView:(UIView *)showHUDView  success:(void (^)(id  results))success fail:(void (^)(NSError *error))fail;

@end

NS_ASSUME_NONNULL_END
