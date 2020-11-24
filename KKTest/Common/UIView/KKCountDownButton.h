//
//  KKCountDownButton.h
//  KKTest
//
//  Created by ZhuKangKang on 2020/11/24.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKCountDownButton : UIButton

- (void)startTimer:(NSUInteger)seconds;
- (void)stopTimer;


@end

NS_ASSUME_NONNULL_END
