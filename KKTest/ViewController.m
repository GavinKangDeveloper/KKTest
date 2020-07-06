//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"
#import "KKStudent.h"
#import <objc/message.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;
@property (strong, nonatomic) NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:@"name3" options:options context:nil];
    
    [self setValue:@"23" forKey:@"name33"];
    [self valueForKey:@"name32"];

    self.name = @"kk";
}

- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"不能将%@设成nil", key);
}

// 当监听对象的属性值发生改变时，就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"监听到%@的%@属性值改变了 - %@ - %@", object, keyPath, change, context);
}


- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"----出现异常，该key不存在%@",key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"出现异常，该key不存在%@", key);
}

- (IBAction)onButtonClicked:(UIButton *)sender {
    self.name = @"qq";
}

- (void)setName:(NSString *)name {
//    _name = name;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    

}



@end
