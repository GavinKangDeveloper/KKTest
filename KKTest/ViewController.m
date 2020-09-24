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
@property (weak, nonatomic) IBOutlet      UIButton *btnTemp;
@property (weak, nonatomic) IBOutlet UITextView* textV;
@property (weak, nonatomic) IBOutlet UITextField *    textF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textV.delegate = self;

    [self showParameter:1 parameter1:2 parameter2:3 parameter3parameter3parameter3parameter3parameter3parameter3:4 parameter4:5];
}

- (void)showParameter:(NSInteger)parameter parameter1:(NSInteger)parameter parameter2:(NSInteger)parameter parameter3parameter3parameter3parameter3parameter3parameter3:(NSInteger)parameter parameter4:(NSInteger)parameter {
//    注释1
    int index=0 ;
    //注释2
    if (index==1) {
        
    }else if (index == 2){//注释3
        
    }
    else if (index == 3) {// 注释4
        
    }
    
    switch (index) {
        case 1:{
            
        }
            
            break;
            
            case 2:
                
                break;
            case 3:
        {
                
            }
                
                break;
        default:
            break;
    }
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
