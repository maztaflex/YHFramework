//
//  YHPushModel.m
//
//  Created by DEV_TEAM1_IOS on 2015. 10. 6..
//  Copyright © 2015년 S.M Entertainment. All rights reserved.
//

#import "YHPushModel.h"

@implementation YHPushModel

+ (NSString *)convertDeviceTokenToString:(id)deviceToken {
    if ([deviceToken isKindOfClass:[NSString class]]) {
        return deviceToken;
    } else {
        NSMutableString *hexString = [NSMutableString string];
        const unsigned char *bytes = [deviceToken bytes];
        for (int i = 0; i < [deviceToken length]; i++) {
            [hexString appendFormat:@"%02x", bytes[i]];
        }
        return [NSString stringWithString:hexString];
    }
}

- (BOOL)isOnRemotePush
{
    BOOL isOn = NO;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") == YES)
    {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        UIUserNotificationType rType = setting.types;
        isOn = (rType == 0) ? NO : YES;
    }
    else
    {
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
        UIRemoteNotificationType rType = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        
        isOn = (rType == 0) ? NO : YES;
#endif
    }
    
    return isOn;
}

- (void)registerForParseRemoteNotificationWithApplication:(UIApplication *)application
{
    if ([self isExistDeviceToken] == YES) return;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") == YES)
    {
        // iOS 8 이상 Device Token 정보 등록
        // Register for Push Notitications
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
        
    }
    else
    {
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
        // iOS 8 미만 Device Token 정보 등록
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
#endif

    }
}

- (NSString *)getDeviceToken
{
    NSString *result = nil;
    
    result = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    
    return result;
}

- (void)saveDeviceToken:(NSString *)deviceToken
{
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:kDeviceToken];
}

- (BOOL)isExistDeviceToken
{
    BOOL result = NO;
    
    NSString *deviceToken = [self getDeviceToken];
    
    if (deviceToken) {
        result = YES;
    }
    
    LogGreen(@"isExistDeviceToken : %zd",result);
    
    return result;
}

@end
