//
//  KKBaseNavigationController.m
//  App
//
//  Created by kangkang zhu on 2018/10/29.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKBaseNavigationController.h"

@interface KKBaseNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic,assign)BOOL isPushing;

@end

@implementation KKBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate =self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.isPushing) {
        //如果已经isPushing,但尚未didShow,则返回不再二次push
        return;
    }else{
        self.isPushing = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //didShow之后,重置isPushing状态为NO,以达到下次可以正常push的目的;
    self.isPushing = NO;
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
