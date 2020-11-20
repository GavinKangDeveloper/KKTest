//
//  UITextView+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "UITextView+FMCategory.h"
#import "UIView+FMCategory.h"

@implementation UITextView (FMCategory)
- (void)fm_setLineSpace:(CGFloat)space
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = space;
    [text addAttribute:NSParagraphStyleAttributeName
                 value:paragraphStyle
                 range:NSMakeRange(0, self.attributedText.length)];
    [self setAttributedText: text];
}

- (void)fm_setTextColor:(UIColor *)textColor range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttribute: NSForegroundColorAttributeName
                 value: textColor
                 range: range];
    [self setAttributedText: text];
}
- (CGFloat)fm_HeightToThisFit{
    CGSize size = [self sizeThatFits:CGSizeMake(self.fm_width, MAXFLOAT)];
    NSInteger h = size.height + 1;
    return h;
}
@end
