//
//  KKSafeCollection.m
//  KKTest
//
//  Created by FumiTech on 2020/8/11.
//  Copyright © 2020 ZKKBP. All rights reserved.
//

#import "KKSafeCollection.h"
#import <objc/runtime.h>
#import <UIKit/UIDevice.h>

#pragma mark - Exception Log
#define exceptionLog(...) privateLog(__VA_ARGS__)
void privateLog(NSString *fmt, ...) NS_FORMAT_FUNCTION(1, 2);
void privateLog(NSString *fmt, ...) {
#ifdef DEBUG
     va_list ap;
     va_start(ap, fmt);
     NSString *content = [[NSString alloc] initWithFormat:fmt arguments:ap];
     NSLog(@"%@", content);
     va_end(ap);
     
     NSLog(@" ============= call stack ========== \n%@", [NSThread callStackSymbols]);
#endif
}

#pragma mark - NSArray
@interface NSArray (Safe)

@end

@implementation NSArray (Safe)

+ (Method)instanceMethodOfSelector:(SEL)selector {
    return class_getInstanceMethod(NSClassFromString(@"__NSArrayI"), selector);
}

+ (Method)classMethodOfSelector:(SEL)selector {
    return class_getClassMethod([self class], selector);
}

/// 兼容获取对象越界
- (id)kk_objectAtIndexI:(NSUInteger)index {
    @autoreleasepool {
        NSUInteger count = self.count;
        if (index >= count) {
            exceptionLog(@"[%@ %@] index {%zd} beyond bounds [0...%zd]", NSStringFromClass([self class]), NSStringFromSelector(_cmd), index, MAX(count - 1, 0));
            return nil;
        }

        return [self kk_objectAtIndexI:index];
    }
}

/// 兼容下标的方式获取对象越界；array[3]
- (id)kk_objectAtIndexedSubscriptI:(NSUInteger)index {
    @autoreleasepool {
        NSUInteger count = self.count;
        if (index >= count) {
            exceptionLog(@"[%@ %@] index {%zd} beyond bounds [0...%zd]", NSStringFromClass([self class]), NSStringFromSelector(_cmd), index, MAX(count - 1, 0));
            return nil;
        }

        return [self kk_objectAtIndexedSubscriptI:index];
    }
}

@end


#pragma mark - NSMutableArray
@interface NSMutableArray (Safe)

@end

@implementation NSMutableArray (Safe)

+ (Method)instanceMethodOfSelector:(SEL)selector {
    return class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), selector);
}

/// 兼容获取对象越界
- (id)kk_objectAtIndexM:(NSUInteger)index {
    @autoreleasepool {
        NSUInteger count = self.count;
        if (index >= count) {
            exceptionLog(@"[%@ %@] index {%zd} beyond bounds [0...%zd]", NSStringFromClass([self class]), NSStringFromSelector(_cmd), index, MAX(count - 1, 0));
            return nil;
        }

        return [self kk_objectAtIndexM:index];
    }
}

/// 兼容下标的方式获取对象越界；mutableArray[3]
- (id)kk_objectAtIndexedSubscriptM:(NSUInteger)index {
    @autoreleasepool {
        NSUInteger count = self.count;
        if (index >= count) {
            exceptionLog(@"[%@ %@] index {%zd} beyond bounds [0...%zd]", NSStringFromClass([self class]), NSStringFromSelector(_cmd), index, MAX(count - 1, 0));
            return nil;
        }
        return [self kk_objectAtIndexedSubscriptM:index];
    }
}

