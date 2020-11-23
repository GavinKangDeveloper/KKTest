//
//  UIViewController+log.m
//  App
//
//  Created by kangkang zhu on 2019/4/16.
//  Copyright © 2019 xinli001. All rights reserved.
//

#import "UIViewController+log.h"
#import <objc/runtime.h>

@implementation UIViewController (log)

+ (void)load {
#ifdef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //原本的viewWillAppear方法
        Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
        //需要替换成 能够输出日志的viewWillAppear
        Method logViewWillAppear = class_getInstanceMethod(self, @selector(logViewWillAppear:));
        //两方法进行交换
        method_exchangeImplementations(viewWillAppear, logViewWillAppear);
    });
#endif
}

- (void)logViewWillAppear:(BOOL)animated {
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"当前的界面-will appear-----%@ ",className);
    //下面方法的调用，其实是调用viewWillAppear
    [self logViewWillAppear:animated];
}

@end
