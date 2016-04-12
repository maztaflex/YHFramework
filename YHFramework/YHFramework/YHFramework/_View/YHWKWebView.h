//
//  YHWKWebView.h
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 2. 26..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import <WebKit/WebKit.h>

@protocol YHWKWebViewDelegate;


@interface YHWKWebView : WKWebView

@property (weak, nonatomic) id<YHWKWebViewDelegate> webDelegate;

- (instancetype)initWithDelegate:(id<YHWKWebViewDelegate>)delegate;
- (instancetype)initWithDelegate:(id<YHWKWebViewDelegate>)delegate configuration:(WKWebViewConfiguration *)configuration;
- (instancetype)initWithDelegate:(id<YHWKWebViewDelegate>)delegate configurationWithHandlerName:(NSString *)handlerName;

- (void)setUseProgress;
- (void)executeJavaScript:(NSString *)script;

@end

@protocol YHWKWebViewDelegate <NSObject>

@required

- (void)webViewDidStartProvisional:(YHWKWebView *)webView;
- (void)webViewDidCommit:(YHWKWebView *)webView;
- (void)webViewDidFinish:(YHWKWebView *)webView;
- (void)webViewDidFail:(YHWKWebView *)webView withError:(NSError *)error;

@optional

- (void)webViewDidFailProvisional:(YHWKWebView *)webView withError:(NSError *)error;
- (void)webView:(YHWKWebView *)webView loadingProgress:(double)progress;
- (void)didReceiveScriptResults:(id)results;

@end
