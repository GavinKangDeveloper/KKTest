//
//  UILabel+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "UILabel+FMCategory.h"
#import "UIView+FMCategory.h"

@implementation UILabel (FMCategory)
- (void)fm_addAttributes:(NSDictionary *)attributes range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttributes:attributes
                  range:range];
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

- (void)fm_setFont:(UIFont *)font range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttribute: NSFontAttributeName
                 value: font
                 range: range];
    [self setAttributedText: text];
}

- (void)fm_setLineSpace:(CGFloat)space
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = space;
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    [text addAttribute:NSParagraphStyleAttributeName
                 value:paragraphStyle
                 range:NSMakeRange(0, self.attributedText.length)];
    [self setAttributedText: text];
}

- (void)fm_setLineSpace:(CGFloat)space range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = space;
    paragraphStyle.alignment = self.textAlignment;
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    [text addAttribute:NSParagraphStyleAttributeName
                 value:paragraphStyle
                 range:range];
    [self setAttributedText: text];
}

- (void)fm_setWordSpace:(CGFloat)space range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [text addAttribute:NSKernAttributeName
                 value:@(space)
                 range:range];
    [self setAttributedText: text];
}

- (void)fm_setBaselineOffset:(CGFloat)offset range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [text addAttribute:NSBaselineOffsetAttributeName
                 value:@(offset)
                 range:range];
    [self setAttributedText: text];
}

- (CGFloat)fm_contentHeight
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    NSDictionary *attributesDictionary = @{NSFontAttributeName:self.font,
                               NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX);
    CGRect labelRect = [self.text boundingRectWithSize:size
                                             options:NSStringDrawingUsesLineFragmentOrigin|                                    NSStringDrawingTruncatesLastVisibleLine|
                                                     NSStringDrawingUsesFontLeading
                                          attributes:attributesDictionary
                                             context:nil];
    return labelRect.size.height;
}
- (NSUInteger)fm_lineNumbers
{
    return self.fm_size.height / self.font.lineHeight;
}

@end
