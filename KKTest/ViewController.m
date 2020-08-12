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

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textV.delegate = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self textArr];
//        [self textDic];
    });
}

- (void)textArr {
    NSArray *arr = [NSArray arrayWithObjects:@"1",@"2", nil];
    
//    NSLog(@"-------测试数据越界---2--%@",arr[2]);
    
    NSMutableArray *arrs = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
//    [arrs removeObjectAtIndex:3];
//    [arrs removeObjectsInRange:NSMakeRange(1, 2)];
    [arrs replaceObjectAtIndex:2 withObject:<#(nonnull id)#>];
    NSLog(@"-------测试数据越界--3---%@",arrs);
}

- (void)textDic {

    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[@"A",@"B",@"C"]forKeys:@[@"A1",@"A2",@"A3",@"A4"]];
//    NSLog(@"-------测试字典---1--%@",dic);
    
    NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithObjects:@[@"A",@"B",@"C"]forKeys:@[@"A1",@"A2",@"A3"]];
    
    [dics removeObjectForKey:@"F"];
     NSLog(@"-------测试字典---1--%@",dics);
}

- (IBAction)onButtonClicked:(UIButton *)sender {
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self gotoSecondVC];
     [self textArr];
}

- (void)gotoSecondVC {
    KKSecondVC * VC = [[KKSecondVC  alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


@end
