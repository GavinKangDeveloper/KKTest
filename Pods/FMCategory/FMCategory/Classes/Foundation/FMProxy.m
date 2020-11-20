//
//  FMProxy.m
//  YiShou
//
//  Created by yaojunren on 2019/11/1.
//  Copyright © 2019 FuMi. All rights reserved.
//

#import "FMProxy.h"

@interface FMProxy ()
@property (weak, nonatomic) id target;
@end
@implementation FMProxy
- (instancetype)initWithWeakObject:(id)object{
    self = [FMProxy alloc];
    if (self) {
        self.target = object;
    }
    return self;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.target methodSignatureForSelector:sel];
}
- (void)forwardInvocation:(NSInvocation *)invocation{
    if (!self.target) {
        return;
    }
    if ([self.target respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.target];
    }
}


@end
