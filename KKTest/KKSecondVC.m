//
//  KKSecondVC.m
//  KKTest
//
//  Created by ZKKMBP on 2020/7/22.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "KKSecondVC.h"
#import <NSTimer+KKWeakTimer.h>

@interface KKSecondVC ()

@end

@implementation KKSecondVC

- (void)dealloc {
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"--KKSecondVC-------viewWillAppear--");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"--KKSecondVC------viewWillDisappear---");
}

- (void)viewDidLoad {
    [super viewDidLoad];

  
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
