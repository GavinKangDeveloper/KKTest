//
//  NSObject+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "NSObject+FMCategory.h"
#import <objc/runtime.h>

NSString * const kFMBlockKVODefauleSign = @"kKVODefauleSign";
@interface FMKVOObserver()
@property (nonatomic, unsafe_unretained) NSObject *obj;
@property (strong, nonatomic) NSMutableDictionary<NSString *,FMObserverBlock> *changeBlockMap;
@property (strong, nonatomic) NSMutableArray *keyPathList;
- (void)FMProxy_addObserveKeyPath:(id)keyPath signal:(NSString *)sign didChangedBlock:(FMObserverBlock)block;
- (void)FMProxy_removeObserveKeyPath:(NSString *)keyPath;
@end
@implementation FMKVOObserver
- (void)dealloc{
    for (NSString *path in self.keyPathList) {
        [self.obj removeObserver:self forKeyPath:path];
    }
    [self.keyPathList removeAllObjects];
    [self.changeBlockMap removeAllObjects];
    self.obj = nil;
}
- (void)FMProxy_removeObserveKeyPath:(NSString *)keyPath{
    if (![self.keyPathList containsObject:keyPath]) {
        return;
    }
    [self.obj removeObserver:self forKeyPath:keyPath];
    [self.keyPathList removeObject:keyPath];
}
- (void)FMProxy_addObserveKeyPath:(id)keyPath signal:(NSString *)sign didChangedBlock:(FMObserverBlock)block{
    [self.obj addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:&sign];
    [self.keyPathList addObject:keyPath];
    [self.changeBlockMap setValue:block forKey:[NSString stringWithFormat:@"%@-%p",keyPath,&sign]];
}
#pragma mark - NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSString *path = [NSString stringWithFormat:@"%@-%p",keyPath,context];
    FMObserverBlock block = self.changeBlockMap[path];
    NSObject *oldValus = change[@"old"];
    NSObject *newValus = change[@"new"];
    if ([oldValus isKindOfClass:NSNull.class]) {
        oldValus = nil;
    }
    if ([newValus isKindOfClass:NSNull.class]) {
        newValus = nil;
    }
    if (block) {
        block(oldValus,newValus);
    }
}
#pragma mark - setter
- (NSMutableDictionary<NSString *,FMObserverBlock> *)changeBlockMap{
    if (!_changeBlockMap) {
        _changeBlockMap = [NSMutableDictionary new];
    }
    return _changeBlockMap;
}
- (NSMutableArray *)keyPathList{
    if (_keyPathList == nil) {
        _keyPathList = [NSMutableArray new];
    }
    return _keyPathList;
}
@end

@interface NSObject ()
@property (strong, nonatomic) FMKVOObserver *kvoProxy;
@end

@implementation NSObject (FMCategory)
#pragma mark FMBlockKVO
#pragma mark - public
- (void)fm_addObserveKeyPath:(id)keyPath didChangedBlock:(FMObserverBlock)block{
    [self fm_addObserveKeyPath:keyPath signal:kFMBlockKVODefauleSign didChangedBlock:block];
}
- (void)fm_addObserveKeyPath:(id)keyPath signal:(NSString *)sign didChangedBlock:(FMObserverBlock)block{
    [self.kvoProxy FMProxy_addObserveKeyPath:keyPath signal:sign didChangedBlock:block];
}
- (void(^)(FMObserverBlock))FMObserveKeyPath:(id)keyPath{
    return ^(FMObserverBlock block){
        [self fm_addObserveKeyPath:keyPath signal:kFMBlockKVODefauleSign didChangedBlock:block];
    };
}
#pragma mark - getter/setter
- (FMKVOObserver *)kvoProxy{
    FMKVOObserver *proxy = objc_getAssociatedObject(self, _cmd);
    if (!proxy) {
        proxy = [FMKVOObserver new];
        proxy.obj = self;
        self.kvoProxy = proxy;
    }
    return proxy;
}
- (void)setKvoProxy:(FMKVOObserver *)kvoProxy{
    objc_setAssociatedObject(self, @selector(kvoProxy), kvoProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)fm_removeSelfObserberKVO{
    self.kvoProxy = nil;
}
- (void)fm_removeObserverWithKeyPath:(NSString *)keyPath{
    [self.kvoProxy FMProxy_removeObserveKeyPath:keyPath];
}

#pragma mark 获取属性和函数
+ (NSArray *)fm_getProps {
    unsigned int count ,i;
    objc_property_t *propertyArray = class_copyPropertyList(self, &count);
    NSMutableArray *mProps = [NSMutableArray array];
    for (i = 0; i < count; i++) {
        objc_property_t property = propertyArray[i];
        NSString *proKey = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [mProps addObject:proKey];
    }
    free(propertyArray);
    return [mProps copy];
}
- (id)fm_performSelector:(SEL)aSelector WithObjects:(NSArray *)objects{
    
    NSMethodSignature *signature = [self.class instanceMethodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    NSInteger arguments = signature.numberOfArguments-2;
    NSUInteger objectsCount = objects.count;
    NSInteger count = MIN(arguments, objectsCount);
    for (int i = 0; i<count; i++) {
        NSObject*obj = objects[i];
        //处理参数是NULL类型的情况
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
        [invocation setArgument:&obj atIndex: i+2];
    }
    [invocation invoke];
    id res = nil;
    if (signature.methodReturnLength != 0) {
        //getReturnValue获取返回值
        [invocation getReturnValue: &res];
    }
    return res;
}
@end
