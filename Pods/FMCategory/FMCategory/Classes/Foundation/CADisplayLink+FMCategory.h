//
//  CADisplayLink+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FMProxy.h"

NS_ASSUME_NONNULL_BEGIN

@interface CADisplayLink (FMCategory)

/** 作用与系统方法保存一致，除了targer 是弱饮用之外*/
+ (instancetype)fm_displayLinkWithTarget:(id)target selector:(SEL)sel  frameInterval:(NSInteger)frameInterval;
@end

NS_ASSUME_NONNULL_END
