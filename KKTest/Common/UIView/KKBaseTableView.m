//
//  KKTableView.m
//  App
//
//  Created by kangkang zhu on 2018/10/22.
//  Copyright © 2018年 xinli001. All rights reserved.
//

#import "KKBaseTableView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface KKBaseTableView ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation KKBaseTableView

#pragma mark - 关闭 Self-Sizing，解决默认以及刷新高度变化的问题
/**
 1、init
 2、new
 3、initWithFrame:(CGRect)frame
 4、initWithFrame:(CGRect)frame style:(UITableViewStyle)style
 用代码创建的 TableView 走以下方法
 **/
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        if (kkIsPad) {
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
        }
        [self initEmptyData];
    }
    return self;
}

/**
 用 xib 或者 storyboard 创建的 TableView 走以下方法
**/
- (instancetype)initWithCoder:(NSCoder*)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
        }
        [self initEmptyData];
      }
    return self;
}

#pragma mark - EmptyData
- (void)setEmptyData {
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
}

- (void)initEmptyData {
    self.emptyDataOfImg = [UIImage imageNamed:@"kk_empty_list"];
    NSString *text = @"暂无数据~";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                 NSForegroundColorAttributeName:kkFuncUIColorFromOxValue(0x999999)};
    self.emptyDataOfData = [[NSAttributedString alloc] initWithString:text
                                                           attributes:attributes];
    self.emptyDataOfVerticalOffset = -50;
    self.emptyDataOfCanScroll = YES;
}

#pragma -mark MJRefresh
- (void)beginHeaderRefresh {
    [self.mj_header beginRefreshing];
}

- (void)endRefresh:(BOOL)isMore {
    if (isMore) {
        [self.mj_footer endRefreshing];
    } else {
       [self.mj_header endRefreshing];
    }
}

- (void)endFooterRefreshWithNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetFooterRefreshWithNoMoreData {
    [self.mj_footer resetNoMoreData];
}

#pragma mark - DZNEmptyDataSetSource & DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyDataOfImg;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyDataOfData;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyDataOfVerticalOffset;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return self.emptyDataOfCanScroll;
}


@end
