//
//  NSTimer+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "NSTimer+FMCategory.h"
#import "FMProxy.h"

@implementation NSTimer (FMCategory)
#pragma mark FMProxy
+ (instancetype)fm_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{
    FMProxy *proxy = [[FMProxy alloc]initWithWeakObject:aTarget];
    return [NSTimer timerWithTimeInterval:ti target:proxy selector:aSelector userInfo:userInfo repeats:yesOrNo];
}
+ (instancetype)fm_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{
    FMProxy *proxy = [[FMProxy alloc]initWithWeakObject:aTarget];
    return [NSTimer scheduledTimerWithTimeInterval:ti target:proxy selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

@end
