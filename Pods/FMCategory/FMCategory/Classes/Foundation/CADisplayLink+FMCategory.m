//
//  CADisplayLink+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "CADisplayLink+FMCategory.h"

@implementation CADisplayLink (FMCategory)
/** 作用与系统方法保存一致，除了targer 是弱饮用之外*/
+ (instancetype)fm_displayLinkWithTarget:(id)target selector:(SEL)sel  frameInterval:(NSInteger)frameInterval{
    FMProxy *proxy = [[FMProxy alloc]initWithWeakObject:target];
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:proxy selector:sel];
    displayLink.frameInterval = frameInterval;
    return displayLink;
}

@end
