//
//  UIView+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "UIView+FMCategory.h"
#import <objc/runtime.h>

static char kKDActionHandlerTapBlockKey;
static char kKDActionHandlerTapGestureKey;
static char kKDActionHandlerLongPressBlockKey;
static char kKDActionHandlerLongPressGestureKey;

@implementation UIView (FMCategory)
#pragma mark 尺寸
- (CGFloat)fm_screenRate
{
    return UIScreen.mainScreen.bounds.size.width / 375.0f;
}

- (BOOL)fm_isIPhoneXScreen
{
    if (@available(iOS 11.0, *)) {
        return !UIEdgeInsetsEqualToEdgeInsets([UIApplication sharedApplication].windows[0].safeAreaInsets, UIEdgeInsetsZero);
    }
    return NO;
}

- (CGFloat)fm_left {
    return self.frame.origin.x;
}



- (void)setFm_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}



- (CGFloat)fm_top {
    return self.frame.origin.y;
}



- (void)setFm_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}



- (CGFloat)fm_right {
    return self.frame.origin.x + self.frame.size.width;
}



- (void)setFm_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}



- (CGFloat)fm_bottom {
    return self.frame.origin.y + self.frame.size.height;
}



- (void)setFm_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}



- (CGFloat)fm_centerX {
    return self.center.x;
}



- (void)setFm_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}



- (CGFloat)fm_centerY {
    return self.center.y;
}



- (void)setFm_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}



- (CGFloat)fm_width {
    return self.frame.size.width;
}



- (void)setFm_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}



- (CGFloat)fm_height {
    return self.frame.size.height;
}



- (void)setFm_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)fm_origin {
    return self.frame.origin;
}



- (void)setFm_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}



- (CGSize)fm_size {
    return self.frame.size;
}



- (void)setFm_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}



- (CGFloat)fm_orientationWidth {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.fm_height : self.fm_width;
}



- (CGFloat)fm_orientationHeight {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.fm_width : self.fm_height;
}

#pragma mark 通用方法
- (void)fm_removeAllSubviews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
- (void)fm_setTapActionIsCancelsTouches:(BOOL)isCancel WithBlock:(void (^)(void))block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kKDActionHandlerTapGestureKey);
    
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        gesture.cancelsTouchesInView = isCancel;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kKDActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kKDActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kKDActionHandlerTapBlockKey);
        
        if (action)
        {
            action();
        }
    }
}

- (void)fm_setLongPressActionWithBlock:(void (^)(void))block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kKDActionHandlerLongPressGestureKey);
    
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kKDActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kKDActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kKDActionHandlerLongPressBlockKey);
        
        if (action)
        {
            action();
        }
    }
}

- (void)fm_setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (UIImage *)fm_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates {
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self fm_snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)fm_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (NSData *)fm_snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData *data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (UIViewController *)fm_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)fm_keyboardCanHide
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)keyboardHide
{
    [self endEditing:YES];
}

// 判断View是否显示在屏幕上
- (BOOL)fm_isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}

#pragma mark UI创建方法
+ (id)fm_loadFromNib
{
    NSString *xibName = NSStringFromClass([self class]);
    return [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] firstObject];
}

+ (UINib *)fm_registerNib
{
    NSString *xibName = NSStringFromClass([self class]);
    return [UINib nibWithNibName:xibName bundle:nil];
}

+ (NSString *)fm_className{
    return NSStringFromClass(self.class);
}

#pragma mark 圆角处理
- (void)fm_borderForColor:(UIColor *)color bothSpace:(CGFloat)bothSpace borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType {
    
    if (borderType == UIBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
        return;
    }
    
    if (borderType & UIBorderSideTypeLeft) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(bothSpace, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height-bothSpace*2) color:color borderWidth:borderWidth]];
    }
    
    if (borderType & UIBorderSideTypeRight) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, bothSpace) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height-bothSpace*2) color:color borderWidth:borderWidth]];
    }
    
    if (borderType & UIBorderSideTypeTop) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(bothSpace, 0.0f) toPoint:CGPointMake(self.frame.size.width-bothSpace*2, 0.0f) color:color borderWidth:borderWidth]];
    }
    
    if (borderType & UIBorderSideTypeBottom) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(bothSpace, self.frame.size.height - borderWidth) toPoint:CGPointMake( self.frame.size.width-bothSpace*2, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
}

- (void)fm_borderForColor:(UIColor *)color space:(CGFloat)space borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType {
    
    if (borderType == UIBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
        return;
    }
    
    if (borderType & UIBorderSideTypeLeft) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(space, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height-space) color:color borderWidth:borderWidth]];
    }
    
    if (borderType & UIBorderSideTypeRight) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, space) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height-space) color:color borderWidth:borderWidth]];
    }
    
    if (borderType & UIBorderSideTypeTop) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(space, 0.0f) toPoint:CGPointMake(self.frame.size.width-space, 0.0f) color:color borderWidth:borderWidth]];
    }
    
    if (borderType & UIBorderSideTypeBottom) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(space, self.frame.size.height - borderWidth) toPoint:CGPointMake( self.frame.size.width-space, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
}

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;
}

- (void)fm_borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth Corner:(CGFloat)corner rectCorner:(UIRectCorner)rectCorner
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) byRoundingCorners:rectCorner cornerRadii:CGSizeMake(corner, corner)];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = borderWidth;

    [self.layer addSublayer:shapeLayer];
}
@end
