//
//  YHGoogleAnalytics.h
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 3. 24..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGoogleAnalytics : NSObject

// GoogleService-Info.plist 정보로 부터 초기화
+ (void)initWithConfigurePlist;

// TrackerID로 부터 초기화
+ (void)initWithTrackerID;

// 화면 이름 전송
- (void)sendGAScreenName:(NSString *)scName;

// 이벤트 전송
- (void)sendGAEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label;
@end
