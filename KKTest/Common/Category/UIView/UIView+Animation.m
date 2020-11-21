//
//  UIView+Animation.m
//  xinli001
//
//  Created by KenmuHuang on 2017/9/11.
//  Copyright © 2017年 xinli001. All rights reserved.
//

#import "UIView+Animation.h"

static NSString *const kAnimationKeyOfScaleAnimation = @"kAnimationKeyOfScaleAnimation";

@implementation UIView (Animation)

- (void)km_addScaleAnimation {
    [self.layer removeAnimationForKey:kAnimationKeyOfScaleAnimation];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.3;
    animation.values = @[ @(0.6), @(1.0), @(1.1), @(1.0) ];
    [self.layer addAnimation:animation forKey:kAnimationKeyOfScaleAnimation];
    self.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
}

- (void)km_removeScaleAnimation {
    [self km_removeScaleAnimationWithSelector:@selector(removeFromSuperview)];
}

- (void)km_removeScaleAnimationWithSelector:(SEL)selector {
    [self.layer removeAnimationForKey:kAnimationKeyOfScaleAnimation];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.2;
    animation.values = @[ @(1.0), @(0.9), @(0.8), @(0.7), @(0.6), @(0.5), @(0.4), @(0.3), @(0.2), @(0.1), @(0.0) ];
    [self.layer addAnimation:animation forKey:kAnimationKeyOfScaleAnimation];
    self.layer.transform = CATransform3DMakeScale(0.0, 0.0, 1.0);
    
    UIView *superview = self.superview;
    if (superview && [superview respondsToSelector:selector]) {
        [superview performSelector:selector
                        withObject:nil
                        afterDelay:0.3];
    }
}

@end
