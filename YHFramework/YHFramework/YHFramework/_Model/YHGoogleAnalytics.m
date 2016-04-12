//
//  YHGoogleAnalytics.m
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 3. 24..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import "YHGoogleAnalytics.h"
#import <Google/Analytics.h>

@implementation YHGoogleAnalytics

// GoogleService-Info.plist 파일 확인
+ (void)initWithConfigurePlist;
{
    //Configure tracker from GoogleService-Info.plist.
    NSError *configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    // Optional: configure GAI options.
    GAI *gai = [GAI sharedInstance];
    gai.trackUncaughtExceptions = YES;
    
#if DEBUG || INHOUSE
    gai.dispatchInterval = 1.0f; // GA 전송 시간 간격 설정
//    gai.logger.logLevel = kGAILogLevelVerbose;
#else
    gai.dispatchInterval = 30.0f; // GA 전송 시간 간격 설정
#endif
    
}

+ (void)initWithTrackerID
{
    GAI *gai = [GAI sharedInstance];
    gai.trackUncaughtExceptions = YES;
    
#if DEBUG || INHOUSE
    gai.dispatchInterval = 1.0f; // GA 전송 시간 간격 설정
//    gai.logger.logLevel = kGAILogLevelVerbose;
#else
    gai.dispatchInterval = 30.0f; // GA 전송 시간 간격 설정
#endif

}

// 화면 이름 전송
- (void)sendGAScreenName:(NSString *)scName
{
    LogGreen(@"kGoogleAnalyticsTrackerID : %@",kGoogleAnalyticsTrackerID);
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:kGoogleAnalyticsTrackerID];
    [tracker set:kGAIScreenName value:scName];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

// 이벤트 전송
- (void)sendGAEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label
{
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:kGoogleAnalyticsTrackerID];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                          action:action
                                                           label:label
                                                           value:@1] build]];
}

@end
