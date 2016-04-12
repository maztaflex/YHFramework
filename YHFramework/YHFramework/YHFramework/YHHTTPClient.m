//
//  YHHTTPClient.m
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 2. 19..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import "YHHTTPClient.h"

@implementation YHHTTPClient

- (void)requestGET:(NSString *)urlString parameters:(id)parameter success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [self GET:urlString parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestPOST:(NSString *)urlString parameters:(id)parameter success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    [self POST:urlString parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestPUT:(NSString *)urlString
        parameters:(id)parameter
           success:(void (^)(id result))success
           failure:(void (^)(NSError *error))failure
{
    [self PUT:urlString parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestPATCH:(NSString *)urlString
          parameters:(id)parameter
             success:(void (^)(id result))success
             failure:(void (^)(NSError *error))failure
{
    [self PATCH:urlString parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestDELETE:(NSString *)urlString
           parameters:(id)parameter
              success:(void (^)(id result))success
              failure:(void (^)(NSError *error))failure
{
    [self DELETE:urlString parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}



@end
