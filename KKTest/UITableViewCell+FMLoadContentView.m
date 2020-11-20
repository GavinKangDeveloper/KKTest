//
//  UITableViewCell+FMLoadContentView.m
//  KKTest
//
//  Created by ZhuKangKang on 2020/10/30.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "UITableViewCell+FMLoadContentView.h"
#import <objc/runtime.h>

@implementation UITableViewCell (FMLoadContentView)

+ (void)exchangeLoadStyle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSStringFromClass(self) containsString:@"FM"]) {
            SEL originalSel = @selector(initWithStyle:reuseIdentifier:);
            SEL newSel = @selector(fm_initWithStyle:reuseIdentifier:);
            Method originalMethod = class_getInstanceMethod(self , originalSel);
            Method newMethod = class_getInstanceMethod(self , newSel);
            BOOL isAddNewMethod = class_addMethod(self, originalSel, method_getImplementation(newMethod), "v@:");
            if (isAddNewMethod) {
                class_replaceMethod(self, newSel, method_getImplementation(originalMethod), "v@:");
            } else {
                method_exchangeImplementations(originalMethod, newMethod);
            }
        }
    });
}

- (instancetype)fm_initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.contentView.contentMode = UIViewContentModeCenter;
    [self fm_initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}


@end
