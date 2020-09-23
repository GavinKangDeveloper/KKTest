//
//  KKCommonManager.m
//  KKTest
//
//  Created by ZhuKangKang on 2020/9/23.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKCommonManager.h"

static dispatch_once_t _onceToken;
static KKCommonManager *_manager;

@interface  KKCommonManager()<NSCopying, NSMutableCopying>

@end

@implementation KKCommonManager

- (void)invalidate {
    _onceToken = 0;
    _manager = nil;
}

+ (KKCommonManager *)sharedManager {
    dispatch_once(&_onceToken, ^{
        _manager = [[super allocWithZone:NULL] init];
    });
    return _manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    NSLog(@"这是一个单例对象，请使用+(KKCommonManager *)sharedMamager 方法");
    return [self sharedManager];;
}

+ (instancetype)new {
    NSLog(@"这是一个单例对象，--- new");
    return  [self alloc];
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
//    NSAssert(0, @"这是一个单例对象，copy将不起任何作用");
    NSLog(@"这是一个单例对象，copy将不起任何作用");
    return self;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    NSLog(@"这是一个单例对象，mutableCopy 将不起任何作用");
    return self;
}

@end
