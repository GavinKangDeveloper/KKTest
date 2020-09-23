//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"
#import "KKSecondVC.h"
#import "KKCommonManager.h"


@interface ViewController ()<UIScrollViewDelegate ,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;
@property (weak, nonatomic) IBOutlet UITextView *textV;
@property (weak, nonatomic) IBOutlet UITextField *textF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textV.delegate = self;
 
    KKCommonManager *managerShared = [KKCommonManager sharedManager];
    
    KKCommonManager *managerAlloc = [[KKCommonManager alloc] init];
    
    KKCommonManager *managerNew = [KKCommonManager new];
    
    KKCommonManager *managerCopy = [managerShared copy];
    
    KKCommonManager *managerMutableCopy = [managerShared mutableCopy];
    
    NSLog(@"-----managerShared-----%@",managerShared);
    NSLog(@"-----managerAlloc-----%@",managerAlloc);
    NSLog(@"-----managerNew-----%@",managerNew);
    NSLog(@"-----managerCopy-----%@",managerCopy);
    NSLog(@"-----managerMutableCopy-----%@",managerMutableCopy);
    
    
    [managerShared invalidate];
    
    KKCommonManager *managerShared2 = [KKCommonManager sharedManager];
    
    KKCommonManager *managerAlloc2 = [[KKCommonManager alloc] init];
    
    KKCommonManager *managerNew2 = [KKCommonManager new];
    
    KKCommonManager *managerCopy2 = [managerShared2 copy];
    
    KKCommonManager *managerMutableCopy2 = [managerShared2 mutableCopy];
    
    NSLog(@"-----managerShared2-----%@",managerShared2);
    NSLog(@"-----managerAlloc2-----%@",managerAlloc2);
    NSLog(@"-----managerNew2-----%@",managerNew2);
    NSLog(@"-----managerCopy2-----%@",managerCopy2);
    NSLog(@"-----managerMutableCopy2-----%@",managerMutableCopy2);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

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
