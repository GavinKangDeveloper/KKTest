//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate ,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;
@property (weak, nonatomic) IBOutlet UITextView *textV;
@property (weak, nonatomic) IBOutlet UITextField *textF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textV.delegate = self;
    

}

- (IBAction)onButtonClicked:(UIButton *)sender {
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
}


@end
