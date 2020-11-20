//
//  UITextField+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "UITextField+FMCategory.h"

@implementation UITextField (FMCategory)
- (void)fm_setPlaceholderWithFont:(UIFont *)font color:(UIColor *)placeholderColor
{
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder?:@"" attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:placeholderColor}];
}

@end
