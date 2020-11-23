//
//  KKBaseTabBarController.m
//  App
//
//  Created by kangkang zhu on 2018/10/29.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKBaseTabBarController.h"
#import "KKBaseNavigationController.h"

#import "KKHomeVC.h"
#import "KKMeVC.h"

@interface KKBaseTabBarController ()

@end

@implementation KKBaseTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 如果需要自定义Tabar，调用下面一句代码 替换tabbar
    //    [self setValue:[[ZKKTabbar alloc] init] forKeyPath:@"tabBar"];
    [self creatSubview];
    
    // 设置文字偏上2个点素
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0, -2.0)];
}

/**
 * 初始化所有的子控制器
 */
- (void)creatSubview {
    KKHomeVC *homeVC = [[KKHomeVC alloc] init];
    [self viewController:homeVC
                   title:@"首页"
                   image:@"kk_home_n"
           selectedImage:@"kk_home_s"];
    
    KKMeVC *meVC = [[KKMeVC alloc] init];
    meVC.navigationItem.title = @"我的";
    meVC.view.backgroundColor = [UIColor greenColor];
    [self viewController:meVC
                   title:@"我的"
                   image:@"kk_me_n"
           selectedImage:@"kk_me_s"];
    
    // 设置「默认状态」的文字前景颜色
       if (@available(iOS 13.0, *)) {
           [[UITabBar appearance] setUnselectedItemTintColor:kkFuncUIColorFromOxValue(0x999999)];
       } else {
           [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : kkFuncUIColorFromOxValue(0x999999) }
                                                    forState:UIControlStateNormal];
       }
       // 设置「选中状态」的文字前景颜色
       [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : kkFuncUIColorFromOxValue(0x6982FA) }
                                                forState:UIControlStateSelected];
    
    
    // 解决「iOS 12.1 下，底部 Tab 在打开新页面后回来会先收缩再正常显示」问题
    if (kkFuncOverSystemNum(12.0)) {
        self.tabBar.translucent = NO;
    }
}

- (void)viewController:(UIViewController *)vc
                 title:(NSString *)title
                 image:(NSString *)image
         selectedImage:(NSString *)selectedImage {
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:[[KKBaseNavigationController alloc] initWithRootViewController:vc]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
