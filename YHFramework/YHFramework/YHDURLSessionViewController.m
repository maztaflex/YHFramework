//
//  YHDURLSessionViewController.m
//  YHFramework
//
//  Created by DEV_TEAM1_IOS on 2016. 4. 22..
//  Copyright © 2016년 DoozerStage. All rights reserved.
//

#import "YHDURLSessionViewController.h"

#define YHDMemebershipStoreAPI                         @"https://pointapibeta.smtown.com/api/v1/brand"

@interface YHDURLSessionViewController ()

@end

@implementation YHDURLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"URLSessionTask";
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:YHDMemebershipStoreAPI]];
    
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dicJsonObject = nil;
        
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            dicJsonObject = jsonObject;
        }
        
        LogGreen(@"dicJsonObject : %@",dicJsonObject);
    }];
    
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
