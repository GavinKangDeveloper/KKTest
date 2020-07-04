//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
#import "KKSecondVC.h"
#import "KKThirdVC.h"

@interface ViewController () {
    // 定义一个并发队列
    dispatch_queue_t concurrent_queue;
    
    // 用户数据中心, 可能多个线程需要数据访问
    NSMutableDictionary *userCenterDic;
}

@property (weak, nonatomic) IBOutlet UIButton *btnTemp;

@end

@implementation ViewController



#pragma mark --- sb相关的life circle
//执行顺序1
// 当使用storyBoard时走的第一个方法。这个方法而不走initWithNibName方法。
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
     NSLog(@"%@-----%s", NSStringFromClass(self.class),__func__);
    if (self = [super initWithCoder:aDecoder]) {
          //这里仅仅是创建self，还没有创建self.view所以不要在这里设置self.view相关操作
     }
    return self;
}
#pragma mark --- life circle
//执行顺序1
// 当控制器不是SB时，都走这个方法。(xib或纯代码都会走这个方法)
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog(@"%@------%s", NSStringFromClass(self.class),__func__);
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //这里仅仅是创建self，还没有创建self.view所以不要在这里设置self.view相关操作
    }
    return self;
}

//执行顺序2
// xib或者 SB 加载完成时调用，纯代码不会调用。系统自行调用
- (void)awakeFromNib {
    [super awakeFromNib];
     //当awakeFromNib方法被调用时，所有视图的outlet和action已经连接，但还没有被确定。
     NSLog(@"%@------%s",NSStringFromClass(self.class), __func__);
}

//执行顺序3
// 加载控制器的self.view视图。(默认从nib)
- (void)loadView {
    //该方法一般开发者不主动调用，应该由系统自行调用。
    //系统会在self.view为nil的时候调用。当控制器生命周期到达需要调用self.view的时候会自行调用。
    //或者当我们设置self.view=nil后，下次需要用到self.view时，系统发现self.view为nil，则会调用该方法。
    //该方法一般会首先根据nibName去找对应的nib文件然后加载。
    //如果nibName为空或找不到对应的nib文件，则会创建一个空视图(这种情况一般是纯代码)
    NSLog(@"%@------%s",NSStringFromClass(self.class), __func__);
    //该方法比较特殊，如果重写不能调用父类的方法[super loadView];
//    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [super loadView];
}

//执行顺序4
//视图控制器中的视图加载完成，viewController自带的view加载完成后会第一个调用的方法
- (void)viewDidLoad {
    //当self.view被创建后，会立即调用该方法。一般用于完成各种初始化操作
    NSLog(@"%@-----%s",NSStringFromClass(self.class), __func__);
    [super viewDidLoad];
}

//执行顺序5
//视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@------%s",NSStringFromClass(self.class), __func__);
    [super viewWillAppear:animated];
}

//执行顺序6
// view 即将布局其 Subviews
- (void)viewWillLayoutSubviews {
    //view即将布局它的Subviews子视图。 当view的的属性发生了改变。
    //需要要调整view的Subviews子视图的位置，在调整之前要做的工作都可以放在该方法中实现
    NSLog(@"%@-----%s",NSStringFromClass(self.class), __func__);
    [super viewWillLayoutSubviews];
}

//执行顺序7
// view 已经布局其 Subviews
- (void)viewDidLayoutSubviews {
    //view已经布局其Subviews，这里可以放置调整完成之后需要做的工作
    NSLog(@"%@-----%s", NSStringFromClass(self.class),__func__);
    [super viewDidLayoutSubviews];
}

//执行顺序8
//视图已经出现
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%@-----%s", NSStringFromClass(self.class),__func__);
    [super viewDidAppear:animated];
}

//执行顺序9
//视图将要消失
- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"%@------%s", NSStringFromClass(self.class),__func__);
    [super viewWillDisappear:animated];
}

