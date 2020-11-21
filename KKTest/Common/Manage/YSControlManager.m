//
//  YSControlManager.m
//  xinli001
//
//  Created by KenmuHuang on 16/8/31.
//  Copyright © 2016年 xinli001. All rights reserved.
//

#import "YSControlManager.h"

@implementation YSControlManager

+ (UILabel *)labelWithText:(NSString *)text attributeText:(NSAttributedString *)attributeText font:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [UILabel new];
    if (font) {
        label.font = font;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    label.numberOfLines = numberOfLines;
    label.textAlignment = textAlignment;
    if (attributeText && attributeText.length > 0) {
        label.attributedText = attributeText;
    } else if (text) {
        label.text = text;
    }
    return label;
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor backgroundColor:(UIColor *)backgroundColor {
    UILabel *label = [self labelWithText:text
                           attributeText:nil
                                    font:font
                               textColor:textColor
                           numberOfLines:numberOfLines
                           textAlignment:textAlignment];
    if (cornerRadius > 0.0) {
        label.layer.cornerRadius = cornerRadius;
        label.layer.masksToBounds = YES;
    }
    
    if (borderColor) {
        label.layer.borderColor = borderColor.CGColor;
    } else if (backgroundColor) {
      label.layer.borderColor = backgroundColor.CGColor;
    }
    
    if (borderWidth > 0.0) {
        label.layer.borderWidth = borderWidth;
    }
    
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    
    return label;
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor {
    return [self labelWithText:text
                 attributeText:nil
                          font:font
                     textColor:textColor
                 numberOfLines:1
                 textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment) textAlignment {
    return [self labelWithText:text
                 attributeText:nil
                          font:font
                     textColor:textColor
                 numberOfLines:1
                 textAlignment:textAlignment];
}

+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment) textAlignment {
    return [self labelWithText:nil
                          font:font
                     textColor:textColor
                 textAlignment:textAlignment];
}

+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment) textAlignment numberOfLines:(NSInteger)numberOfLines {
    return [self labelWithText:nil
                 attributeText:nil
                          font:font
                     textColor:textColor
                 numberOfLines:numberOfLines
                 textAlignment:textAlignment];
}

+ (UILabel *)labelWithAttributeText:(NSAttributedString *)attributeText font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment) textAlignment {
    return [self labelWithText:nil
                 attributeText:attributeText
                          font:font
                     textColor:textColor
                 numberOfLines:1
                 textAlignment:textAlignment];
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines {
    return [self labelWithText:text
                 attributeText:nil
                          font:font
                     textColor:textColor
                 numberOfLines:numberOfLines
                 textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithAttributeText:(NSAttributedString *)attributeText font:(UIFont *)font textColor:(UIColor *)textColor {
    return [self labelWithText:nil
                 attributeText:attributeText
                          font:font
                     textColor:textColor
                 numberOfLines:1
                 textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment {
    return [self labelWithText:text
                 attributeText:nil
                          font:font
                     textColor:textColor
                 numberOfLines:numberOfLines
                 textAlignment:textAlignment];
}

+ (UILabel *)labelWithAttributeText:(NSAttributedString *)attributeText font:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment {
    return [self labelWithText:nil
                 attributeText:attributeText
                          font:font
                     textColor:textColor
                 numberOfLines:numberOfLines
                 textAlignment:textAlignment];
}

+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    return [self labelWithText:nil
                 attributeText:nil
                          font:font
                     textColor:textColor
                 numberOfLines:1
                 textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor {
    UILabel *label = [UILabel new];
    label.backgroundColor = backgroundColor;
    return label;
}

+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius {
    return [self labelWithText:nil
                          font:font
                     textColor:textColor
                 numberOfLines:1
                 textAlignment:NSTextAlignmentLeft
                  cornerRadius:cornerRadius
                   borderWidth:0.0
                   borderColor:nil
               backgroundColor:backgroundColor];
}

+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [self labelWithText:nil
                          font:font
                     textColor:textColor
                 numberOfLines:1
                 textAlignment:NSTextAlignmentLeft
                  cornerRadius:cornerRadius
                   borderWidth:borderWidth
                   borderColor:borderColor
               backgroundColor:backgroundColor];
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor textAlignment:(NSTextAlignment)textAlignment {
    return [self labelWithText:text
                          font:font
                     textColor:textColor
                 numberOfLines:1
                 textAlignment:textAlignment
                  cornerRadius:cornerRadius
                   borderWidth:borderWidth
                   borderColor:borderColor
               backgroundColor:backgroundColor];
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius {
    return [self labelWithText:text
                          font:font
                     textColor:textColor
               backgroundColor:backgroundColor
                  cornerRadius:cornerRadius
                   borderWidth:0.0
                   borderColor:nil
                 textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor numberOfLines:(NSInteger)numberOfLines {
    return [self labelWithText:nil
                 attributeText:nil
                          font:font
                     textColor:textColor
                 numberOfLines:numberOfLines
                 textAlignment:NSTextAlignmentLeft];
}

+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image titleFont:(UIFont *)titleFont cornerRadius:(CGFloat)cornerRadius normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor backgroundColor:(UIColor *)backgroundColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor backgroundImage:(UIImage *)backgroundImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title && title.length > 0) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (normalTitleColor) {
        [button setTitleColor:normalTitleColor forState:UIControlStateNormal];
    }
    if (highlightedTitleColor) {
        [button setTitleColor:highlightedTitleColor
                     forState:UIControlStateHighlighted];
    }
    if (selectedTitleColor) {
        [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    if (titleFont) {
        button.titleLabel.font = titleFont;
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (cornerRadius > 0.0) {
        button.layer.cornerRadius = cornerRadius;
        button.clipsToBounds = YES;
        button.layer.borderWidth = 0.5;
    }
    if (backgroundColor) {
        button.backgroundColor = backgroundColor;
    }
    
    if (borderWidth > 0.0) {
        button.layer.borderWidth = borderWidth;
    }
    
    if (borderColor) {
        button.layer.borderColor = borderColor.CGColor;
    } else if (backgroundColor) {
        button.layer.borderColor = backgroundColor.CGColor;
    }
    
    if (backgroundImage) {
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont cornerRadius:(CGFloat)cornerRadius normalTitleColor:(UIColor *)normalTitleColor backgroundColor:(UIColor *)backgroundColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [self buttonWithTitle:title
                           image:nil
                       titleFont:titleFont
                    cornerRadius:cornerRadius
                normalTitleColor:normalTitleColor
              selectedTitleColor:nil
           highlightedTitleColor:nil
                 backgroundColor:backgroundColor
                     borderWidth:borderWidth
                     borderColor:borderColor
                 backgroundImage:nil];
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont {
    return [self buttonWithTitle:title titleFont:titleFont backgroundColor:nil];
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [self buttonWithTitle:title
                       titleFont:titleFont
                    cornerRadius:cornerRadius
                normalTitleColor:normalTitleColor
                 backgroundColor:nil
                     borderWidth:borderWidth
                     borderColor:borderColor];
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor {
    return [self buttonWithTitle:title
                           image:nil
                       titleFont:titleFont
                    cornerRadius:0.0
                normalTitleColor:nil
              selectedTitleColor:nil
           highlightedTitleColor:nil
                 backgroundColor:backgroundColor
                     borderWidth:0.0
                     borderColor:nil
                 backgroundImage:nil];
}

+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image {
    return [self buttonWithTitle:title
                           image:image
                       titleFont:nil
                    cornerRadius:0.0
                normalTitleColor:nil
              selectedTitleColor:nil
           highlightedTitleColor:nil
                 backgroundColor:nil
                     borderWidth:0.0
                     borderColor:nil
                 backgroundImage:nil];
}

+ (UIButton *)buttonWithImage:(UIImage *)image {
    return [self buttonWithTitle:nil image:image];
}

+ (UIButton *)buttonWithBackgroundImage:(UIImage *)backgroundImage {
    UIButton *button = [UIButton new];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)buttonWithBackgroundImage:(UIImage *)backgroundImage cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [self buttonWithTitle:nil
                           image:nil
                       titleFont:nil
                    cornerRadius:cornerRadius
                normalTitleColor:nil
              selectedTitleColor:nil
           highlightedTitleColor:nil
                 backgroundColor:nil
                     borderWidth:borderWidth
                     borderColor:borderColor
                 backgroundImage:backgroundImage];
}

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor {
    UIButton *button = [UIButton new];
    if (backgroundColor) {
        button.backgroundColor = backgroundColor;
    }
    return button;
}

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [self buttonWithTitle:nil
                           image:nil
                       titleFont:nil
                    cornerRadius:cornerRadius
                normalTitleColor:nil
              selectedTitleColor:nil
           highlightedTitleColor:nil
                 backgroundColor:backgroundColor
                     borderWidth:borderWidth
                     borderColor:borderColor
                 backgroundImage:nil];
}

+ (UIButton *)buttonWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
    UIButton *button = [UIButton new];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor {
    return [self buttonWithTitle:title
                           image:nil
                       titleFont:titleFont
                    cornerRadius:0.0
                normalTitleColor:normalTitleColor
              selectedTitleColor:nil
           highlightedTitleColor:nil
                 backgroundColor:nil
                     borderWidth:0.0
                     borderColor:nil
                 backgroundImage:nil];
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor backgroundColor:(UIColor *)backgroundColor {
    return [self buttonWithTitle:title
                           image:nil
                       titleFont:titleFont
                    cornerRadius:0.0
                normalTitleColor:normalTitleColor
              selectedTitleColor:nil
           highlightedTitleColor:nil
                 backgroundColor:backgroundColor
                     borderWidth:0.0
                     borderColor:nil
                 backgroundImage:nil];
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius {
    return [self buttonWithTitle:title
                           image:nil
                       titleFont:titleFont
                    cornerRadius:cornerRadius
                normalTitleColor:normalTitleColor
              selectedTitleColor:nil
           highlightedTitleColor:nil
                 backgroundColor:backgroundColor
                     borderWidth:0.0
                     borderColor:nil
                 backgroundImage:nil];
}

+ (UIButton *)buttonWithTitleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor backgroundImage:(UIImage *)backgroundImage {
    return [self buttonWithTitle:nil
                           image:nil
                       titleFont:titleFont
                    cornerRadius:0.0
                normalTitleColor:normalTitleColor
              selectedTitleColor:nil
           highlightedTitleColor:nil
                 backgroundColor:nil
                     borderWidth:0.0
                     borderColor:nil
                 backgroundImage:backgroundImage];
}

+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image titleFont:(UIFont *)titleFont normalTitleColor:(UIColor *)normalTitleColor {
    return [self buttonWithTitle:title
                           image:image
                       titleFont:titleFont
                    cornerRadius:0.0
                normalTitleColor:normalTitleColor
              selectedTitleColor:nil
           highlightedTitleColor:nil
                 backgroundColor:nil
                     borderWidth:0.0
                     borderColor:nil
                 backgroundImage:nil];
}

+ (UIButton *)buttonWithImage:(UIImage *)image normalTitleColor:(UIColor *)normalTitleColor titleFont:(UIFont *)titleFont {
    return [self buttonWithTitle:nil
                           image:image
                       titleFont:titleFont
                    cornerRadius:0.0
                normalTitleColor:normalTitleColor
              selectedTitleColor:nil
           highlightedTitleColor:nil
                 backgroundColor:nil
                     borderWidth:0.0
                     borderColor:nil
                 backgroundImage:nil];
}

+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor backgroundColor:(UIColor *)backgroundColor
   contentMode:(UIViewContentMode) contentMode {
    UIImageView *imageView = [UIImageView new];
    if (normalImageName) {
        imageView.image = [UIImage imageNamed:normalImageName];
    }
    if (highlightedImageName) {
        imageView.highlightedImage = [UIImage imageNamed:highlightedImageName];
    }
    if (cornerRadius > 0.0) {
        imageView.layer.cornerRadius = cornerRadius;
        imageView.clipsToBounds = YES;
    }
    if (borderWidth > 0.0) {
        imageView.layer.borderWidth = borderWidth;
    }
    if (borderColor) {
        imageView.layer.borderColor = borderColor.CGColor;
    }
    if (backgroundColor) {
        imageView.backgroundColor = backgroundColor;
    }
    imageView.contentMode = contentMode;
    if (contentMode == UIViewContentModeScaleAspectFill) {
        imageView.clipsToBounds = YES;
    }
    return imageView;
}

+ (UIImageView *)imageViewWithCornerRadius:(CGFloat)cornerRadius {
    return [self imageViewWithNormalImageName:nil cornerRadius:cornerRadius];
}

+ (UIImageView *)imageViewWithCornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor {
    return [self imageViewWithNormalImageName:nil
                         highlightedImageName:nil
                                 cornerRadius:cornerRadius
                                  borderWidth:0.0
                                  borderColor:nil
                              backgroundColor:backgroundColor
                                  contentMode:UIViewContentModeScaleToFill];
}

+ (UIImageView *)imageViewWithCornerRadius:(CGFloat)cornerRadius contentMode:(UIViewContentMode)contentMode {
    return [self imageViewWithNormalImageName:nil
                         highlightedImageName:nil
                                 cornerRadius:cornerRadius
                                  borderWidth:0.0
                                  borderColor:nil
                              backgroundColor:nil
                                  contentMode:contentMode];
}

+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)contentMode {
    return [self imageViewWithCornerRadius:0.0 contentMode:contentMode];
}

+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName cornerRadius:(CGFloat)cornerRadius {
    return [self imageViewWithNormalImageName:normalImageName
                                 cornerRadius:cornerRadius
                                  borderWidth:0.0
                                  borderColor:nil];
}

+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName {
    return [self imageViewWithNormalImageName:normalImageName cornerRadius:0.0];
}

+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName {
    return [self imageViewWithNormalImageName:normalImageName
                         highlightedImageName:highlightedImageName
                                 cornerRadius:0.0
                                  borderWidth:0.0
                                  borderColor:nil
                              backgroundColor:nil
                                  contentMode:UIViewContentModeScaleToFill];
}

+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [self imageViewWithNormalImageName:normalImageName
                         highlightedImageName:nil
                                 cornerRadius:cornerRadius
                                  borderWidth:borderWidth
                                  borderColor:borderColor
                              backgroundColor:nil
                                  contentMode:UIViewContentModeScaleToFill];
}

+ (UIImageView *)imageViewWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [self imageViewWithNormalImageName:nil
                                 cornerRadius:cornerRadius
                                  borderWidth:borderWidth
                                  borderColor:borderColor];
}

+ (UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgroundColor {
    UIImageView *imageView = [UIImageView new];
    imageView.backgroundColor = backgroundColor;
    return imageView;
}

+ (UIImageView *)imageViewWithNormalImageName:(NSString *)normalImageName contentMode:(UIViewContentMode)contentMode {
    UIImageView *imageView = [self imageViewWithNormalImageName:normalImageName
                                           highlightedImageName:nil
                                                   cornerRadius:0.0
                                                    borderWidth:0.0
                                                    borderColor:nil
                                                backgroundColor:nil
                                                    contentMode:contentMode];
    return imageView;
}

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder attributedPlaceholder:(NSAttributedString *)attributedPlaceholder keyboardType:(UIKeyboardType)keyboardType font:(UIFont *)font {
    UITextField *textField = [UITextField new];
    textField.keyboardType = keyboardType;
    if (font) {
        textField.font = font;
    }
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (placeHolder) {
        textField.placeholder = placeHolder;
    } else if (attributedPlaceholder) {
        textField.attributedPlaceholder = attributedPlaceholder;
    }
    return textField;
}

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType font:(UIFont *)font {
    return [self textFieldWithPlaceHolder:placeHolder attributedPlaceholder:nil keyboardType:keyboardType font:font];
}

+ (UITextField *)textFieldWithAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
   keyboardType:(UIKeyboardType)keyboardType font:(UIFont *)font {
    return [self textFieldWithPlaceHolder:nil attributedPlaceholder:attributedPlaceholder keyboardType:keyboardType font:font];
}

+ (UITextField *)textFieldWithAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder keyboardType:(UIKeyboardType)keyboardType font:(UIFont *)font textColor:(UIColor *)textColor delegate:(id)delegate tag:(NSInteger)tag {
    UITextField *textAge = [UITextField new];
    textAge.textColor = textColor;
    textAge.clearButtonMode = UITextFieldViewModeWhileEditing;
    textAge.keyboardType = keyboardType;
    if (font) {
        textAge.font = font;
    }
    textAge.delegate = delegate;
    textAge.tag = tag;
    textAge.attributedPlaceholder = attributedPlaceholder;
    return textAge;
}

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType font:(UIFont *)font textColor:(UIColor *)textColor delegate:(id)delegate tag:(NSInteger)tag {
    UITextField *textAge = [UITextField new];
    textAge.textColor = textColor;
    textAge.clearButtonMode = UITextFieldViewModeWhileEditing;
    textAge.placeholder = placeHolder;
    textAge.keyboardType = keyboardType;
    if (font) {
        textAge.font = font;
    }
    textAge.delegate = delegate;
    textAge.tag = tag;
    return textAge;
}


+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor borderStyle:(UITextBorderStyle)borderStyle cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth
    borderColor:(UIColor *)borderColor leftViewMode:(UITextFieldViewMode)leftViewMode
    clearButtonMode:(UITextFieldViewMode)clearButtonMode {
    UITextField *phoneTextField = [UITextField new];
    phoneTextField.borderStyle = borderStyle;
    if (cornerRadius > 0.0) {
        phoneTextField.layer.cornerRadius = cornerRadius;
        phoneTextField.layer.masksToBounds = YES;
    }
    if (borderColor) {
        phoneTextField.layer.borderColor = borderColor.CGColor;
    }
    if (borderWidth > 0.0) {
        phoneTextField.layer.borderWidth = borderWidth;
    }
    if (backgroundColor) {
        phoneTextField.backgroundColor = backgroundColor;
    }
    if (placeHolder) {
        phoneTextField.placeholder = placeHolder;
    }
    if (textColor) {
        phoneTextField.textColor = textColor;
    }
    if (font) {
        phoneTextField.font = font;
    }
    phoneTextField.leftViewMode = leftViewMode;
    phoneTextField.keyboardType = keyboardType;
    phoneTextField.clearButtonMode = clearButtonMode;
    return phoneTextField;
}

@end
