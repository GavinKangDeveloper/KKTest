//
//  KKTableView.h
//  App
//
//  Created by kangkang zhu on 2018/10/22.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKBaseTableView : UITableView

/// 空数据显示的图，默认：common_empty_data
@property (nonatomic, strong) UIImage *emptyDataOfImg;
/// 空数据显示的文字，默认：暂无数据~
@property (nonatomic, strong) NSAttributedString *emptyDataOfData;
/// 空数据垂直的偏移量，默认：向上偏移 50
@property (nonatomic, assign) CGFloat emptyDataOfVerticalOffset;
///空数据是否可以滚动 TableView，默认是 YES
@property (nonatomic, assign) BOOL emptyDataOfCanScroll;

/// 使用基类空数据的占位必须要调用这个方法 - 增加代理
- (void)setEmptyData;

- (void)beginHeaderRefresh;
- (void)endRefresh:(BOOL)isMore;
- (void)endFooterRefreshWithNoMoreData;
- (void)resetFooterRefreshWithNoMoreData;

@end

NS_ASSUME_NONNULL_END
