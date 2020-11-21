//
//  YSControlManager.h
//  xinli001
//
//  Created by KenmuHuang on 16/8/31.
//  Copyright © 2016年 xinli001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSControlManager : NSObject

+ (UILabel *)labelWithText:(NSString *)text attributeText:(NSAttributedString *)attributeText font:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor  backgroundColor:(UIColor *)backgroundColor;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment) textAlignment;
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment) textAlignment;
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment) textAlignment numberOfLines:(NSInteger)numberOfLines;
+ (UILabel *)labelWithAttributeText:(NSAttributedString *)attributeText font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment) textAlignment;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines;
+ (UILabel *)labelWithAttributeText:(NSAttributedString *)attributeText font:(UIFont *)font textColor:(UIColor *)textColor;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment;
+ (UILabel *)labelWithAttributeText:(NSAttributedString *)attributeText font:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment;
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;
+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor;
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor textAlignment:(NSTextAlignment)textAlignment;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines;

+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image titleFont:(UIFont *)titleFont cornerRadius:(CGFloat)cornerRadius normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor backgroundColor:(UIColor *)backgroundColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor backgroundImage:(UIImage *)backgroundImage;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont cornerRadius:(CGFloat)cornerRadius normalTitleColor:(UIColor *)normalTitleColor backgroundColor:(UIColor *)backgroundColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor;
+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image;
+ (UIButton *)buttonWithImage:(UIImage *)image;
+ (UIButton *)buttonWithBackgroundImage:(UIImage *)backgroundImage;
+ (UIButton *)buttonWithBackgroundImage:(UIImage *)backgroundImage cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor;
+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIButton *)buttonWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor backgroundColor:(UIColor *)backgroundColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;
+ (UIButton *)buttonWithTitleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor backgroundImage:(UIImage *)backgroundImage;
+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor;
+ (UIButton *)buttonWithImage:(UIImage *)image normalTitleColor:(UIColor *)normalTitleColor titleFont:(UIFont *)titleFont;

+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode) contentMode;
+ (UIImageView *)imageViewWithCornerRadius:(CGFloat)cornerRadius;
+ (UIImageView *)imageViewWithCornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor;
+ (UIImageView *)imageViewWithCornerRadius:(CGFloat)cornerRadius contentMode:(UIViewContentMode) contentMode;
+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode) contentMode;
+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName cornerRadius:(CGFloat)cornerRadius ;
+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName;
+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName;
+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIImageView *)imageViewWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgroundColor;
+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName contentMode:(UIViewContentMode)contentMode;

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType font:(UIFont *)font;
+ (UITextField *)textFieldWithAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder keyboardType:(UIKeyboardType)keyboardType font:(UIFont *)font;
+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType font:(UIFont *)font textColor:(UIColor *)textColor delegate:(id)delegate tag:(NSInteger)tag;
+ (UITextField *)textFieldWithAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder keyboardType:(UIKeyboardType)keyboardType font:(UIFont *)font textColor:(UIColor *)textColor delegate:(id)delegate tag:(NSInteger)tag;
+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor borderStyle:(UITextBorderStyle)borderStyle cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat) borderWidth borderColor:(UIColor *)borderColor leftViewMode:(UITextFieldViewMode)leftViewMode clearButtonMode:(UITextFieldViewMode)clearButtonMode;

@end
