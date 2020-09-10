//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"
#import "KKSecondVC.h"

@interface ViewController ()<UIScrollViewDelegate ,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;
@property (weak, nonatomic) IBOutlet UITextView *textV;
@property (weak, nonatomic) IBOutlet UITextField *textF;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textV.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self gotoSecondVC];
}

- (IBAction)onButtonClicked:(UIButton *)sender {
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)gotoSecondVC {
    KKSecondVC * VC = [[KKSecondVC  alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


@end
