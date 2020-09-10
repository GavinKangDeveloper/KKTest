//
//  KKSecondVC.m
//  KKTest
//
//  Created by ZKKMBP on 2020/7/22.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKSecondVC.h"
#import "KKThridVC.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface KKSecondVC ()
@property (nonatomic, strong) UIImageView *imgV;
@end

@implementation KKSecondVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"第二";
   
    self.fd_interactivePopDisabled = NO;
    
//    //去掉透明后导航栏下边的黑边
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 414, 196)];
    self.imgV.image = [UIImage imageNamed:@"home_bill_top_bg"];
    [self.view addSubview:self.imgV];

    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 44, 60, 40)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self
                action:@selector(onBackButtonClicked)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 44, 414 - 200, 44)];
    titleLbl.font = [UIFont boldSystemFontOfSize:17];
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.text = @"我是第二";
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLbl];

}

- (void)onBackButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonClicked:(UIButton *)sender {
    [self gotoThridVC];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
}

- (void)gotoThridVC {
    
    KKThridVC * VC = [[KKThridVC  alloc] init];
       
    [self.navigationController pushViewController:VC animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