///兼容添加空对象
- (void)kk_addObject:(id)anObject {
    if (!anObject) {
        exceptionLog(@"[%@ %@], nil object.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    [self kk_addObject:anObject];
}


/// 兼容替换的对象为空，或者替换的 index 越界
- (void)kk_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    NSUInteger count = self.count;
    if (index >= count) {
        exceptionLog(@"[%@ %@] index {%zd} beyond bounds [0...%zd].", NSStringFromClass([self class]), NSStringFromSelector(_cmd), index, MAX(count - 1, 0));
        return;
    }
    
    if (!anObject) {
        exceptionLog(@"[%@ %@] nil object.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    
    [self kk_replaceObjectAtIndex:index withObject:anObject];
}

/// 兼容插入的对象为空，或者插入的 index 越界
- (void)kk_insertObject:(id)anObject atIndex:(NSUInteger)index {
    NSUInteger count = self.count;
    if (index > count) {
        exceptionLog(@"[%@ %@] index {%zd} beyond bounds [0...%zd].", NSStringFromClass([self class]), NSStringFromSelector(_cmd), index, MAX(count - 1, 0));
        return;
    }
    
    if (!anObject) {
        exceptionLog(@"[%@ %@] nil object.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    
    [self kk_insertObject:anObject atIndex:index];
}

/// 兼容删除的 index 越界
- (void)kk_removeObjectAtIndex:(NSUInteger)index {
    NSUInteger count = self.count;
    if (index >= count) {
        exceptionLog(@"[%@ %@] index {%zd} beyond bounds [0...%zd].", NSStringFromClass([self class]), NSStringFromSelector(_cmd), index, MAX(count - 1, 0));
        return;
    }
    
    [self kk_removeObjectAtIndex:index];
}

/// 兼容删除的 range 越界
- (void)kk_removeObjectsInRange:(NSRange)range {
    NSUInteger count = self.count;
    if ((range.location + range.length) > count) {
        exceptionLog(@"[%@ %@] range {%zd} beyond bounds [0...%zd].", NSStringFromClass([self class]), NSStringFromSelector(_cmd), index, MAX(count - 1, 0));
        return;
    }
    
    [self kk_removeObjectsInRange:range];
}

@end


#pragma mark - NSDictionary
@interface NSDictionary (Safe)

@end

@implementation NSDictionary (Safe)

+ (Method)classMethodOfSelector:(SEL)selector {
    return class_getClassMethod([self class], selector);
}

/// 兼容 count 内，object 和 key 数量不同，或者有空对象
+ (instancetype)kk_dictionaryWithObjects:(const id[])objects forKeys:(const id<NSCopying>[])keys count:(NSUInteger)count {
    id validObjects[count];
    id<NSCopying> validKeys[count];
    NSUInteger index = 0;
    for (NSUInteger i = 0; i < count; i++) {
        if (objects[i] && keys[i]) {
            validObjects[index] = objects[i];
            validKeys[index] = keys[i];
            index++;
        } else {
            exceptionLog(@"[%@ %@] nil object or key at index{%zd}.", NSStringFromClass(self), NSStringFromSelector(_cmd), i);
        }
    }
    
    return [self kk_dictionaryWithObjects:validObjects
                                  forKeys:validKeys
                                    count:index];
}

/// 兼容 object 和 key 不良不一样，或者有空对象
+ (instancetype)kk_dictionaryWithObjects:(NSArray *)objects forKeys:(const NSArray<NSCopying> *)keys {
    NSMutableArray *arrsObject = [NSMutableArray array];
    NSMutableArray *arrsKey = [NSMutableArray array];
    NSUInteger count = MIN(objects.count, keys.count);
    for (NSUInteger i = 0; i < count; i++) {
       if (objects[i] && keys[i]) {
           [arrsObject addObject:objects[i]];
           [arrsKey addObject:keys[i]];
        } else {
            exceptionLog(@"[%@ %@] nil object or key at index{%zd}.", NSStringFromClass(self), NSStringFromSelector(_cmd), i);
        }
    }
    return [self kk_dictionaryWithObjects:arrsObject
                                  forKeys:arrsKey];
}

@end


#pragma mark - NSMutableDictionary
@interface NSMutableDictionary (Safe)

@end

@implementation NSMutableDictionary (Safe)

+ (Method)instanceMethodOfSelector:(SEL)selector {
    return class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"), selector);
}

/// 兼容添加 key 或者 object 为空
- (void)kk_setObject:(id)object forKey:(id<NSCopying>)aKey {
    if (!aKey) {
        exceptionLog(@"[%@ %@] nil key.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    if (!object) {
        exceptionLog(@"[%@ %@] nil object.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    
    [self kk_setObject:object forKey:aKey];
}

@end


#pragma mark - KKSafeCollection
@implementation KKSafeCollection

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 不可变数组
        [self exchangeOriginalMethod:[NSArray instanceMethodOfSelector:@selector(objectAtIndex:)]
                           newMethod:[NSArray instanceMethodOfSelector:@selector(kk_objectAtIndexI:)]];
        
        [self exchangeOriginalMethod:[NSArray instanceMethodOfSelector:@selector(objectAtIndexedSubscript:)]
                           newMethod:[NSArray instanceMethodOfSelector:@selector(kk_objectAtIndexedSubscriptI:)]];
        
        // 可变数组
        [self exchangeOriginalMethod:[NSMutableArray instanceMethodOfSelector:@selector(objectAtIndex:)]
                           newMethod:[NSMutableArray instanceMethodOfSelector:@selector(kk_objectAtIndexM:)]];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
            [self exchangeOriginalMethod:[NSMutableArray instanceMethodOfSelector:@selector(objectAtIndexedSubscript:)]
                               newMethod:[NSMutableArray instanceMethodOfSelector:@selector(kk_objectAtIndexedSubscriptM:)]];
        }
        
        [self exchangeOriginalMethod:[NSMutableArray instanceMethodOfSelector:@selector(replaceObjectAtIndex:withObject:)]
                           newMethod:[NSMutableArray instanceMethodOfSelector:@selector(kk_replaceObjectAtIndex:withObject:)]];
        
        [self exchangeOriginalMethod:[NSMutableArray instanceMethodOfSelector:@selector(addObject:)]
                           newMethod:[NSMutableArray instanceMethodOfSelector:@selector(kk_addObject:)]];
        
        [self exchangeOriginalMethod:[NSMutableArray instanceMethodOfSelector:@selector(insertObject:atIndex:)]
                           newMethod:[NSMutableArray instanceMethodOfSelector:@selector(kk_insertObject:atIndex:)]];
        
        [self exchangeOriginalMethod:[NSMutableArray instanceMethodOfSelector:@selector(removeObjectAtIndex:)]
                           newMethod:[NSMutableArray instanceMethodOfSelector:@selector(kk_removeObjectAtIndex:)]];
        
        [self exchangeOriginalMethod:[NSMutableArray instanceMethodOfSelector:@selector(removeObjectsInRange:)]
                           newMethod:[NSMutableArray instanceMethodOfSelector:@selector(kk_removeObjectsInRange:)]];
        
        // 不可变字典
        [self exchangeOriginalMethod:[NSDictionary classMethodOfSelector:@selector(dictionaryWithObjects:forKeys:count:)]
                           newMethod:[NSDictionary classMethodOfSelector:@selector(kk_dictionaryWithObjects:forKeys:count:)]];
        
        [self exchangeOriginalMethod:[NSDictionary classMethodOfSelector:@selector(dictionaryWithObjects:forKeys:)]
                           newMethod:[NSDictionary classMethodOfSelector:@selector(kk_dictionaryWithObjects:forKeys:)]];
        
        // 可变字典
        [self exchangeOriginalMethod:[NSMutableDictionary instanceMethodOfSelector:@selector(setObject:forKey:)]
                           newMethod:[NSMutableDictionary instanceMethodOfSelector:@selector(kk_setObject:forKey:)]];
    });
}

#pragma mark - Private Method
+ (void)exchangeOriginalMethod:(Method)originalMethod newMethod:(Method)newMethod {
    method_exchangeImplementations(originalMethod, newMethod);
}

@end
