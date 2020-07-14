//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"
#import "KKBinaryTree.h"

@interface ViewController ()<UIScrollViewDelegate ,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;
@property (weak, nonatomic) IBOutlet UITextView *textV;
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property (strong, nonatomic) NSMutableArray<NSNumber *> *arrsResult;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textV.delegate = self;
    self.arrsResult = [NSMutableArray array];

}

- (IBAction)onButtonClicked:(UIButton *)sender {
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self findingPrimeNumbers];
//    [self createWithBinaryTree];
//    [self listSubviewsOfView:self.view];
    
//   [self fibonacciWithNum:7];
//   NSInteger sum = [self recursiveComputationFibonacciWithNum:7];
//   NSLog(@"-sum-----%ld",(long)sum);

    for (int i = 0; i < 10; i++) {
        [self.arrsResult addObject:@(arc4random()%100)];
    }
//
//     CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
//     NSInteger sum =  [self frogsJumpTheSteps:40];
//     CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
//     NSLog(@"-sum-----%ld-----%f",(long)sum,end - start);
//
//    CFAbsoluteTime optimizationStart = CFAbsoluteTimeGetCurrent();
//    NSInteger optimizationSum =  [self optimizationFrogsJumpTheSteps:40];
//    CFAbsoluteTime optimizationEnd = CFAbsoluteTimeGetCurrent();
//    NSLog(@"-sum-----%ld-----%f",(long)optimizationSum,optimizationEnd - optimizationStart);
    
//    [self bubbleAscendingSort:self.arrsResult];
//    [self bubbleDescendingSort:self.arrsResult];
    
//    NSMutableArray * arr = @[@16,@9,@7,@12,@8,@13,@10,@5,@3,@2,@1].mutableCopy;
////    [self bubbleDescendingSort:arr];
//    [self optimizationBubbleDescendingSort:arr];
    
    
    
}


#pragma mark - Hash 算法
- (void)hash {
    
}


#pragma mark - 冒泡排序
//冒泡 - 降序排序
- (void)bubbleDescendingSort:(NSMutableArray *)arr {
    int count  = 0;
    int forcount  = 0;
    for (int i = 0; i < arr.count; i ++) {
        forcount++;
        for (int j = 0; j < arr.count - 1 - i; j ++) {
            count++;
            if ([arr[j] intValue] < [arr[j+1] intValue]) {
                int num = [arr[j] intValue];
                arr[j] = arr[j+1];
                arr[j+1] = [NSNumber numberWithInt:num];
            }
        }
    }
    NSLog(@"---循环次数：%d",forcount);
    NSLog(@"----共 %d 次比较",count);
    NSLog(@"冒泡降序排序后结果：%@", arr);
}

//冒泡 - 升序排序
- (void)bubbleAscendingSort:(NSMutableArray *)arr {
    for (int i = 0; i < arr.count; i ++) {
        for (int j = 0; j < arr.count - 1 -i; j ++) {
            if ([arr[j] intValue] > [arr[j+1] intValue]) {
                [arr exchangeObjectAtIndex:j+1 withObjectAtIndex:j];
            }
        }
    }
    NSLog(@"冒泡升序排序后结果：%@", arr);
}

//优化冒泡排序
- (void)optimizationBubbleDescendingSort:(NSMutableArray *)arr {
    int count  = 0;
    int forcount  = 0;
    BOOL flag = YES;
    for (int i = 0; i < arr.count && flag; i ++) {
       flag = NO;
       forcount++;
       for (int j = 0; j < arr.count - 1 - i; j ++) {
           count++;
           if ([arr[j] intValue] < [arr[j+1] intValue]) {
               int num = [arr[j] intValue];
               arr[j] = arr[j+1];
               arr[j+1] = [NSNumber numberWithInt:num];
               flag = YES;
           }
       }
    }
    
    NSLog(@"循环次数：%d",forcount);
    NSLog(@"共 %d 次比较",count);
    NSLog(@"冒泡降序排序后结果：%@", arr);
}


