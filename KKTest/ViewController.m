//
//  ViewController.m
//  KKTest
//
//  Created by ZKKMBP on 2020/6/29.
//  Copyright © 2020 ZKKMBP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//   使用模拟器，在 Debug 中打开 Color Off-screen Rendered ，显示黄色的内容产生了离屏渲染
    
    self.btnTemp.backgroundColor = [UIColor greenColor];
    
    
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 60)];
    View.backgroundColor = [UIColor redColor];
//    View.opaque = YES;
//    View.layer.cornerRadius = 20.0;
//    View.clipsToBounds = YES;
    [self.view addSubview:View];
    
        UIView *View2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        View2.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    //    View2.opaque = YES;
        [View addSubview:View2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 30)];
    
    label.text = @"qwqwqwqw";
    label.textColor = [UIColor greenColor];
    [self.view addSubview:label];
    
    [self addGradientLayerWithStartColor:[UIColor redColor]
                                endColor:[UIColor yellowColor]
                              startPoint:CGPointMake(0.0, 0.0)
                                endPoint:CGPointMake(1.0, 0.0)
                            gradientView:label];

}

- (IBAction)onButtonClicked:(UIButton *)sender {
    sender.layer.cornerRadius = 20;
    sender.layer.masksToBounds = YES;
    
//    [sender setBackgroundImage:[self drawRectWithRoundedCorner:10.0
//                                         borderWidth:2.0
//                                         borderColor:[UIColor greenColor]
//                                     backGroundColor:[UIColor redColor]
//                                        drawRectView:sender]
//            forState:UIControlStateNormal];
//
//    [sender setTitle:@"2323" forState:UIControlStateNormal];
}

- (UIImage *)drawRectWithRoundedCorner:(CGFloat)radius
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(UIColor *)borderColor
                          backGroundColor:(UIColor*)bgColor
                          drawRectView:(UIView *)drawRectView {
    CGSize size = drawRectView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef =  UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(contextRef, borderWidth);
    CGContextSetStrokeColorWithColor(contextRef, borderColor.CGColor);
    CGContextSetFillColorWithColor(contextRef, bgColor.CGColor);
    
    CGFloat halfBorderWidth = borderWidth / 2.0;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGContextMoveToPoint(contextRef, width - halfBorderWidth, radius + halfBorderWidth);
    CGContextAddArcToPoint(contextRef, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角角度
    CGContextAddArcToPoint(contextRef, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(contextRef, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(contextRef, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)addGradientLayerWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint gradientView:(UIView *)gradientView {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = gradientView.bounds;
    [gradientView.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}



@end
