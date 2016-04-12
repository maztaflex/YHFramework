//
//  YHViewController.h
//
//  Created by DEV_TEAM1_IOS on 2015. 8. 25..
//  Copyright (c) 2015년 S.M Entertainment. All rights reserved.
//
#import "ProgressHUD.h"

@interface YHViewController : UIViewController

@property (weak, nonatomic) YHTools *tools;

@property (assign, nonatomic) YHViewTransitionType appliedTransitionType;

@property (nonatomic, assign) BOOL didSetupConstraints;

- (void)disableUI;
- (void)enableUI;
- (void)disableUIWithUsingProgressHud;
- (void)enableUIWithUsingProgressHud;
- (void)orientationChanged:(NSNotification *)notification;

#pragma mark - Local Notification
- (void)registerLocalNotification;
- (void)unregisterLocalNotification;
- (void)handlerForNotificationCenter:(NSNotification *)notification;

#pragma mark - Handler for Subviews
- (void)configureLayout;
- (void)refreshAllUI;
- (void)refreshAllWebView;

// View Animations
- (void)removeFromSuperViewWithDissolveAnimation:(UIView *)aView completion:(void (^)(void))completion;
- (void)performAnimationCell:(UITableViewCell *)cell;
- (void)performAnimationCell:(UITableViewCell *)cell isScrollUp:(BOOL)isScrollUp;

// Default Alert View
- (void)showDefaultAlertViewWithMessage:(NSString *)message confirmButtonTitle:(NSString *)buttonTitle;
- (void)showAlertViewWithMessage:(NSString *)message
              confirmButtonTitle:(NSString *)confirmTitle
               cancelButtonTitle:(NSString *)cancelTitle
               confirmCompletion:(void(^)(void))confirmCompletion;

#pragma mark - Etc.
- (BOOL)isScrollUpWithScrollView:(UIScrollView *)scrollView;

#pragma mark - Call Phone Number
- (void)showAlertOfPhoneCallWithNumber:(NSString *)phoneNumber;

@end
