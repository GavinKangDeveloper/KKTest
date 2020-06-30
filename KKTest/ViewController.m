//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
    dispatch_queue_t _globalQueue;
    dispatch_group_t _group;
}

@property (weak, nonatomic) IBOutlet UIButton *btnTemp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _group = dispatch_group_create();
        
    //第一个参数是优先级，第二个参数保留将来使用。传递除零以外的任何值都可能导致空返回值。
    _globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

}

- (IBAction)onButtonClicked:(UIButton *)sender {
   
    [self dispatchGroupEnterAndLeave];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


- (void)dispatchGroupAsync {
     dispatch_group_async(_group, _globalQueue, ^{
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               NSLog(@"-----------111");
           });
       });

       dispatch_group_async(_group, _globalQueue, ^{
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      NSLog(@"-----------2222");
                  });
       });
       
       dispatch_group_async(_group, _globalQueue, ^{
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      NSLog(@"-----------444");
                  });
       });
       
       //等待 group 中的全部任务执行完毕，才会回到主线程执行这里的任务。
       dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
           NSLog(@"-----------333");
       });
}

- (void)dispatchGroupEnterAndLeave {
    dispatch_group_enter(_group);
    NSLog(@"-----------000");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"-----------111");
        dispatch_group_leave(_group);
    });

    dispatch_group_enter(_group);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"-----------222");
        dispatch_group_leave(_group);
    });
        

    //等待 group 中的全部任务执行完毕，才会回到主线程执行这里的任务。
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        //主线程
       NSLog(@"-----------333");
    });
    
    NSLog(@"-----------444");

}



@end
