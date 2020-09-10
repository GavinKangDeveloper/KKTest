//
//  KKThridVC.m
//  KKTest
//
//  Created by ZhuKangKang on 2020/9/10.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKThridVC.h"

@interface KKThridVC ()

@end

@implementation KKThridVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我是第三";
    
    self.navigationController.navigationBar.translucent=NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
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
