//
//  NSDictionary+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (FMCategory)
#pragma mark 通用方法
/**
 深度对比
 @param otherDict 待对比字典
 @return 是否相同
 */
- (BOOL)fm_isDictionaryEqualToDictionary:(NSDictionary *)otherDict;

/// 输出属性代码
- (void)fm_outputPropCode;
@end

NS_ASSUME_NONNULL_END
