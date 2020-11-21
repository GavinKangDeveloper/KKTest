//
//  KKTableView.h
//  App
//
//  Created by kangkang zhu on 2018/10/22.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKTableView : UITableView

@property (nonatomic, strong) UIView *placehodeView;
@property (nonatomic, assign) BOOL isShowNetworkError;
@property (nonatomic, assign) BOOL isShowEmptyData;

@property(nonatomic, copy) void (^onNetworkErrorBtnAction)(void);
- (void)hidePlacehodeView;

@end

NS_ASSUME_NONNULL_END
