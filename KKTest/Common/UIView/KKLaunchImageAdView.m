//
//  KKLaunchImageAdView.m
//  App
//
//  Created by kangkang zhu on 2018/10/10.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKLaunchImageAdView.h"

#define kLaunchImages           @"UILaunchImages"
#define kLaunchImageSize        @"UILaunchImageSize"
#define kLaunchImageOrientation @"UILaunchImageOrientation"
#define kLaunchImageName        @"UILaunchImageName"

@interface KKLaunchImageAdView (){
    UIWindow *_window;
    NSInteger _adTime; ///< 倒计时总时长
    UIImageView *_adImageView;
    UIImageView *_logoImageView;
    KJLaunchImageAdType _launchImageAdType;
    UIButton *_btnSkip;
    NSTimer *_countDownTimer;
    KJAdImageClickType _adImageClickType;
}

@end

@implementation KKLaunchImageAdView

- (instancetype)initWithWindow:(UIWindow *)window launchImageAdType:(KJLaunchImageAdType)launchImageAdType adImageURL:(NSString *)adImageURL adTime:(NSInteger)adTime {
    if (self = [super init]) {
        _window = window;
        _adTime = adTime;
        _launchImageAdType = launchImageAdType;
        _adImageClickType = KJAdImageClickFinishType;
        [self createSubviewsForContentView];
//        [self loadAdImageFromNetWorkWithURL:adImageURL];
    }
    return self;
}

- (instancetype)initWithWindow:(UIWindow *)window launchImageAdType:(KJLaunchImageAdType)launchImageAdType adImage:(UIImage *)adImage adTime:(NSInteger)adTime {
    if (self = [super init]) {
        _window = window;
        _adTime = adTime;
        _launchImageAdType = launchImageAdType;
        _adImageClickType = KJAdImageClickFinishType;
        [self createSubviewsForContentView];
//        [self loadAdImageFromLocationWithImage:adImage];
    }
    return self;
}

- (void)dealloc {
    
}

#pragma mark - Private Method
- (void)createSubviewsForContentView {
    self.backgroundColor = kColorOfWhite;
    self.frame = kFrameOfMainScreen;

//        CGFloat heightOfLogo = [self getLogoHeight];
        _adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, kWidthOfMainScreen, kHeightOfMainScreen)];
        _adImageView.image = [UIImage imageNamed:@"Open_APP"];
        [self addSubview:_adImageView];
    _adImageView.contentMode = UIViewContentModeScaleAspectFill;
    _adImageView.backgroundColor = [UIColor clearColor];
//    _adImageView.userInteractionEnabled = YES;
//    _adImageView.layer.masksToBounds = YES;
//    [self addSubview:_adImageView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAdImageViewClicked:)];
    [_adImageView addGestureRecognizer:tapGestureRecognizer];
//    [self addAnimationToAdImageView];
    [self createSkipButtonView];
    
    [_window addSubview:self];
}

- (void)createSkipButtonView {
    CGSize sizeOfSkipButton = CGSizeMake(87.0, 30.0);
    
    _btnSkip = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnSkip.frame = CGRectMake(kWidthOfMainScreen - sizeOfSkipButton.width - 11.5, 15.0 + kHeightOfStatus, sizeOfSkipButton.width, sizeOfSkipButton.height);
    _btnSkip.backgroundColor = funcUIColorFromOxValueA(0x000000, 0.5);
    _btnSkip.titleLabel.font = kFontOfSize12;
    [_btnSkip setTitle:@"跳过" forState:UIControlStateNormal];
    [_btnSkip addTarget:self
                 action:@selector(onSkipButtonClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [_adImageView addSubview:_btnSkip];
}

- (void)loadAdImageFromNetWorkWithURL:(NSString *)imageURL {
    __weak typeof(self) weakSelf = self;
    if (imageURL) {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];

        [manager downloadImageWithURL:[NSURL URLWithString:imageURL]
                              options:SDWebImageRetryFailed
                             progress:nil
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    [weakSelf loadAdImageWithImage:image];
                                }
                            }];
    }
}

- (void)loadAdImageFromLocationWithImage:(UIImage *)image {
    [self loadAdImageWithImage:image];
}

- (void)loadAdImageWithImage:(UIImage *)image {
    if (_launchImageAdType == KJLaunchImageFullScreenAdType) {
        _adImageView.image = image;
    } else {
        [self adjustAdImageViewSizeWithImage:image];
    }
}

- (CGFloat)getLogoHeight {
    CGFloat heightOfLogo = 91.0;
    if (kIsPhone6Plus) {
        heightOfLogo = 99.0;
    } else if (kIsPhoneXModel) {
        heightOfLogo = 131.0;
    } else if (kIsPhone5) {
        heightOfLogo = 74.0;
    } else {
        heightOfLogo = 76.0;
    }
    return heightOfLogo;
}

#pragma mark - 跳过按钮点击
- (void)onSkipButtonClicked:(UIButton *)sender {
    _adImageClickType = KJAdImageClickSkipType;
    [self startcloseAnimation];
}

#pragma mark - 广告图片点击
- (void)onAdImageViewClicked:(UITapGestureRecognizer *)tap {
    _adImageClickType = KJAdImageClickAdType;
    [self startcloseAnimation];
}

- (void)addAnimationToAdImageView {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration  = 0.8;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.toValue   = [NSNumber numberWithFloat:0.8];
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [_adImageView.layer addAnimation:opacityAnimation
                              forKey:@"animateOpacity"];
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(onTimer)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)onTimer {
    if (_adTime == 0) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
        [self startcloseAnimation];
    } else {
    }
}

#pragma mark - 开启关闭动画
- (void)startcloseAnimation{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha=0.1;
    } completion:^(BOOL finished) {
        [weakSelf closeAddImgAnimation];
    }];
}

#pragma mark - 关闭动画完成时处理事件
-(void)closeAddImgAnimation {
    [_countDownTimer invalidate];
    _countDownTimer = nil;
    _adImageView.hidden = YES;
    self.hidden = YES;
    [self removeFromSuperview];
    if (self.clickType) {
        self.clickType(_adImageClickType);
    }
}

#pragma mark - 指定图片大小自适应UIImageView
- (void)adjustAdImageViewSizeWithImage:(UIImage *)image {
    _adImageView.image = [self cutImage:image];
}

- (UIImage *)cutImage:(UIImage *)image {
    // 裁剪图片
    UIImage *newImage = nil;
    CGImageRef imageRef = nil;
    CGSize originalImageSize = image.size;
    CGFloat newImageScale = (kHeightOfMainScreen - [self getLogoHeight]) / kWidthOfMainScreen;
    CGFloat newImageHeight = originalImageSize.width * newImageScale;
    
    if (newImageHeight < originalImageSize.height) {
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0.0, fabs(originalImageSize.height - newImageHeight) / 2,originalImageSize.width, newImageHeight));
        newImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        return newImage;
    } else {
        return image;
    }
}


@end
