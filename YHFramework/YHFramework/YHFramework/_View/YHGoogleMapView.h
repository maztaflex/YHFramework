//
//  YHGoogleMapView.h
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 3. 22..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGoogleMapView : NSObject

+ (void)initWithAPIKey:(NSString *)key;

+ (UIView *)googleMapWithWithLatitude:(float)latitude
                            longitude:(float)longitude
                                title:(NSString *)title
                                 desc:(NSString *)desc;

@end
