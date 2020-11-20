//
//  UIImage+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/9/1.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "UIImage+FMCategory.h"

@implementation UIImage (FMCategory)
- (UIImage*)fm_imageScaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)fm_imageScaledToSize:(CGSize)newSize withPoint:(CGPoint)point
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(point.x,point.y,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)fm_compressImageToBype:(NSInteger)maxLength
{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return self;
    CGFloat quality = 0.5;
    while (data.length > maxLength && quality > 0.01f) {
        quality = quality - 0.05;
        data = UIImageJPEGRepresentation(self, quality);
    }
    
    UIImage *resultImage = [UIImage imageWithData:data];
    return resultImage;
}
    
-(UIImage *)fm_imageCompressScaleWithWidth:(CGFloat)defineWidth
{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)fm_createAvatarImageWithNickName:(NSString *)nickName AndBgColor:(UIColor *)bgColor textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize subStringAtIndex:(NSInteger)index{
 
    CGRect bgRect = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    
    UIGraphicsBeginImageContextWithOptions(bgRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, bgRect);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [bgColor CGColor]);
    CGContextFillRect(context, bgRect);
    
    UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0);
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    NSString *text;
    if (index > 0) {
        if (nickName.length >= index) {
            text = [nickName substringToIndex:index];
        }else{
            text = nickName;
        }
    }else{
        text = nickName;
    }
    
    if (!textColor) {
        textColor = [UIColor whiteColor];
    }
    
    CGFloat font = 0.f;
    if (text.length <= 3) {
        font = 180.f;
    }else{
        font = 90.f;
    }
    
    if (fontSize != 0) {
        font = fontSize;
    }
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    [attrs setObject:textColor forKey:NSForegroundColorAttributeName];
    [attrs setObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
    
    CGRect textRect = [text boundingRectWithSize:bgImage.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    CGRect rect = CGRectMake((bgImage.size.width - textRect.size.width) * 0.5,
                             (bgImage.size.height - textRect.size.height) * 0.5,
                             bgImage.size.width,
                             bgImage.size.width);
    [text drawInRect:rect withAttributes:attrs];
    
    UIImage *avatarImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return avatarImage;
}

+ (UIImage *)fm_imageWithColor:(UIColor *)color {
    return [self fm_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)fm_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
