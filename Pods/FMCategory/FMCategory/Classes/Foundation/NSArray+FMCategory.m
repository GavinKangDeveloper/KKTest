//
//  NSArray+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "NSArray+FMCategory.h"

@implementation NSArray (FMCategory)
- (NSArray *)fm_map:(id  _Nonnull (^)(id _Nonnull))transform{
    NSMutableArray *temp = [NSMutableArray new];
    for (id item in self) {
        [temp addObject:transform(item)];
    }
    return temp.copy;
}
- (NSArray *)fm_filter:(BOOL (^)(id _Nonnull))transform{
    NSMutableArray *temp = [NSMutableArray new];
    for (id item in self) {
        if (transform(item)) {
            [temp addObject:item];
        }
    }
    return temp.copy;
}
- (id)fm_reduce:(id  _Nonnull (^)(id _Nonnull, id _Nonnull))transform{
    id result;
    for (id item in self) {
        result = transform(result,item);
    }
    return result;
}

+ (NSArray *)fm_zip:(id  _Nonnull (^)(NSArray * _Nonnull))transform, ...{
    va_list args;
    va_start(args, transform);
    NSMutableArray<NSArray *> *list = [NSMutableArray new];
    NSArray *param;
    while (1) {
        param = va_arg(args, NSArray *);
        if (!param) {
            break;
        }
        if ([param isKindOfClass:NSArray.class]) {
            [list addObject:param];
        }else{
            NSAssert(YES, @"必须是NSArray *结构");
            return nil;
        }
    }
    va_end(args);
    
    NSMutableArray *result = [NSMutableArray new];
    NSInteger min = NSIntegerMax;
    for (NSArray *item in list) {
        min = MIN(item.count, min);
    }
    for (NSInteger i = 0; i < min; i++) {
        NSMutableArray *temp = [NSMutableArray new];
        for (NSInteger j = 0; j < list.count; j++) {
            [temp addObject:list[j][i]];
        }
        NSArray *item = transform(temp);
        [result addObject: item];
    }
    return result;
}

- (BOOL)fm_isArrayEqualToArray:(NSArray *)otherArray
{
    /** 预先判断两组数据的个数*/
    if (self.count != otherArray.count) {
        return NO;
    }
    
    NSMutableSet *set1 = [NSMutableSet setWithArray:self];
    NSMutableSet *set2 = [NSMutableSet setWithArray:otherArray];
    
    [set1 intersectSet:set2];  //取交集后 set1中为1

    if (set1.count == self.count) {
        return YES;
    }
    return NO;
}
@end
