//
//  NSArray+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (FMCategory)
#pragma mark 通用方法
/**
 遍历集合并对集合中每一个元素进行同样的操作。
 @retrun 函数返回一个数组，其中每一个元素都是原数组对应元素经过映射后的结果;
*/
- (NSArray *)fm_map:(id(^)(ObjectType item))transform;
/**
 filter函数会遍历一个集合。
 @param transform 过滤条件
 @return 返回一个 Array,其中包含了集合中满足过滤条件的元素
 */
- (NSArray *)fm_filter:(BOOL(^)(ObjectType item))transform;
/**
 遍历数组，通过方法函数编程进行处理
 @param 函数编程
 @return 返回函数编程后的结果值
 */
- (ObjectType)fm_reduce:(ObjectType(^)(ObjectType result,ObjectType item))transform;
/**
 多数组合并成一个数组
 @param 多个数组
 @return 合并后的数组
 */
+ (NSArray *)fm_zip:(id (^)(NSArray *item))transform,...NS_REQUIRES_NIL_TERMINATION;
/**
 判断是否跟另外一个数组相同
 */
- (BOOL)fm_isArrayEqualToArray:(NSArray *)otherArray;
@end

NS_ASSUME_NONNULL_END
