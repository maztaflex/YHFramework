//
//  YHHTTPClient.h
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 2. 19..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface YHHTTPClient : AFHTTPRequestOperationManager

- (void)requestGET:(NSString *)urlString
        parameters:(id)parameter
           success:(void (^)(id result))success
           failure:(void (^)(NSError *error))failure;

- (void)requestPOST:(NSString *)urlString
         parameters:(id)parameter
            success:(void (^)(id result))success
            failure:(void (^)(NSError *error))failure;

- (void)requestPUT:(NSString *)urlString
        parameters:(id)parameter
           success:(void (^)(id result))success
           failure:(void (^)(NSError *error))failure;

- (void)requestPATCH:(NSString *)urlString
          parameters:(id)parameter
             success:(void (^)(id result))success
             failure:(void (^)(NSError *error))failure;

- (void)requestDELETE:(NSString *)urlString
           parameters:(id)parameter
              success:(void (^)(id result))success
              failure:(void (^)(NSError *error))failure;

@end
