//
//  KKBaseTabBarController.m
//  App
//
//  Created by kangkang zhu on 2018/10/29.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKBaseTabBarController.h"
#import "KKBaseNavigationController.h"

#import "KKTempFirstViewController.h"
#import "KKTempSecondViewController.h"

@interface KKBaseTabBarController ()

@end

@implementation KKBaseTabBarController

+ (instancetype)baseTabBar {
    KKBaseTabBarController *tabBar = [[KKBaseTabBarController alloc] init];
    return tabBar;
}

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
    KKTempFirstViewController *firstVC = [[KKTempFirstViewController alloc] init];
    [self viewController:firstVC
                   title:@"界面1"
                   image:@"API_new_movie"
           selectedImage:@"API_new_movie"];
    
    KKTempSecondViewController *secondVC = [[KKTempSecondViewController alloc] init];
    [self viewController:secondVC
                   title:@"界面2"
                   image:@"API_hot_movie"
           selectedImage:@"API_hot_movie"];
    if (kkFuncOverSystemNum(12.0)) {
        // 解决「iOS 12.1 下，底部 Tab 在打开新页面后回来会先收缩再正常显示」问题
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
    
    //字体大小，颜色（未被选中时）
    //    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Gray_Text_COLOR,NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateNormal];

    //字体大小，颜色（被选中时）
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      [UIColor redColor],NSForegroundColorAttributeName,
                                                      [UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]
                                            forState:UIControlStateSelected];
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
