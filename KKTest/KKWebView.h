//
//  KKWebView.h
//  NSURLProtocol+WebKitSupport
//
//  Created by ZhuKangKang on 2021/1/18.
//  Copyright © 2021 Yeatse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


@interface KKWebView : NSObject

/// 销毁单例
- (void)invalidate;
/// 初始化单例
+ (KKWebView *)sharedManager;

@property (nonatomic, strong) WKWebView *webView;
@end
