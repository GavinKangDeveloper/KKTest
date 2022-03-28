//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"
#import "KKSecondVC.h"
#import "NSDate+Extension.h"
#import "KKTestRACModel.h"

@interface ViewController ()<UIScrollViewDelegate ,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;
@property (weak, nonatomic) IBOutlet UITextView *textV;
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property (nonatomic, strong) NSMutableArray *arrs;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (nonatomic, strong) KKTestRACModel *racModel;

@end

@implementation ViewController

/// 测试 git 添加、推送的流程
- (void)viewDidLoad {
    [super viewDidLoad];

    self.textV.delegate = self;
 
    self.racModel = [KKTestRACModel new];
    self.racModel.name = @"kk1";
   
    self.lbl.text = self.racModel.name;
    
//    RAC(self.btnTemp, text) = [[[RACObserve(_itemModel,rightText) distinctUntilChanged] takeUntil:self.rac_prepareForReuseSignal] deliverOnMainThread];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    
    
}

- (IBAction)onButtonClicked:(UIButton *)sender {
    NSLog(@"--------");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)gotoSecondVC {
    KKSecondVC * VC = [[KKSecondVC  alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


@end
