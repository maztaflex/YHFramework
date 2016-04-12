//
//  YHPushModel.h
//  SUMPreOrder
//
//  Created by DEV_TEAM1_IOS on 2015. 10. 6..
//  Copyright © 2015년 S.M Entertainment. All rights reserved.
//

@class UIApplication;

@interface YHPushModel : NSObject

// 수신된 DeivceToken Data 변환
+ (NSString *)convertDeviceTokenToString:(id)deviceToken;

// 시스템 설정의 Push 활성화 확인
- (BOOL)isOnRemotePush; 

// APNS로부터 DeviceToken 요청
- (void)registerForParseRemoteNotificationWithApplication:(UIApplication *)application;

// 저장된 DeviceToken 정보
- (NSString *)getDeviceToken;

// DeviceToken 정보 저장
- (void)saveDeviceToken:(NSString *)deviceToken;

@end
