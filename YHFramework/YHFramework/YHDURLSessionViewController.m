//
//  YHDURLSessionViewController.m
//  YHFramework
//
//  Created by DEV_TEAM1_IOS on 2016. 4. 22..
//  Copyright © 2016년 DoozerStage. All rights reserved.
//

#import "YHDURLSessionViewController.h"

#define YHDMembershipStoreAPI                         @"https://pointapibeta.smtown.com/api/v1/brand"           // GET
#define YHDCelebAuthorizeAPI                          @"https://pointapibeta.smtown.com/api/v1/introAuthCode"    // POST

#pragma mark - Models
@interface APIBaseResults : NSObject

@property (assign, nonatomic) NSInteger code;
@property (nonatomic)         id        data;
@property (strong, nonatomic) NSString  *message;
@property (assign, nonatomic) BOOL      result;

@end

@implementation APIBaseResults


@end
#pragma mark -

@interface YHDURLSessionViewController ()

@property (strong, nonatomic) NSURLSession *urlSession;

@end

@implementation YHDURLSessionViewController

#pragma mark - View Life Cycle

// 1.
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _urlSession = [NSURLSession sharedSession];
    }
    
    return self;
}

// 2.
- (void)awakeFromNib
{
    [super awakeFromNib];
}

// 3.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"URLSessionTask";
    
    [self testPostMethod];
}

#pragma mark - Test
- (void)testGetMethod
{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:YHDMembershipStoreAPI] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dicJsonObject = nil;
        
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            dicJsonObject = jsonObject;
        }
        
        LogGreen(@"dicJsonObject : %@",dicJsonObject);
    }];
    
    [dataTask resume];
}

- (void)testPostMethod
{
    LogGreen(@"self.urlSession : %@",self.urlSession);
    
    NSDictionary *parameters = @{@"authCode" : @"1111"};
    
    NSURLRequest *req = [self generateRequestWithURLString:YHDCelebAuthorizeAPI httpMethod:@"POST" parameters:parameters];
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *dicJsonObject = nil;
            
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                dicJsonObject = jsonObject;
            }
            
            LogGreen(@"dicJsonObject : %@",dicJsonObject);
        }
        
        LogGreen(@"error : %@",error);
    }];
    
    [dataTask resume];
}

#pragma mark - Private Method
- (NSURLRequest *)generateRequestWithURLString:(NSString *)urlString
                                    httpMethod:(NSString *)httpMethod
                                    parameters:(NSDictionary *)parameters
{
    NSMutableURLRequest *urlRequest = nil;
    
    NSData *bodyData = nil;
    
    urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:30.0f];
    
    if ([NSJSONSerialization isValidJSONObject:parameters]) {
        LogGreen(@"valid object!");
        bodyData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    } else {
        LogGreen(@"not valid object!");
    }
    
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:httpMethod];
    [urlRequest setHTTPBody:bodyData];
    
    return urlRequest;
}

@end
