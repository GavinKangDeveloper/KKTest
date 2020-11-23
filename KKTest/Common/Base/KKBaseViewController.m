//
//  KKBaseViewController.m
//  App
//
//  Created by kangkang zhu on 2018/10/18.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKBaseViewController.h"

@interface KKBaseViewController ()

@end

@implementation KKBaseViewController

- (instancetype)init {
    if (self = [super init]) {
        // push时隐藏底部tab栏，一定要放在init处理，放到viewDidLoad就晚了，view已经出来
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = kColorOfTableViewBackground;
    // Do any additional setup after loading the view.
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
