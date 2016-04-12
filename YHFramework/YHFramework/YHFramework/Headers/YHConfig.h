//
//  YHConfig.h
//
//  Created by DEV_TEAM1_IOS on 2015. 8. 25..
//  Copyright (c) 2015년 S.M Entertainment. All rights reserved.
//

#ifndef YHConfig_h
#define YHConfig_h

// Google Analytics
#if DEBUG || INHOUSE
    #define kGoogleAnalyticsTrackerID                                           @"UA-62576516-5"
    #define kGoogleMapAPIKey                                                    @"AIzaSyBMdPSu8_Mm7U1-PuqO4482xjGqIkWpBPk"
#elif RELEASE
    #define kGoogleAnalyticsTrackerID                                           @"UA-48434587-38"
    #define kGoogleMapAPIKey                                                    @"AIzaSyD0LraDIshRgtUCI6wrS6I2lrIdCvda_hE"
#endif

// NSUserDefault Key For User Preference
#define kHasBeenLaunched                                                        @"hasBeenLaunched"
#define kSettingLanguageCode                                                    @"languageCode"
#define kSettingCurrencyCode                                                    @"currencyCode"
#define kIsRegisgeredRemotePush                                                 @"isRegisteredPush"
#define kEnabledPushSetting                                                     @"enabledPushSetting"
#define kIsAutoSignIn                                                           @"isAutoSignIn"
#define kDeviceToken                                                            @"deviceToken"

// NotificationCenter Names
#define YHGoogleLoginSuccessNotification                                        @"yh.google.login.success"
#define YHShouldGooglePlusInstallNotification                                   @"yh.google.plus.install"
#define YHApplicationOpenGoogleAuthNotification                                 @"yh.open.google.auth"
#define YHShouldStartShareGooglePlusNotification                                @"yh.start.google.share"
#define YHSplashViewTaskDoneNotification                                        @"yh.splashtask.done"
#define YHShouldAllRefreshNotification                                          @"yh.all.refresh"
#define YHShouldAllWebViewRefreshNotification                                   @"yh.allwebview.refresh"
#define YHShouldHandlePushInfoNotification                                      @"yh.handle.pushInfo"
#define YHChangedPushSettingNotification                                        @"yh.rightmenu.refresh"

#endif
