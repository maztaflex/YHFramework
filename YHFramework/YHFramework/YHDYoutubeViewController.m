//
//  YHDYoutubeViewController.m
//  YHFramework
//
//  Created by DEV_TEAM1_IOS on 2016. 4. 12..
//  Copyright © 2016년 DoozerStage. All rights reserved.
//

#import "YHDYoutubeViewController.h"
#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import <YTPlayerView.h>
#import "AppDelegate.h"

@interface YHDYoutubeViewController () <YTPlayerViewDelegate>

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;

@end

@implementation YHDYoutubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // n139g-IGSHo
    // https://youtu.be/n139g-IGSHo
    // https://www.youtube.com/embed/n139g-IGSHo
    self.playerView.delegate = self;
    
    NSDictionary *playerVars = @{@"playsinline" : @0};
    
    [self.playerView loadWithVideoId:@"hMk2hj7ULw4" playerVars:playerVars];
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    LogGreen(@"supportedInterfaceOrientations : %zd",[self isPlayingVideo]);
//    
//    if ([self isPlayingVideo]) {
//        return UIInterfaceOrientationMaskAll;
//    }
//    
//    return UIInterfaceOrientationMaskPortrait;
//}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    LogGreen(@"viewWillTransitionToSize : %f, %f",size.width, size.height);
}

- (IBAction)touchedCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - YTPlayerViewDelegate
- (void)playerViewDidBecomeReady:(nonnull YTPlayerView *)playerView
{
    LogGreen(@"playerViewDidBecomeReady");
}

- (void)playerView:(nonnull YTPlayerView *)playerView didChangeToState:(YTPlayerState)state
{
    LogGreen(@"didChangeToState : %zd",state);
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    switch (state) {
        case kYTPlayerStatePlaying:
            [self allowLandscapeOrientaion:YES];
            break;
        default:
            [self allowLandscapeOrientaion:NO];
            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
            break;
    }
//    [self.view setNeedsLayout];
//    [self.view setNeedsDisplay];
}

- (void)allowLandscapeOrientaion:(BOOL)allow
{
    appDelegate.isPlayingVideo = allow;
}

- (BOOL)isPlayingVideo
{
    BOOL result = appDelegate.isPlayingVideo;
    
    return result;
}

/**
 * Callback invoked when playback quality has changed.
 *
 * @param playerView The YTPlayerView instance where playback quality has changed.
 * @param quality YTPlaybackQuality designating the new playback quality.
 */
- (void)playerView:(nonnull YTPlayerView *)playerView didChangeToQuality:(YTPlaybackQuality)quality
{
    LogGreen(@"didChangeToQuality : %zd",quality);
}

/**
 * Callback invoked when an error has occured.
 *
 * @param playerView The YTPlayerView instance where the error has occurred.
 * @param error YTPlayerError containing the error state.
 */
- (void)playerView:(nonnull YTPlayerView *)playerView receivedError:(YTPlayerError)error
{
    LogRed(@"error : %zd",error);
}

/**
 * Callback invoked frequently when playBack is plaing.
 *
 * @param playerView The YTPlayerView instance where the error has occurred.
 * @param playTime float containing curretn playback time.
 */
- (void)playerView:(nonnull YTPlayerView *)playerView didPlayTime:(float)playTime
{
    
}

#pragma mark - XCDYouTubeKit
- (IBAction)touchedPlayButton:(id)sender {
    
    [self playVideo];
}

- (void) playVideo
{
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"9bZkp7q19f0"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
}

- (void) moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:notification.object];
    MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
    if (finishReason == MPMovieFinishReasonPlaybackError)
    {
        NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
        // Handle error
        
        LogRed(@"error : %@",error);
    }
}

@end
