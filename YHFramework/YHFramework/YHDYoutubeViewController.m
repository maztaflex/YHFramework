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

@interface YHDYoutubeViewController ()

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;

@end

@implementation YHDYoutubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.playerView loadWithVideoId:@"9bZkp7q19f0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
