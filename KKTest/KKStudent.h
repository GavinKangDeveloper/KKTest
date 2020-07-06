//
//  KKStudent.h
//  KKTest
//
//  Created by ZKKMBP on 2020/7/5.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKStudent : NSObject
// 如果该方法只有声明没有实现,那么该方法一定不会放在方法列表中,外界一定不能直接调用到方法
- (void)study;

@end

NS_ASSUME_NONNULL_END
