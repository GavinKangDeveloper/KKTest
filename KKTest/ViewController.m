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
//    KKSecondVC *VC = [[KKSecondVC alloc] init];
//
//    [self.navigationController pushViewController:VC animated:YES];
 
    NSArray *arr1 = @[@"abc",@"你好"];
    NSArray *arr2 = @[@{@"111":@"222"},@{@"222":@"222"},[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    NSArray *arr3 = @[[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self getPureString:arr1];
    
    NSLog(@"----22---%@",[self getPureString:arr2]);
    
    NSLog(@"----33---%@",[self getPureString:arr3]);
    
}

- (NSString *)getPureString:(NSArray *)array {
    NSMutableArray *filterArray = [NSMutableArray array];
    if ([array isKindOfClass:NSArray.class]) {
        for (id obj in array) {
            if ([obj isKindOfClass:NSString.class] || [obj isKindOfClass:NSDictionary.class]) {
                [filterArray addObject:obj];
            }
        }
    }
    if (![NSJSONSerialization isValidJSONObject:array]) {
        return @"这是不合格的数据";
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:filterArray
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //去除空格和回车：
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
//    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return jsonStr;
}

- (void)startAnimationShakeWithDuration:(CFTimeInterval)duration repeatCount:(NSInteger)repeatCount key:(NSString *)key {
    // 获取到当前的View
    CALayer *viewLayer = self.textV.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 5, position.y);
    CGPoint y = CGPointMake(position.x - 5, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:duration];
    // 设置次数
    [animation setRepeatCount:repeatCount];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:key];
}

- (NSDate *)dateFromString22:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

- (NSDate *)dateFormat:(NSString *)format {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone =  [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return date;
}

//传入今天的时间，返回明天的时间
- (NSString *)getAfterNumDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

- (NSDate *)localeDate {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone =  [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    return [date dateByAddingTimeInterval:interval];
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