//执行顺序10
//视图已经消失
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"%@------%s",NSStringFromClass(self.class), __func__);
    [super viewDidDisappear:animated];
}

//执行顺序11
// 视图被销毁
- (void)dealloc {
    //系统会在此时释放掉init与viewDidLoad中创建的对象
    NSLog(@"%@------%s",NSStringFromClass(self.class), __func__);
}

//执行顺序12
//出现内存警告  //模拟内存警告:点击模拟器->hardware-> Simulate Memory Warning
- (void)didReceiveMemoryWarning {
    //在内存足够的情况下，app的视图通常会一直保存在内存中，但是如果内存不够，一些没有正在显示的viewController就会收到内存不足的警告。
    //然后就会释放自己拥有的视图，以达到释放内存的目的。但是系统只会释放内存，并不会释放对象的所有权，所以通常我们需要在这里将不需要显示在内存中保留的对象释放它的所有权，将其指针置nil。
    NSLog(@"%s", __func__);
    [super didReceiveMemoryWarning];
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    // 通过宏定义 DISPATCH_QUEUE_CONCURRENT 创建一个并发队列
//    concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
//    // 创建数据容器
//    userCenterDic = [NSMutableDictionary dictionary];
//
//}

- (IBAction)onButtonClicked:(UIButton *)sender {
    
}

- (id)objectForKey:(NSString *)key {
    __block id obj;
    // 同步读取指定数据
    dispatch_sync(concurrent_queue, ^{
        
        NSLog(@"---objectForKey------%@",[NSThread currentThread]);
        
        obj = [userCenterDic objectForKey:key];
    });
    return obj;
}

- (void)setObject:(id)obj forKey:(NSString *)key {
    // 异步栅栏调用设置数据
    dispatch_barrier_async(concurrent_queue, ^{
        NSLog(@"---setObject------%@",[NSThread currentThread]);
        [self->userCenterDic setObject:obj forKey:key];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static NSInteger i = 0;
    if (i % 2 == 0) {
        [self.navigationController pushViewController:[KKSecondVC new] animated:YES];
//        [self presentViewController:[KKSecondVC new] animated:YES completion:nil];
    } else {
        [self.navigationController pushViewController:[KKThirdVC new] animated:YES];
//        [self presentViewController:[KKThirdVC new] animated:YES completion:nil];
    }
    i++;
}

- (void)testBarrierAsync {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    //创建一个并行队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.gcd.barrier.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //并行操作
    void (^blk1)() = ^{
         NSLog(@"---1------%@",[NSThread currentThread]);
    };
    
    void (^blk2)() = ^{
        dispatch_semaphore_signal(semaphore);
        NSLog(@"---2------%@",[NSThread currentThread]);
    };
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    // dosth2 ,只有当dosth1执行完,信号量+1之后,才会执行这里
    
    void (^blk3)() = ^{
        NSLog(@"---3------%@",[NSThread currentThread]);
    };
    void (^blk4)() = ^{
        NSLog(@"---4------%@",[NSThread currentThread]);
    };
    void (^blk5)() = ^{
        NSLog(@"---5------%@",[NSThread currentThread]);
    };
    void (^blk6)() = ^{
        NSLog(@"---6------%@",[NSThread currentThread]);
    };
    
    //栅栏函数执行操作
    void (^barrierBlk)() = ^{
        [NSThread sleepForTimeInterval:3.0];
        NSLog(@"---barrierBlk------%@",[NSThread currentThread]);
    };
    
    //执行所有操作
    dispatch_async(concurrentQueue, blk1);
    dispatch_async(concurrentQueue, blk2);
    dispatch_async(concurrentQueue, blk3);
    dispatch_barrier_async(concurrentQueue, barrierBlk);
    dispatch_async(concurrentQueue, blk4);
    dispatch_async(concurrentQueue, blk5);
    dispatch_async(concurrentQueue, blk6);
}



@end
