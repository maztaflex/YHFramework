//
//  YHGoogleMapView.m
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 3. 22..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import "YHGoogleMapView.h"

@import GoogleMaps;

@interface YHGoogleMapView ()

@end

@implementation YHGoogleMapView

+ (void)initWithAPIKey:(NSString *)key
{
    [GMSServices provideAPIKey:key];
}

+ (UIView *)googleMapWithWithLatitude:(float)latitude
                            longitude:(float)longitude
                                title:(NSString *)title
                                 desc:(NSString *)desc
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    
    if (title != nil) {
        marker.title = title;
    }
    
    if (desc != nil) {
        marker.snippet = desc;
    }
    
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView;
    
    return mapView;
}

@end