#pragma mark - 青蛙跳台阶--递归算法
- (NSInteger)frogsJumpTheSteps:(NSInteger)num {
    if (num < 1) {
        return 0;
    }
    if (num <= 2) {
        return num;
    }
    return [self frogsJumpTheSteps:(num - 1)] + [self frogsJumpTheSteps:(num - 2)];
}

#pragma mark - 使用 重复计算 优化优化递归算法
- (NSInteger)optimizationFrogsJumpTheSteps:(NSInteger)num {
    if (num < 1) {
        return 0;
    }
    if (num <= 2) {
        return num;
    }
    if ([self.arrsResult[num] integerValue] != -1) {
        return [self.arrsResult[num] integerValue];
    }
    NSInteger sum = [self optimizationFrogsJumpTheSteps:(num - 1)] + [self optimizationFrogsJumpTheSteps:(num - 2)];
    self.arrsResult[num] = @(sum);
    return sum;
}

#pragma mark - 斐波那契数列
//后面的每一项数字都是前面两项数字的和
- (NSInteger)fibonacciWithNum:(NSUInteger)num {
    if (num <= 1) {
      return num;
    }
    NSInteger first = 0;
    NSInteger second = 1;
    for (int i = 0; i < num - 1; i++) {
        NSInteger sum = first + second;
        first = second;
        second = sum;
    }
    NSLog(@"------%ld",(long)second);
    return second;
}

- (NSInteger)recursiveComputationFibonacciWithNum:(NSInteger)num {
    if (num <= 1) {
         return num;
    }
    NSInteger fibonacciOne = [self recursiveComputationFibonacciWithNum:(num - 1)];
    NSInteger fibonacciTwo = [self recursiveComputationFibonacciWithNum:(num - 2)];
    NSInteger fibonacci = fibonacciOne + fibonacciTwo;
    return fibonacci;
}

#pragma mark - 二叉树
- (void)createWithBinaryTree {
    KKBinaryTree *binaryTree = [KKBinaryTree createWithArray:@[@(8),@(5),@(10),@(3),@(6),@(9),@(14)]];
    
    [binaryTree prePrint];
    [binaryTree prePrintWithoutRecursion];
    
//    [binaryTree print];
}

#pragma mark - 输出2~100的素数
- (void)findingPrimeNumbers {
    int i = 0;
    int j = 0;
    int count = 0;//储存2-100之间的素数个数
    BOOL flag = true;
    
//用处：在当一个数有【除1和它本身之外的因数】时，使其值变为false，以便进入下一次循环
    for (i = 2; i <= 100; i++) {
        flag = true;
        for (j = 2; j < i; j++) {
            //用此for循环的数字来判断i是否有【除1和它本身之外的因数】
            if (i % j == 0) {//如果i%j==0,说明i有【除1和它本身之外的因数】
                flag = false;
                break;
            }
        }
        if (flag == true) {
            count++;//存储素数的总和加1
            NSLog(@"从2-100之间的素数有：%d" , i);
        }
    }
    NSLog(@"从2-100之间的素数个数有：%d" , count);//总共有 25 个素数/质数
}

#pragma mark - 查找某个 View 下面所有的子视图
- (void)listSubviewsOfView:(UIView *)view {
    NSArray *subviews = [view subviews];
    if ([subviews count] == 0) {
      return;
    }
    
    for (UIView *subview in subviews) {
        NSLog(@"---View 的子视图-----%@", subview);
        [self listSubviewsOfView:subview];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
  NSLog(@"---textViewDidBeginEditing---------%@",textView.text);
}

-(void)textViewDidChange:(UITextView *)textView {
   NSLog(@"---textViewDidChange--------%@",textView.text);
}

-(void)textViewDidEndEditing:(UITextView *)textView{
   NSLog(@"---textViewDidEndEditing---------%@",textView.text);
}


@end
