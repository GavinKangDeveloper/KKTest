//
//  KKServiceTool.m
//  App
//
//  Created by kangkang zhu on 2018/10/22.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKServiceTool.h"
#import "KKBaseService.h"


@implementation KKServiceTool

+ (void)postWithUrl:(NSString *)url params:(NSDictionary*)params showHUDView:(UIView *)showHUDView  success:(void (^)(id  results))success fail:(void (^)(NSError *error))fail {
    [KKBaseService postWithUrl:url params:params success:^(id response) {
        NSDictionary * dic = (NSDictionary *)response;
        success(dic);
    } fail:^(NSError *error) {
        if (fail) {
            NSLog(@"--errorerrorerror----%@",error);
            fail(error);
        }
    } showHUDView:showHUDView];
    
}

+ (void)getWithUrl:(NSString *)url params:(NSDictionary*)params showHUDView:(UIView *)showHUDView  success:(void (^)(id  results))success fail:(void (^)(NSError *error))fail {
    
    [KKBaseService getWithUrl:url params:params success:^(id response) {
        success(response);
    } fail:^(NSError *error) {
        NSLog(@"--errorerrorerror----%@",error);
        fail(error);
    } showHUDView:showHUDView];
}

@end
