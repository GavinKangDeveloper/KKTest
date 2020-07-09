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
@end

@interface ViewController () <UIScrollViewDelegate ,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;
@property (weak, nonatomic) IBOutlet UITextView *textV;
@property (weak, nonatomic) IBOutlet UITextField *textF;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _group = dispatch_group_create();
        
    //第一个参数是优先级，第二个参数保留将来使用。传递除零以外的任何值都可能导致空返回值。
    _globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.textV.delegate = self;
}

- (IBAction)onButtonClicked:(UIButton *)sender {
   
    [self dispatchGroupEnterAndLeave];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self afterDelay];
//    [self dispatchOnce];
    [self changeImageDate];
}

#pragma mark - 多线程的应用场景
///延时操作
- (void)afterDelay {
    NSLog(@"-----11---");
    [NSThread sleepForTimeInterval:1.0];
    NSLog(@"-----22---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"-----33---");
    });
    [self performSelector:@selector(sleepAction) withObject:nil afterDelay:3.0];
}

- (void)sleepAction {
    NSLog(@"-----44---");
}

/// 只执行一次的内容、单例中用的比较多
- (void)dispatchOnce {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"----dispatch_once_t------");
    });
    NSLog(@"----22------");
}

/// 多任务的依赖
- (void)groupEnterAndleave {
  
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    NSLog(@"");
    dispatch_group_leave(group);
     
    dispatch_group_enter(group);
    
    dispatch_group_leave(group);

    //等待 group 中的全部任务执行完毕，才会回到主线程执行这里的任务。
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //主线程
       
    });
}

- (void)changeImageDate {
    dispatch_group_t imgGroup = dispatch_group_create();
    //第一个参数是优先级，第二个参数保留将来使用。传递除零以外的任何值都可能导致空返回值。
    dispatch_queue_t imgGlobalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSDate* startTime = [NSDate date];
    UIImageJPEGRepresentation([UIImage imageNamed:@"big_img"], 0.5);
    double deltaTime = [[NSDate date] timeIntervalSinceDate:startTime];
    NSLog(@"cost time = %f---", deltaTime);//0.173117
    
    NSDate* groupTime = [NSDate date];
    dispatch_group_async(imgGroup, imgGlobalQueue, ^{
        
        NSLog(@"-----------111----%@",[NSThread currentThread]);
        UIImageJPEGRepresentation([UIImage imageNamed:@"big_img"], 0.5);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            double resultTime = [[NSDate date] timeIntervalSinceDate:groupTime];
            NSLog(@"cost groupTime = %f", resultTime);//0.039186
        });
        
    });
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
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    NSLog(@"-----------000");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"-----------111");
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"-----------222");
        dispatch_group_leave(group);
    });
        
    //等待 group 中的全部任务执行完毕，才会回到主线程执行这里的任务。
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //主线程
       NSLog(@"-----------333");
    });
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"-----------444");

}


@end
