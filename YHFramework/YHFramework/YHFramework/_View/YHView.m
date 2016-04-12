//
//  YHView.m
//
//  Created by DEV_TEAM1_IOS on 2015. 8. 25..
//  Copyright (c) 2015년 S.M Entertainment. All rights reserved.
//

#import "YHView.h"

@interface YHView ()

@property (assign, nonatomic) BOOL didSetupConstraints;

@end

@implementation YHView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.tools = [YHTools sharedInstance];
}

- (instancetype)init
{
    if(self = [super init])
    {
        _tools = [YHTools sharedInstance];
    }
    
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!self.didSetupConstraints)
    {
        [self configureLayout];
        
        self.didSetupConstraints = YES;
    }
    
    [super setNeedsUpdateConstraints];
}

- (void)configureLayout{}


@end
