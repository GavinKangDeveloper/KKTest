//
//  NSDictionary+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "NSDictionary+FMCategory.h"
#import "NSArray+FMCategory.h"

@implementation NSDictionary (FMCategory)
- (BOOL)fm_isDictionaryEqualToDictionary:(NSDictionary *)otherDict
{
    if (![self.allKeys fm_isArrayEqualToArray:otherDict.allKeys]) {
        return NO;
    }
    
    __block BOOL isSame = YES;
    [self.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self[obj] isKindOfClass:NSString.class]) {
            if (![self[obj] isEqualToString:otherDict[obj]]) {
                isSame = NO;
            }
        }
        if ([self[obj] isKindOfClass:NSNumber.class]) {
            if ([self[obj] intValue] != [otherDict[@"obj"] intValue]) {
                isSame = NO;
            }
        }
    }];
    return isSame;
}

- (void)fm_outputPropCode
{
    if (![self isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSMutableString *result = [NSMutableString string];
    int i = 0;
    for (NSString *key in self) {
        i++;
        //普通类型
        NSString * type = @"";
        NSString * property = @"copy";
        NSString * isObject = @"*";
        //还是字典
        if ([self[key] isKindOfClass:[NSDictionary class]]) {
            [self[key] fm_outputPropCode];
            type = key;
        }
        
        //是数组
        if ([self[key] isKindOfClass:[NSArray class]]) {
            NSArray * array = self[key];
            if (array.count != 0) {
                [self[key][0] fm_outputPropCode];
                type = @"NSArray";
            }
        }
        
        if ([self[key] isKindOfClass:[NSNumber class]]) {
            type = @"NSNumber";
            property = @"copy";
            isObject = @"*";
        }
        
        if ([self[key] isKindOfClass:[NSString class]] || [self[key] isKindOfClass:[NSNull class]]) {
            type = @"NSString";
        }
        
        [result appendString:[NSString stringWithFormat:@"@property(nonatomic, %@, nullable) %@ %@%@;\n", property, type, isObject, key]];
    }
    NSLog(@"%@一共%d个字段", result, i);
}

@end
