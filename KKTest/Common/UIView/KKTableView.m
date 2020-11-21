//
//  KKTableView.m
//  App
//
//  Created by kangkang zhu on 2018/10/22.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKTableView.h"
#import <Masonry.h>

@interface KKTableView () {
    UILabel *_lblMessage;
    UIImageView *_imgVIcon;
    UIButton *_btnLoadAgain;
}

@end

@implementation KKTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorOfTableViewBackground;
    }
    return self;
}

- (void)setIsShowEmptyData:(BOOL)isShowEmptyData {
    _isShowEmptyData = isShowEmptyData;
    self.placehodeView.hidden = !_isShowEmptyData;
    _lblMessage.hidden = !_isShowEmptyData;
    _imgVIcon.hidden = !_isShowEmptyData;
    _lblMessage.text = @"当前无数据";
    _imgVIcon.image = [UIImage imageNamed:@"empty_data"];
}

-(void)setIsShowNetworkError:(BOOL)isShowNetworkError {
    _isShowNetworkError = isShowNetworkError;
    self.placehodeView.hidden = !_isShowNetworkError;
    _lblMessage.hidden = !_isShowNetworkError;
    _imgVIcon.hidden = !_isShowNetworkError;
    _lblMessage.text = @"网络走神了，点击重新加载";
    _imgVIcon.image = [UIImage imageNamed:@"network_error"];
}

- (void)hidePlacehodeView {
    self.placehodeView.hidden = YES;
    _lblMessage.hidden = YES;
    _imgVIcon.hidden = YES;
}

- (void)networkErrorAction {
    if (self.isShowNetworkError) {
        if (_onNetworkErrorBtnAction) {
            _onNetworkErrorBtnAction();
        }
    }
}

-(UIView *)placehodeView {
    if (!_placehodeView) {
        _placehodeView = [[UIView alloc] initWithFrame:self.bounds];
        _placehodeView.backgroundColor = kColorOfTableViewBackground;
        [self addSubview:_placehodeView];
        [_placehodeView bringSubviewToFront:self];
        [self creatSubviewWithSuperView:self.placehodeView];
    }
    return _placehodeView;
}

- (void)creatSubviewWithSuperView:(UIView *)superView {
    _lblMessage = [YSControlManager labelWithFont:kFontOfSize17
                                        textColor:kColorOfBase];
    [superView addSubview:_lblMessage];
    
    _imgVIcon = [UIImageView new];
    [superView addSubview:_imgVIcon];
    
    _btnLoadAgain = [UIButton new];
    [superView addSubview:_btnLoadAgain];
    [_btnLoadAgain addTarget:self
                      action:@selector(networkErrorAction)
            forControlEvents:UIControlEventTouchUpInside];
    
    [_imgVIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(superView);
    }];
    
    [_lblMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.centerY.equalTo(superView).offset(75.0);
    }];
    
    [_btnLoadAgain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(superView);
        make.height.and.width.equalTo(@300.0);
    }];
}

@end
