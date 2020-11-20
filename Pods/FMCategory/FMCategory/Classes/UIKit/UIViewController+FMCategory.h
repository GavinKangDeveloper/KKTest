//
//  UIViewController+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^voidBlock)();

@interface UIViewController (FMCategory)
#pragma mark 配置导航栏
/*!
 *  @brief 配置默认的 leftBarButtonItem
 */
- (void)fm_configNavLeftItemWith:(voidBlock)action;

/*!
 *  @brief 用 object(UIImage、NSString) 配置 leftBarButtonItem
 */
- (void)fm_configNavLeftItemWith:(id)object andAction:(voidBlock)action;

/*!
 *  @brief 用 object(UIImage、NSString) 配置 rightBarButtonItem
 */
- (void)fm_configNavRightItemWith:(id)object andAction:(voidBlock)action;

/*!
 *  @brief 配置 leftBarButtonItem、rightBarButtonItem
 *
 *  @param object    一个UIImage或NSString对象
 *  @param left        YES：leftBarButtonItem  NO：rightBarButtonItem
 *  @param font        object为NSString时的font
 *  @param color    leftBarButtonItem、rightBarButtonItem 的 tintColor
 *  @param action    block
 */
- (void)fm_configNavItemWith:(id)object leftOrRight:(BOOL)left withFont:(UIFont * __nullable)font withItemColor:(UIColor * __nullable)color andAction:(voidBlock)action;

/*!
 *  @brief 用 String 配置 leftBarButtonItem、rightBarButtonItem
 *
 *  @param text        一个NSString对象
 *  @param left        YES：leftBarButtonItem  NO：rightBarButtonItem
 *  @param font        text的大小
 *  @param color    leftBarButtonItem、rightBarButtonItem 的 tintColor
 *  @param action    block
 */
- (void)fm_configNavigationItemString:(NSString*)text withFont:(UIFont* __nullable)font withItemColor:(UIColor * __nullable)color leftOrRight:(BOOL)left andAction:(voidBlock)action;

#pragma mark 通用方法
/**
 透明底的模态推进
 */
- (void)fm_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END
