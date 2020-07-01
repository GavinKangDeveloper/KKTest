//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

}

- (IBAction)onButtonClicked:(UIButton *)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"1");
        [self addObserver];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
            [self performSelector:@selector(testPerform) withObject:nil afterDelay:0];
         
//        [self performSelector:@selector(testPerform) withObject:nil afterDelay:0.0 inModes:@[UITrackingRunLoopMode]];
        
        [runloop run];
            NSLog(@"3");
        });
    
}

- (void)testPerform{
    NSLog(@"2");
}

- (void)addObserver {
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry: {
                NSLog(@"进入runloop");
            }
                break;
            case kCFRunLoopBeforeTimers:{
                NSLog(@"即将触发 timers 回调");
            }
                break;
            case kCFRunLoopBeforeSources:{
                NSLog(@"即将触发 sources 回调");
            }
                break;
            case kCFRunLoopBeforeWaiting:{
                NSLog(@"即将进入休眠");
            }
                break;
            case kCFRunLoopAfterWaiting:{
                NSLog(@"唤醒");
            }
                break;
            case kCFRunLoopExit:{
                NSLog(@"退出");
            }
                break;
            default:
                break;
        }
    });
    //将观察者添加到common模式下，这样当default模式和UITrackingRunLoopMode两种模式下都有回调。
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer ,kCFRunLoopCommonModes);
    CFRelease(observer);
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}



@end
