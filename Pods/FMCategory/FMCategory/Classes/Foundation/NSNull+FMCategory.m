//
//  NSNull+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "NSNull+FMCategory.h"
#import <objc/message.h>
#define NSNullObjectsArr @[@"", @0, @{}, @[]]

@implementation NSNull (FMCategory)
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
 {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        for (NSObject *obj in NSNullObjectsArr) {
            signature = [obj methodSignatureForSelector:aSelector];
            if (signature) {
                break;
            }
        }
    }
    return signature;
}


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    for (NSObject *objc in NSNullObjectsArr) {
        if ([objc respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:objc];
            return;
        }
    }
}
@end
