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

//#import "KKSwiftVC-Swift.h"

#import "KKTest-Swift.h"

@interface ViewController ()<UIScrollViewDelegate ,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;
@property (weak, nonatomic) IBOutlet UITextView *textV;
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property (nonatomic, strong) NSMutableArray *arrs;

@end

@implementation ViewController

/// 测试 git 添加、推送的流程
- (void)viewDidLoad {
    [super viewDidLoad];

    self.textV.delegate = self;
 
    self.arrs = [[NSMutableArray alloc] initWithObjects:@"0", nil];
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    KKSwiftVC *VC = [[KKSwiftVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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
