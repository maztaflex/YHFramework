//
//  YHTools.m
//
//  Created by DEV_TEAM1_IOS on 2015. 8. 25..
//  Copyright (c) 2015년 S.M Entertainment. All rights reserved.
//

#import "AppDelegate.h"
#import <UIImageView+WebCache.h>
#import "YHGoogleAnalytics.h"

@interface YHTools ()

@property (strong, nonatomic) YHGoogleAnalytics *ga;

@end

@implementation YHTools

static dispatch_once_t once;
static YHTools * __sharedInstance = nil;

+ (instancetype)sharedInstance
{
    if (!__sharedInstance)
    {
        dispatch_once(&once, ^{
            
            __sharedInstance = [[self alloc] init];
            
        });
    }
    
    return __sharedInstance;
}

- (id)init
{
    if (self = [super init]) {
        _ga = [[YHGoogleAnalytics alloc] init];
    }
    return self;
}

- (BOOL)isDevelopMode
{
    BOOL isDev = NO;
    
#if DEBUG || INHOUSE
    isDev = YES;
#endif
    
    return isDev;
}

+ (id)getUserDefaultsValueWithKey:(NSString *)aKey
{
    id result = nil;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    result = [userDefaults objectForKey:aKey];
    
    return result;
}

- (void)setUserDefaultsWithObject:(id)obj key:(NSString *)aKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:obj forKey:aKey];
    
    [userDefaults synchronize];
}

// Get Image From Disk Cache
- (UIImage *)getImageFromLocalCacheWithFileName:(NSString *)fileName
{
    UIImage *result = nil;
    
    NSString *filePath = [[self getPathOfCacheDirectory] stringByAppendingPathComponent:fileName];
    
    result = [UIImage imageWithContentsOfFile:filePath];
    
    return result;
}


- (UIImage *)getSplashImageWithFileName:(NSString *)fileName
{
    UIImage *result = nil;
    
    CGFloat screenHeight = [self screenHeightWithConsideredOrientation];
    
    if (screenHeight == 480.0f) {
        fileName = [fileName stringByAppendingString:@"-480h@2x"];
    }
    
    if (screenHeight == 568.0f) {
        fileName = [fileName stringByAppendingString:@"-568h@2x"];
    }
    
    if (screenHeight == 667.0f) {
        fileName = [fileName stringByAppendingString:@"-667h@2x"];
    }
    
    if (screenHeight == 736.0f) {
        fileName = [fileName stringByAppendingString:@"-736h@3x"];
    }
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    result = [UIImage imageWithContentsOfFile:resourcePath];
    
    return result;
}


- (void)saveImageFileToCacheDirectoryFromURL:(NSString *)urlStr
{
    NSString *fileName = [urlStr lastPathComponent];
    NSString *savePath = [[self getPathOfCacheDirectory] stringByAppendingPathComponent:fileName];
    
    dispatch_async(dispatch_queue_create("com.smtown.imagedownload",NULL), ^{
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        
        [imgData writeToFile:savePath atomically:YES];
    });
}

- (BOOL)saveImageDataToLocalCacheDirectoryWithImageObj:(UIImage *)img fileName:(NSString *)fileName
{
    BOOL isSuccess = NO;
    
//    NSData *imgData = UIImageJPEGRepresentation(img, 1.0f);
    NSData *imgData = UIImagePNGRepresentation(img);
    
    NSString *saveFilePath = [[self getPathOfCacheDirectory] stringByAppendingPathComponent:fileName];

    isSuccess = [imgData writeToFile:saveFilePath atomically:YES];
    
    return isSuccess;
}

- (UIImage *)getImageWithFileName:(NSString *)fileName
{
    UIImage *img = [UIImage imageNamed:fileName];
    
    return img;
}

- (void)setImageToImageView:(UIImageView *)targetImageView
           placeholderImage:(UIImage *)placeholderImage
             imageURLString:(NSString *)imageUrl
{
    [self setImageToImageView:targetImageView placeholderImage:placeholderImage imageURLString:imageUrl isOnlyMemoryCache:NO];
}

- (void)setImageToImageView:(UIImageView *)targetImageView
           placeholderImage:(UIImage *)placeholderImage
             imageURLString:(NSString *)imageUrl
            isOnlyMemoryCache:(BOOL)onlyMemoryCache
{
    [self setImageToImageView:targetImageView placeholderImage:placeholderImage imageURLString:imageUrl isOnlyMemoryCache:onlyMemoryCache completion:nil];
}
    
