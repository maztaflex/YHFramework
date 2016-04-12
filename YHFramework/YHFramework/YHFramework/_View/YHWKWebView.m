//
//  YHWKWebView.m
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 2. 26..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import "YHWKWebView.h"
#import "YHViewController.h"

#define kDefaultHandlerName                                                          @"default_handler"

@interface YHWKWebView () <WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler>

@property (strong, nonatomic) UIAlertController *alertController;

@end

@implementation YHWKWebView

- (instancetype)initWithDelegate:(id<YHWKWebViewDelegate, UIScrollViewDelegate>)delegate
{
    if (self = [super initWithFrame:CGRectZero configuration:[self defaultConfiguration]])
    {
        [self setUpDelegate:delegate];
    }
    
    return self;
}

- (instancetype)initWithDelegate:(id<YHWKWebViewDelegate, UIScrollViewDelegate>)delegate configuration:(WKWebViewConfiguration *)configuration
{
    if (self = [super initWithFrame:CGRectZero configuration:configuration])
    {
        [self setUpDelegate:delegate];
    }
    
    return self;
}

- (instancetype)initWithDelegate:(id<YHWKWebViewDelegate, UIScrollViewDelegate>)delegate configurationWithHandlerName:(NSString *)handlerName
{
    if (self = [super initWithFrame:CGRectZero configuration:[self customConfigurationWithHandlerName:handlerName]])
    {
        [self setUpDelegate:delegate];
    }
    
    return self;
}

- (void)setUseProgress
{
    [self addObserver:self
           forKeyPath:@"estimatedProgress"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
}

- (void)executeJavaScript:(NSString *)script
{
    [self evaluateJavaScript:script completionHandler:nil];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if ([self.webDelegate respondsToSelector:@selector(webViewDidStartProvisional:)]) {
        [self.webDelegate webViewDidStartProvisional:self];
    }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    if ([self.webDelegate respondsToSelector:@selector(webViewDidStartProvisional:)]) {
        [self.webDelegate webViewDidStartProvisional:self];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if ([self.webDelegate respondsToSelector:@selector(webViewDidFinish:)]) {
        [self.webDelegate webViewDidFinish:self];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error
{
    if ([self.webDelegate respondsToSelector:@selector(webViewDidFail:withError:)]) {
        [self.webDelegate webViewDidFail:self withError:error];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error
{
    if ([self.webDelegate respondsToSelector:@selector(webViewDidFailProvisional:withError:)]) {
        [self.webDelegate webViewDidFailProvisional:self withError:error];
    }
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([self.webDelegate respondsToSelector:@selector(didReceiveScriptResults:)]) {
        [self.webDelegate didReceiveScriptResults:message.body];
    }
}

/* WKUIDelegate 각각 Delegate마다 CompletionHandler를 반드시 호출, 호출 하지 않을 경우 Crash 발생 */
#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView
runJavaScriptAlertPanelWithMessage:(NSString *)message
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(void))completionHandler
{
    LogGreen(@"runJavaScriptAlertPanelWithMessage : %@",message);
    
    [self initAlertPopupWithMessage:message completionHandler:completionHandler];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    WKWebView *webView = object;
    
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        if ([self.webDelegate respondsToSelector:@selector(webView:loadingProgress:)])
        {
            [self.webDelegate webView:self loadingProgress:webView.estimatedProgress];
        }
    }
}

#pragma mark - Private Method
- (void)setUpDelegate:(id<YHWKWebViewDelegate, UIScrollViewDelegate>)delegate
{
    self.navigationDelegate = self;
    
    self.UIDelegate = self;
    
    _webDelegate = delegate;
}

- (WKWebViewConfiguration *)defaultConfiguration
{
    
    WKUserScript * cookieScript = [[WKUserScript alloc]
                                   initWithSource: [self getInjectionCookie]
                                   injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    WKUserContentController *controller = [[WKUserContentController alloc] init];
    
    [controller addScriptMessageHandler:self name:kDefaultHandlerName];
    [controller addUserScript:cookieScript];
    
    configuration.userContentController = controller;
    
    return configuration;
}

- (WKWebViewConfiguration *)customConfigurationWithHandlerName:(NSString *)handlerName
{
    WKUserScript * cookieScript = [[WKUserScript alloc]
                                   initWithSource: [self getInjectionCookie]
                                   injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    WKUserContentController *controller = [[WKUserContentController alloc] init];
    
    [controller addScriptMessageHandler:self name:handlerName];
    [controller addUserScript:cookieScript];
    
    configuration.userContentController = controller;    
    
    return configuration;
}

- (void)initAlertPopupWithMessage:(NSString *)message completionHandler:(void(^)(void))completionHandler
{
    self.alertController = [UIAlertController alertControllerWithTitle:nil
                                                               message:message
                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction *action) {
                                                               completionHandler();
                                                           }]];
    
    [self showAlertPopup];
}

- (void)showAlertPopup
{
    // ProgressHud가 동작중일(enableUIWithUsingProgressHud 호출중) 경우를 위해 동작 중단 처리
    YHViewController *vc = (YHViewController *)self.webDelegate;
    [vc enableUIWithUsingProgressHud];
    
    [vc presentViewController:self.alertController animated:NO completion:nil];
}

- (void)showAlertPopupWithDelay
{
    // ProgressHud가 사라지는 시간을 고려하여 1초가 지연후 팝업 호출
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(showAlertPopup) userInfo:nil repeats:NO];
}

// Web Document에 시스템에 저장된 Cookie를 설정하기 위한 Injection String 생성
- (NSString *)getInjectionCookie
{
    NSString *result = nil;
    NSArray *allCookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    
    NSMutableString *convertedCookiesString = [NSMutableString new];
    
    for (NSHTTPCookie *cookie in allCookies)
    {
        [convertedCookiesString appendString:[NSString stringWithFormat:@"document.cookie='%@=%@;domain=%@;';",cookie.name, cookie.value,cookie.domain]];
    }
    
    LogGreen(@"convertedCookiesString : %@",convertedCookiesString);
    
    result = convertedCookiesString;
    
    return result;
}

#pragma mark - Dealloc
- (void)dealloc
{
    LogRed(@"- (void)dealloc");
    @try {
        [self removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    @catch (NSException *exception) {
        LogRed(@"exception : %@",exception);
    }
}

@end
