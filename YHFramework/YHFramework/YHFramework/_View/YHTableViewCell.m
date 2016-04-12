//
//  YHTableViewCell.m
//  SUMPreOrder
//
//  Created by DEV_TEAM1_IOS on 2015. 9. 15..
//  Copyright (c) 2015년 S.M Entertainment. All rights reserved.
//

#import "YHTableViewCell.h"

@interface YHTableViewCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation YHTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _tools = [YHTools sharedInstance];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
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
