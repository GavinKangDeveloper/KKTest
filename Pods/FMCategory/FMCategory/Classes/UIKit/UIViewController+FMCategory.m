//
//  UIViewController+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "UIViewController+FMCategory.h"
#import <objc/runtime.h>

#define LeftItemImageOrTitle [UIImage imageNamed:@"common_back_icon"]?[UIImage imageNamed:@"common_back_icon"]:@"返回"
#define DefaultItemTitleFont [UIFont systemFontOfSize:16.0]
#define DefaultItemTintColor [UIColor whiteColor]

static const void *UIViewControllerNavItemleftKey  = &UIViewControllerNavItemleftKey;
static const void *UIViewControllerNavItemrightKey = &UIViewControllerNavItemrightKey;

@implementation UIViewController (FMCategory)
- (void)fm_configNavLeftItemWith:(voidBlock)action{
    [self fm_configNavLeftItemWith:LeftItemImageOrTitle andAction:action];
}

- (void)fm_configNavLeftItemWith:(id)object andAction:(voidBlock)action{
    [self fm_configNavItemWith:object leftOrRight:YES withFont:nil withItemColor:nil andAction:action];
}

- (void)fm_configNavRightItemWith:(id)object andAction:(voidBlock)action{
    [self fm_configNavItemWith:object leftOrRight:NO withFont:nil withItemColor:nil andAction:action];
}

- (void)fm_configNavItemWith:(id)object leftOrRight:(BOOL)left withFont:(UIFont * __nullable)font withItemColor:(UIColor * __nullable)color andAction:(voidBlock)action{
    
    NSCAssert([object isKindOfClass:[NSString class]] || [object isKindOfClass:[UIImage class]], @"the object must be class of NSString or UIImage");
    
    if ([object isKindOfClass:[UIImage class]])
    {
        if (action) {
            objc_setAssociatedObject(self,
                                     left ? &UIViewControllerNavItemleftKey : &UIViewControllerNavItemrightKey,
                                     action,
                                     OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[object imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:left ? @selector(pressLeft:) : @selector(pressRight:)];
        if (left){
            self.navigationItem.leftBarButtonItem = barButtonItem;
        }else{
            self.navigationItem.rightBarButtonItem = barButtonItem;
        }
    }
    else
    {
        if (color && font) {
            [self fm_configNavigationItemString:object withFont:font withItemColor:color leftOrRight:left andAction:action];
        }else if(color){
            [self fm_configNavigationItemString:object withFont:DefaultItemTitleFont withItemColor:color leftOrRight:left andAction:action];
        }else if (font){
            [self fm_configNavigationItemString:object withFont:font withItemColor:nil leftOrRight:left andAction:action];
        }else{
            [self fm_configNavigationItemString:object withFont:DefaultItemTitleFont withItemColor:nil leftOrRight:left andAction:action];
        }
    }
}

- (void)fm_configNavigationItemString:(NSString*)text withFont:(UIFont* __nullable)font withItemColor:(UIColor * __nullable)color leftOrRight:(BOOL)left andAction:(voidBlock)action{
    NSCAssert([text isKindOfClass:[NSString class]], @"the text must be class of NSString");
    
    if (action) {
        objc_setAssociatedObject(self,
                                 left ? &UIViewControllerNavItemleftKey : &UIViewControllerNavItemrightKey,
                                 action,
                                 OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:self action:left ? @selector(pressLeft:) : @selector(pressRight:)];
    NSDictionary * attributes = @{NSFontAttributeName: font};
    [barButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    if (color) {
        [barButtonItem setTintColor:color];
    }else{
        [barButtonItem setTintColor:DefaultItemTintColor];
    }
    if (left) {
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }else {
        self.navigationItem.rightBarButtonItem = barButtonItem;
    }
}

- (void)pressLeft:(id)sender{
    voidBlock action = objc_getAssociatedObject(self, UIViewControllerNavItemleftKey);
    if (action) {
        action();
    }
}

- (void)pressRight:(id)sender{
    voidBlock action = objc_getAssociatedObject(self, UIViewControllerNavItemrightKey);
    if (action) {
        action();
    }
}

- (void)fm_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion
{
    if (@available(iOS 13.0, *)) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:viewControllerToPresent animated:animated completion:completion];
}
@end