- (void)setImageToImageView:(UIImageView *)targetImageView
           placeholderImage:(UIImage *)placeholderImage
             imageURLString:(NSString *)imageUrl
          isOnlyMemoryCache:(BOOL)onlyMemoryCache completion:(void(^)(void))completion
{
    NSURL *imgURL = [NSURL URLWithString:imageUrl];
    
    SDWebImageCompletionBlock completionBlock = ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        
        if (image && (cacheType == SDImageCacheTypeNone))
        {
            [targetImageView.layer addAnimation:[self fadeOutAnimationForChangeImage] forKey:@"fadeOutAnimationForChangeImage"];
        }
        
        if (completion) {
            completion();
        }
    };
    
    if (onlyMemoryCache == YES) {
        [targetImageView sd_setImageWithURL:imgURL
                           placeholderImage:placeholderImage
                                    options:SDWebImageCacheMemoryOnly
                                  completed:completionBlock];
    }
    else
    {
        [targetImageView sd_setImageWithURL:imgURL
                           placeholderImage:placeholderImage completed:completionBlock];
    }
}

- (UIImage * )imageResizeWithImage:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage*scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)getResizedImageWithFileName:(NSString *)fileName insets:(UIEdgeInsets)edgeInsets
{
    UIImage *result = nil;
    
    result = [self getImageWithFileName:fileName];
    
    result = [result resizableImageWithCapInsets:edgeInsets];
    
    return result;
}

// Get Ratio Height
- (CGFloat)getRatioHeightByWidth:(CGFloat)width originImageSize:(CGSize)imgSize
{
    CGFloat result = CGFLOAT_MIN;
    
    result = width * (imgSize.height / imgSize.width);
    
    if (isnan(result)) {
        result = width;
    }
    
    return result;
}
- (CGFloat)getRatioHeightByWidth:(CGFloat)width originImage:(UIImage *)image
{
    CGFloat result = CGFLOAT_MIN;
    
    CGSize imageSize = image.size;
    
    result = width * (imageSize.height / imageSize.width);
    
    if (isnan(result)) {
        result = width;
    }
    
    return result;
}

- (UIColor *)getColorByStringHexCode:(NSString *)strHexCode
{
    UIColor *result = nil;
    NSScanner *scanner = nil;
    unsigned redCode, greenCode, blueCode;
    NSRange r;
    
    r.location = 0;
    r.length = 2;
    NSString *redCodeStr = [strHexCode substringWithRange:r];
    
    r.location = 2;
    NSString *greenCodeStr = [strHexCode substringWithRange:r];
    
    r.location = 4;
    NSString *blueCodeStr = [strHexCode substringWithRange:r];
    
    scanner = [NSScanner scannerWithString:redCodeStr];
    [scanner scanHexInt:&redCode];
    
    scanner = [NSScanner scannerWithString:greenCodeStr];
    [scanner scanHexInt:&greenCode];
    
    scanner = [NSScanner scannerWithString:blueCodeStr];
    [scanner scanHexInt:&blueCode];
    
    result = [UIColor colorWithRed:redCode/255.0f green:greenCode/255.0f blue:blueCode/255.0f alpha:1];
    
    return result;
}

- (UIColor *)getColorByStringHexCode:(NSString *)strHexCode alpah:(CGFloat)alpha
{
    UIColor *result = nil;
    NSScanner *scanner = nil;
    unsigned redCode, greenCode, blueCode;
    NSRange r;
    
    r.location = 0;
    r.length = 2;
    NSString *redCodeStr = [strHexCode substringWithRange:r];
    
    r.location = 2;
    NSString *greenCodeStr = [strHexCode substringWithRange:r];
    
    r.location = 4;
    NSString *blueCodeStr = [strHexCode substringWithRange:r];
    
    scanner = [NSScanner scannerWithString:redCodeStr];
    [scanner scanHexInt:&redCode];
    
    scanner = [NSScanner scannerWithString:greenCodeStr];
    [scanner scanHexInt:&greenCode];
    
    scanner = [NSScanner scannerWithString:blueCodeStr];
    [scanner scanHexInt:&blueCode];
    
    result = [UIColor colorWithRed:redCode/255.0f green:greenCode/255.0f blue:blueCode/255.0f alpha:alpha];
    
    return result;
}

- (BOOL)isPad
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

- (BOOL)isLandScapeOrientation
{
    UIDeviceOrientation orientationType = [UIDevice currentDevice].orientation;
    
    if (orientationType == UIDeviceOrientationLandscapeLeft || orientationType == UIDeviceOrientationLandscapeRight) {
        return YES;
    }
    
    return NO;
}

