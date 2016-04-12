//
//  YHBarcode.h
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 3. 10..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBarcode : NSObject

- (instancetype)initWithBarcode:(NSString *)barcode;

- (instancetype)initWithBarcode:(NSString *)barcode size:(CGSize)size;

- (UIImage *)generateVerticalBarcode128Image;

- (UIImage *)generateBarcode128Image;

@end
