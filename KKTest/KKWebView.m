//
//  KKWebView.m
//  NSURLProtocol+WebKitSupport
//
//  Created by ZhuKangKang on 2021/1/18.
//  Copyright © 2021 Yeatse. All rights reserved.
//

#import "KKWebView.h"

static dispatch_once_t _onceToken;
static KKWebView *_manager;

@interface  KKWebView()<NSCopying, NSMutableCopying>
@property (nonatomic, assign) NSInteger initialViewsMaxCount;
@property (nonatomic, strong) NSMutableArray *preloadedViews;
@end

@implementation KKWebView

- (void)invalidate {
    _onceToken = 0;
    _manager = nil;
}

+ (KKWebView *)sharedManager {
    dispatch_once(&_onceToken, ^{
        _manager = [[super allocWithZone:NULL] init];
    });
    return _manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self sharedManager];;
}

+ (instancetype)new {
    return  [self alloc];
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return self;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return self;
}

- (WKWebView *)webView {
    if (!_webView) {
        NSLog(@"---webView-------");
        _webView = [[WKWebView alloc] init];
    }
    return _webView;
}

/**
 预初始化若干WKWebView
 
 @param count 个数
 */
- (void)prepareWithCount:(NSUInteger)count {
    NSTimeInterval start = CACurrentMediaTime();
    while (self.preloadedViews.count < MIN(count,self.initialViewsMaxCount)) {
        id preloadedView = [self createPreloadedView];
        if (preloadedView) {
            [self.preloadedViews addObject:preloadedView];
        } else {
            break;
        }
    }
    NSTimeInterval delta = CACurrentMediaTime() - start;
    NSLog(@"=======初始化耗时：%f",  delta);
}
 
/**
 从池中获取一个WKWebView
 @return WKWebView
 */
- (WKWebView *)getWKWebViewFromPool {
    if (!self.preloadedViews.count) {
        //现有的已经不够
        return [self createPreloadedView];
    } else {
        id preloadedView = self.preloadedViews.firstObject;
        [self.preloadedViews removeObject:preloadedView];
        return preloadedView;
    }
}

- (WKWebView *)createPreloadedView  {
    WKWebView *webView = [[WKWebView alloc] init];
    return webView;
}

- (NSInteger)initialViewsMaxCount {
    if (!_initialViewsMaxCount || _initialViewsMaxCount <= 0) {
        _initialViewsMaxCount = 10;
    }
    return _initialViewsMaxCount;
}

- (NSMutableArray *)preloadedViews {
    if (!_preloadedViews) {
        _preloadedViews = [NSMutableArray arrayWithCapacity:self.initialViewsMaxCount];
    }
    return _preloadedViews;
}


@end