// Screen Width, Height 확인
- (CGFloat)screenWidthWithConsideredOrientation
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    CGFloat screenWidth = 0.0f;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        screenWidth = screenSize.width;
    }
    else
    {
        if ([self isLandScapeOrientation] == YES)
        {
            screenWidth = screenSize.height;
        }
        else
        {
            screenWidth = screenSize.width;
        }
    }
    
    return screenWidth;
}

- (CGFloat)screenHeightWithConsideredOrientation
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    CGFloat screenHeight = 0.0f;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        screenHeight = screenSize.height;
    }
    else
    {
        if ([self isLandScapeOrientation] == YES)
        {
            screenHeight = screenSize.width;
        }
        else
        {
            screenHeight = screenSize.height;
        }
    }
    
    return screenHeight;
}

- (void)callWithPhoneNumber:(NSString *)phoneNumber
{
    NSString *phoneNumberWithScheme = [@"tel://" stringByAppendingString:phoneNumber];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumberWithScheme]];
}

- (NSString*)getAppVersion
{
    NSString *versionInfo = [[[NSBundle bundleForClass:[self class]] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    return versionInfo;
}

- (NSString*)getBuildVersion
{
    NSString *versionInfo = [[[NSBundle bundleForClass:[self class]] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    return versionInfo;
}

- (void)setLanguageCodeWithCode:(NSString *)lc
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:lc forKey:kSettingLanguageCode];
    
    [userDefaults synchronize];
}

- (NSString *)getLanguageCode
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *languageCode = [userDefaults objectForKey:kSettingLanguageCode];
    
    if (languageCode == nil || [languageCode isEqualToString:@""]) {
        languageCode = [[NSLocale preferredLanguages] objectAtIndex:0];
        
        languageCode = [[languageCode componentsSeparatedByString:@"-"] firstObject];
    }
    
    return languageCode;
}

- (NSString *)getCountryCode
{
    return [NSLocale currentLocale].localeIdentifier;
}

- (void)setCurrencyCode:(NSString *)currencyCode
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:currencyCode forKey:kSettingCurrencyCode];
    
    [userDefaults synchronize];
}

- (NSString *)getCurrencyCode
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *currencyCode = [userDefaults objectForKey:kSettingCurrencyCode];
    
    if (currencyCode == nil || [currencyCode isEqualToString:@""])
    {
        currencyCode =[[NSLocale currentLocale] objectForKey:NSLocaleCurrencyCode];
    }
    
    return currencyCode;
}

- (NSString *)getCurrencySymbol
{
    return [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
}

- (NSString *)getLocalizedStringWithKey:(NSString *)key
{
    NSString *result = nil;
    
    NSString *currentLanguageCode = [self getLanguageCode];
    
    if([currentLanguageCode isEqualToString:@"ch"] || [currentLanguageCode isEqualToString:@"zh"])
    {
        currentLanguageCode = @"zh";
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LocalizedString"
                                                     ofType:@"strings"
                                                inDirectory:nil
                                            forLocalization:currentLanguageCode];
    
    if (path == nil) {
        path = [[NSBundle mainBundle] pathForResource:@"LocalizedString"
                                               ofType:@"strings"
                                          inDirectory:nil
                                      forLocalization:@"en"];
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    result = [dict objectForKey:key];
    
    if (result == nil) {
        result = @"Not Localized";
    }
    
    return result;
}

- (NSString *)getPathOfCacheDirectory
{
    NSString *result = nil;
    
    result = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    return result;
}

- (NSURLRequest *)makeRequestForLoadWebViewWithURLString:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    
    return req;
}

/* WKWebView 로드를 위한 Request 객체 생성
 *      기존 Request 객체 생성 방식으로 웹뷰를 로드할 경우, Default Cookie가 전달 되지 않아,
 *      Request 생성시 기존 Cookie를 HeaderField에 설정.
 */
- (NSURLRequest *)makeRequestForLoadWKWebViewWithURLString:(NSString *)urlStr
{
    NSURLRequest *result = nil;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *muRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSArray *defaultCookies = [self getAllCookies];
    
    NSDictionary *headerFieldWithCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:defaultCookies];
    
    muRequest.allHTTPHeaderFields = headerFieldWithCookies;
    
    result = muRequest;
    
    return result;
}

- (CGFloat)getStringHeightWithString:(NSString *)str maxWidth:(CGFloat)maxWidth font:(UIFont *)fontType
{
    CGFloat result = 0.0f;
    
    NSDictionary *attr = @{NSFontAttributeName : fontType};
    
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    result = textRect.size.height;
    
    return result;
}

