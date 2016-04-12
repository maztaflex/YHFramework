//
//  YHDTableViewController.m
//  YHFramework
//
//  Created by DEV_TEAM1_IOS on 2016. 4. 12..
//  Copyright © 2016년 DoozerStage. All rights reserved.
//

#import "YHDTableViewController.h"

#define YHDMenuListCount                                        2

#define YHDSegueIdMainToYoutubeModal                            @"sgMainToYoutubeModal"

typedef NS_ENUM(NSInteger, YHDMenuType)
{
    YHDMenuType_XCDYouTubeKit = 0,
    YHDMenuType_YTPlayerView,
};

@interface YHDTableViewController ()

@property (nonatomic, strong) NSArray *menuList;

@end

@implementation YHDTableViewController
- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"API TEST";
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger indexRow = indexPath.row;
    
    YHDMenuType menuType = indexRow;
    
    switch (menuType) {
        case YHDMenuType_XCDYouTubeKit:
            [self performSegueWithIdentifier:YHDSegueIdMainToYoutubeModal sender:self];
            break;
            
        default:
            break;
    }
    
    LogGreen(@"didSelect : %@",[self getMenuTitleWithType:menuType]);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return YHDMenuListCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"MenuCell";
    
    NSInteger indexRow = indexPath.row;
    
    YHDMenuType menuType = indexRow;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.textLabel.text = [self getMenuTitleWithType:menuType];
    
    return cell;
}

#pragma mark - Private Mehtod
- (NSString *)getMenuTitleWithType:(YHDMenuType)menuType
{
    NSString *result = nil;
    
    switch (menuType) {
        case YHDMenuType_XCDYouTubeKit:
            result = @"XCDYouTubeKit";
            break;
        case YHDMenuType_YTPlayerView:
            result = @"YTPlayerView";
            break;
        default:
            break;
    }
    
    return result;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
