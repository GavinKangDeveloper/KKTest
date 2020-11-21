//
//  UIView+Animation.h
//  xinli001
//
//  Created by KenmuHuang on 2017/9/11.
//  Copyright © 2017年 xinli001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

- (void)km_addScaleAnimation;
- (void)km_removeScaleAnimation;
- (void)km_removeScaleAnimationWithSelector:(SEL)selector;

@end