- (CGFloat)getStringHeightWithString:(NSString *)str maxWidth:(CGFloat)maxWidth maxLine:(NSInteger)maxLine font:(UIFont *)fontType
{
    CGFloat result = 0.0f;
    
    NSDictionary *attr = @{NSFontAttributeName : fontType};
    
    NSString *checkChar = @"K";
    CGSize checkCharSize = [checkChar sizeWithAttributes:attr];
    
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(maxWidth, maxLine * checkCharSize.height) options: NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    result = textRect.size.height;
    
    return result;
}


- (CGFloat)getStringHeightWithString:(NSString *)str maxWidth:(CGFloat)maxWidth font:(UIFont *)fontType lineSpacing:(NSInteger)spacing
{
    CGFloat result = 0.0f;
    
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:spacing];
    
    NSDictionary *attr = @{NSFontAttributeName : fontType,
                           NSParagraphStyleAttributeName : paragrahStyle};
    
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    result = textRect.size.height;
    
    return result;
}

- (CGFloat)getHeightOfAttributedString:(NSString *)str maxWidth:(CGFloat)maxWidth attr:(NSDictionary *)attr
{
    CGFloat result = 0.0f;
    
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    result = textRect.size.height;
    
    return result;
}

- (CGFloat)getStringWidthWithString:(NSString *)str maxWidth:(CGFloat)maxWidth maxLine:(NSInteger)maxLine font:(UIFont *)fontType
{
    CGFloat result = 0.0f;
    
    NSDictionary *attr = @{NSFontAttributeName : fontType};
    
    NSString *checkChar = @"K";
    CGSize checkCharSize = [checkChar sizeWithAttributes:attr];
    
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(maxWidth, maxLine * checkCharSize.height) options: NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    result = textRect.size.width;
    
    return result;
}

- (NSAttributedString *)getDefaultAttrStringWithText:(NSString *)text fontType:(UIFont *)fontType fontColor:(UIColor *)fontColor
{
    NSAttributedString *result = nil;
    
    NSDictionary *attr = @{NSFontAttributeName : fontType,
                           NSForegroundColorAttributeName : fontColor};
    
    result = [[NSAttributedString alloc] initWithString:text attributes:attr];
    
    return result;
}

- (double)randomFromMinimum: (double) min toMax:(double) max
{
    double result = 0.0f;
    
    double random = arc4random() / ((double) (((long long)2<<31) -1));
    
    result = random / (max-min) + min;
    
    return result;
}

- (NSURLRequest *)getRequestObjWithURLString:(NSString *)urlStr
{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    
    return req;
}

- (NSURLRequest *)getRequestObjWithURLString:(NSString *)urlStr cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval
{
    return [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr] cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
}

- (void)addModalAnimationWithView:(UIView *)view isPresent:(BOOL)isPresent
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.28f;
    
    if (isPresent == YES)
    {
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
    }
    else
    {
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromBottom;
    }
    
    [view.layer addAnimation:transition forKey:kCATransition];
}

- (CATransition *)fadeOutAnimationForChangeImage
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    return transition;
}

- (void)drawSquareLineWithTargetView:(UIView *)targetView
                               Color:(UIColor *)lineColor
                           lineWidth:(CGFloat)lineWidth
                            drawType:(YHDrawSquareType)drawType

{
    CGRect bounds = targetView.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    
    switch (drawType)
    {
        case YHDrawSquareTypeAllLine:
            CGContextMoveToPoint(context, 0.0f, 0.0f);
            CGContextAddLineToPoint(context, bounds.size.width, 0.0f);
            CGContextAddLineToPoint(context, bounds.size.width, bounds.size.height);
            CGContextAddLineToPoint(context, 0.0f, bounds.size.height);
            CGContextAddLineToPoint(context, 0.0f, 0.0f);
            break;
        case YHDrawSquareTypeExcludeTopLine:
            CGContextMoveToPoint(context, bounds.size.width, 0.0f);
            CGContextAddLineToPoint(context, bounds.size.width, bounds.size.height);
            CGContextAddLineToPoint(context, 0.0f, bounds.size.height);
            CGContextAddLineToPoint(context, 0.0f, 0.0f);
            break;
        case YHDrawSquareTypeExcludeLeftLine:
            CGContextMoveToPoint(context, 0.0f, 0.0f);
            CGContextAddLineToPoint(context, bounds.size.width, 0.0f);
            CGContextAddLineToPoint(context, bounds.size.width, bounds.size.height);
            CGContextAddLineToPoint(context, 0.0f, bounds.size.height);
            break;
        case YHDrawSquareTypeExcludeRightLine:
            CGContextMoveToPoint(context, bounds.size.width, 0.0f);
            CGContextAddLineToPoint(context, 0.0f, 0.0f);
            CGContextAddLineToPoint(context, 0.0f, bounds.size.height);
            CGContextAddLineToPoint(context, bounds.size.width, bounds.size.height);
            break;
        case YHDrawSquareTypeExcludeBottomLine:
            CGContextMoveToPoint(context, 0.0f, bounds.size.height);
            CGContextAddLineToPoint(context, 0.0f, 0.0f);
            CGContextAddLineToPoint(context, bounds.size.width, 0.0f);
            CGContextAddLineToPoint(context, bounds.size.width, bounds.size.height);
            break;
        default:
            
            break;
    }
    
    // and now draw the Path!
    CGContextStrokePath(context);
}


- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (id)getObjForKeyWithDictionary:(NSDictionary *)dic key:(NSString *)key
{
    id result;
    
    result = [dic objectForKey:key];
    
    if (result == [NSNull null]) {
        result = nil;
    }
    
    return result;
}

- (NSString *)getJsonStringWithDictionary:(NSDictionary *)dic prettyPrint:(BOOL)prettyPrint
{
    NSString *result = nil;
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic
                                                    options:(NSJSONWritingOptions) (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                      error:&error];
    if (!data)
    {
        LogRed(@"error: %@", error.localizedDescription);
        return @"[]";
    }
    else
    {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return result;
}

- (NSArray *)getAllCookies
{
    NSHTTPCookieStorage *cs = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookies = cs.cookies;
    
    return cookies;
}

- (void)deleteAllCookies
{
    NSHTTPCookieStorage *cs = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [self getAllCookies];
    
    for (NSHTTPCookie *cookie in cookies) {
        [cs deleteCookie:cookie];
    }
}

#pragma mark - JSON String to Object
- (id)convertedObjectWithData:(id)data
{
    id convertedObject = nil;
    
    if ([data isKindOfClass:[NSString class]])
    {
        convertedObject = [NSJSONSerialization JSONObjectWithData:[(NSString *)data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    
    return convertedObject;
}

- (void)blockUI
{
    appDelegate.window.userInteractionEnabled = NO;
}

- (void)unblockUI
{
    appDelegate.window.userInteractionEnabled = YES;
}


- (NSMutableURLRequest *)getURLRequestWithURLString:(NSString *)url
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
}

- (NSMutableURLRequest *)getURLRequestWithHTTPMethod:(NSString *)methodType
                                                 url:(NSString *)url
                                     parameterString:(NSString *)paramStr
                                          encodeType:(NSString *)encodeType
{
    NSMutableURLRequest *request = [self getURLRequestWithURLString:url];
    
    if([methodType isEqualToString:@"POST"])
    {
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:methodType];
        
        if ([encodeType isEqualToString:@"euc-kr"])
        {
            // EUC-KR
            NSUInteger encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingEUC_KR);
            const char * encodedParamsStr = [paramStr cStringUsingEncoding:encoding];
            [request setHTTPBody:[NSData dataWithBytes:encodedParamsStr length:strlen(encodedParamsStr)]];
        }
        else // UTF-8
        {
            [request setHTTPBody:[NSData dataWithBytes:[paramStr UTF8String] length:strlen([paramStr UTF8String])]];
        }
    }
    
    return request;
}

- (NSString *)valueInQuery:(NSString *)query key:(NSString *)key
{
    NSString *result = nil;
    
    @try
    {
        NSArray *params = [query componentsSeparatedByString:@"&"];
        
        for (NSString *queryComponent in params) {
            
            if ([queryComponent hasPrefix:[NSString stringWithFormat:@"%@=",key]]) {
                NSArray *seperatedComponent = [queryComponent componentsSeparatedByString:@"="];
                result = [seperatedComponent objectAtIndex:1];
                result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
        }
    }
    @catch (NSException *exception) {
        LogRed(@"exception : %@",exception);
    }
    
    return result;
}


#pragma mark - Google Analytics
- (void)initGA
{
    [YHGoogleAnalytics initWithTrackerID];
}

- (void)sendGAWithCategory:(NSString *)category
                    action:(NSString *)action
                     label:(NSString *)label
{
    [self.ga sendGAEventWithCategory:category action:action label:label];
}

- (void)sendGAScreenName:(NSString *)screenName
{
    [self.ga sendGAScreenName:screenName];
}


@end
