//
//  YHBarcode.m
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 3. 10..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import "YHBarcode.h"
#import <ZXingObjC/ZXMultiFormatWriter.h>
#import <ZXingObjC/ZXBitMatrix.h>
#import <ZXingObjC/ZXImage.h>

#define kDefaultBarcodeSize                 CGSizeMake(300.0f, 1000.0f)

@interface YHBarcode ()

@property (strong, nonatomic) NSString *barCode;
@property (assign, nonatomic) CGSize barcodeSize;

@end

@implementation YHBarcode

- (instancetype)initWithBarcode:(NSString *)barcode
{
    if (self = [super init]) {
        _barCode = barcode;
        _barcodeSize = kDefaultBarcodeSize;
        
    }
    
    return self;
}

- (instancetype)initWithBarcode:(NSString *)barcode size:(CGSize)size
{
    if (self = [super init]) {
        _barCode = barcode;
        _barcodeSize = size;
    }
    
    return self;    
}

- (UIImage *)generateVerticalBarcode128Image
{
    UIImage *barcodeImage = [self generateBarcode128Image];
    
    if(barcodeImage)
    {
        barcodeImage = [UIImage imageWithCGImage:barcodeImage.CGImage scale:1.0f orientation:UIImageOrientationLeft];
    }
    else
    {
        barcodeImage = nil;
    }
    
    return barcodeImage;
}

- (UIImage *)generateBarcode128Image
{
    NSError *error = nil;
    
    UIImage *barcodeImage = nil;
    
    int minimumWidth = 1;
    
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix *result = [writer encode:self.barCode
                                  format:kBarcodeFormatCode128
                                   width:minimumWidth
                                  height:self.barcodeSize.height
                                   error:&error];
    
    if (result) {
        ZXImage *image = [ZXImage imageWithMatrix:result];
        barcodeImage = [UIImage imageWithCGImage:image.cgimage];
    } else {
        barcodeImage = nil;
    }
    
    return barcodeImage;
}

@end
