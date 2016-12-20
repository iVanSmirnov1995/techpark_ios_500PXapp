//
//  OSSubscribersTableVC.m
//  500PXapp
//
//  Created by user on 21.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "OSSubscribersTableVC.h"
#import "OSCustomCellForSubsTVC.h"
#import "ISServerManager.h"
#import "MyPageVC.h"

@interface OSSubscribersTableVC () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *followers;
@property (assign, nonatomic) NSInteger followersCount;

@end

@implementation OSSubscribersTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.followers = [[NSMutableArray alloc] init];
    
    [self getFollowersFromServer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

-(void) getFollowersFromServer {
    [[ISServerManager sharedManager]
     getFollowersOnUserID: self.userID
     withPage: self.followers.count/20 + 1
     onSuccess: ^(NSArray *followers, NSInteger followersCount) {

         if(!self.followersCount) {
             self.followersCount = followersCount;
         }
         [self.followers addObjectsFromArray:followers];
         
         NSMutableArray* newPath = [NSMutableArray array];
         for (int i = ((int)self.followers.count - (int)followers.count); i < self.followers.count; i++) {
             [newPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView beginUpdates];
             [self.tableView insertRowsAtIndexPaths:newPath withRowAnimation:UITableViewRowAnimationTop];
             [self.tableView endUpdates];
         });
     }
     onFailure: ^(NSError *error, NSInteger statusCode) {
         
     }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.followers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OSCustomCellForSubsTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    OSCustomCellForSubTVC *follower = [[OSCustomCellForSubTVC alloc] init];
    follower.avatarURL = [[[self.followers[row]
                             objectForKey: @"avatars"]
                            objectForKey:@"small"]
                           objectForKey:@"https"];
    follower.name = [self.followers[row] objectForKey:@"fullname"];
    
    [cell fillCellWithModel: follower];
    
    if(indexPath.row + 1 == self.followers.count && indexPath.row + 1 < self.followersCount) {
        [self getFollowersFromServer];
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyPageVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"myPage"];
    vc.userID = [[self.followers[indexPath.row] objectForKey:@"id"] integerValue];
    [self.navigationController pushViewController:vc animated:YES];
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
