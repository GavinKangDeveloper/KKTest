//
//  KKBaseModel.m
//  KKTest
//
//  Created by ZhuKangKang on 2020/11/23.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKBaseModel.h"
#import <MJExtension.h>

@implementation KKBaseModel

- (NSString *)description {
    return [self desc];
}

- (NSString *)debugDescription {
    return [self desc];
}

#pragma mark - Description
- (NSString *)desc {
    NSString *modelInfoStr = [NSString stringWithFormat:@"%@ -- %@ : %p", [self mj_keyValues], [self class], self];
    modelInfoStr = [modelInfoStr stringByRemovingPercentEncoding];//URL解码
    return modelInfoStr;
}

@end
