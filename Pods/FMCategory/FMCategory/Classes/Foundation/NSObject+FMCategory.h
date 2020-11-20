//
//  NSObject+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define keypath2(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), # PATH))

#define FMObserve(TARGET,KEYPATH, BLOCK) \
({\
\
[TARGET fm_addObserveKeyPath:@keypath2(TARGET,KEYPATH) didChangedBlock:\
BLOCK\
];\
})
// 建议使用code snippet

typedef void(^FMObserverBlock)(id oldVal,id newVal);
@interface FMKVOObserver : NSObject

@end

@interface NSObject (FMCategory)
#pragma mark FMBlockKVO
/**
 添加观察

 @param keyPath
 @param block 发生变化后的回调。
 ⚠️：1.防止循环引用，一定要用weakStrong
     2.多线程问题，修改值在那个线程，就在那个线程上调用变化回调
 */
- (void)fm_addObserveKeyPath:(id)keyPath didChangedBlock:(FMObserverBlock)block;

/**
 添加观察

 @param keyPath
 @param sign 标示 用于区分观察相同keyPath
 @param block 发生变化后的回调。
 ⚠️：1.防止循环引用，一定要用weakStrong
     2.多线程问题，修改值在那个线程，就在那个线程上调用变化回调
 */
- (void)fm_addObserveKeyPath:(id)keyPath signal:(NSString *)sign didChangedBlock:(FMObserverBlock)block;
/**
 移除通过FMBlockKVO的添加所有监听
 注意⚠️：已实现销毁时自动移除监听，无需手动移除
 */
- (void)fm_removeSelfObserberKVO;

/**
 移除指定keypath的监听

 @param keyPath
 注意：同keypath 不同sign 一起移除
 */
- (void)fm_removeObserverWithKeyPath:(NSString *)keyPath;

#pragma mark 获取属性和函数
/** 获取对象所有属性 */
+ (NSArray *)fm_getProps;

/// 执行函数 可以携带多个参数，nil用NSNull代替
/// @param aSelector 方法
/// @param objects 参数
- (id)fm_performSelector:(SEL)aSelector WithObjects:(NSArray *)objects;
@end

NS_ASSUME_NONNULL_END
