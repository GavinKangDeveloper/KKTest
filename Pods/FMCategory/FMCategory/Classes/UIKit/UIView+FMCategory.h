//
//  UIView+FMCategory.h
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};

@interface UIView (FMCategory)
#pragma mark 尺寸属性
/**
 @return 屏幕倍数，默认为6的尺寸为1，通过除以375来得出屏幕倍数
 */
@property (nonatomic, readonly) CGFloat fm_screenRate;
/**
 @return 是否为iphonex屏
 */
@property (nonatomic, assign, readonly) BOOL fm_isIPhoneXScreen;
/**
 @return view的左边距
 */
@property (nonatomic) CGFloat fm_left;
/**
 @return view的顶边距
 */
@property (nonatomic) CGFloat fm_top;
/**
 @return view的右边距
 */
@property (nonatomic) CGFloat fm_right;
/**
 @return view的底边距
 */
@property (nonatomic) CGFloat fm_bottom;
/**
 @return view的宽度
 */
@property (nonatomic) CGFloat fm_width;
/**
 @return view的高度
 */
@property (nonatomic) CGFloat fm_height;
/**
 @return view的中心X
 */
@property (nonatomic) CGFloat fm_centerX;
/**
 @return view的中心Y
 */
@property (nonatomic) CGFloat fm_centerY;
/**
 @return view的原点
 */
@property (nonatomic) CGPoint fm_origin;
/**
@return view的尺寸
 */
@property (nonatomic) CGSize fm_size;
/**
 @return view相对于屏幕状态（是否横屏）返回宽度
 */
@property (nonatomic, readonly) CGFloat fm_orientationWidth;
/**
@return view相对于屏幕状态（是否横屏）返回高度
*/
@property (nonatomic, readonly) CGFloat fm_orientationHeight;
#pragma mark 通用方法
/**
 删除所有子视图
 */
- (void)fm_removeAllSubviews;
/**
 视图加上一个默认点击手势
 @return 手势点击回调函数
 */
- (void)fm_setTapActionIsCancelsTouches:(BOOL)isCancel WithBlock:(void (^)(void))block;
/**
 视图加上一个默认长按手势
 @return 长按回调函数
 */
- (void)fm_setLongPressActionWithBlock:(void (^)(void))block;
/**
 视图加一层阴影
 @param color  阴影颜色
 @param offset 阴影偏移
 @param radius 阴影圆角
 */
- (void)fm_setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;
/**
 通过上下文写入的方式，创建一张view截图
 @return 返回截图
 */
- (UIImage *)fm_snapshotImage;
/**
 尝试通过drawViewHierarchyInRect方法截屏，如果view方法没实现drawViewHierarchyInRect，则走snapshotImage方法
 @param afterUpdates WKWebView设置afterUpdates为ture，可以截取wkwebview屏幕内容
 @return 截图
 */
- (UIImage *)fm_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;
/**
 截屏生成PDF
 @return pdf的二进制数据
 */
- (NSData *)fm_snapshotPDF;
/**
 通过响应链获取viewController，但不能用于富米项目
 @return 响应的viewController
 */
- (UIViewController *)fm_viewController;
/**
 给视图增加点击收起键盘的事件
 */
- (void)fm_keyboardCanHide;
/**
 @return  判断view是否显示在屏幕上
 */
- (BOOL)fm_isDisplayedInScreen;

#pragma mark UI创建方法
/**
 @return xib的快速创建类方法
 */
+ (id)fm_loadFromNib;
/**
@return 返回xib名称
 */
+ (UINib *)fm_registerNib;
/**
 @return 获取类名
 */
+ (NSString *)fm_className;
#pragma mark 圆角处理
/**
 增加边框线
 @param color 边框线颜色
 @param bothSpace 两边缩进长度
 @param borderWidth 线粗细
 @param borderType 描边范围
 */
- (void)fm_borderForColor:(UIColor *)color
                 bothSpace:(CGFloat)bothSpace
               borderWidth:(CGFloat)borderWidth
                borderType:(UIBorderSideType)borderType;
/**
增加边框线
@param color 边框线颜色
@param space 一边缩进长度
@param borderWidth 线粗细
@param borderType 描边范围
*/
- (void)fm_borderForColor:(UIColor *)color
                     space:(CGFloat)space
               borderWidth:(CGFloat)borderWidth
                borderType:(UIBorderSideType)borderType;
/**
 圆角处理

 @param color 颜色
 @param borderWidth 大小
 @param corner 弧度
 @param rectCorner 圆角点
 */
- (void)fm_borderForColor:(UIColor *)color
               borderWidth:(CGFloat)borderWidth
                    Corner:(CGFloat)corner
                rectCorner:(UIRectCorner)rectCorner;

@end

NS_ASSUME_NONNULL_END
