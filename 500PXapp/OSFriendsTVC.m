//
//  OSFriendsTVC.m
//  500PXapp
//
//  Created by user on 17.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "OSFriendsTVC.h"
#import "OSCustomCellForSubsTVC.h"
#import "ISServerManager.h"
#import "MyPageVC.h"

@interface OSFriendsTVC ()

@property (strong, nonatomic) NSMutableArray *friends;

@end

@implementation OSFriendsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.friends = [[NSMutableArray alloc] init];
    
    [self getFriends];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

-(void) getFriends {
    [[ISServerManager sharedManager]
     getFriendsOnUserID: self.userID
     withPage: self.friends.count/20 + 1
     onSuccess: ^(NSArray *friends) {
         
         [self.friends addObjectsFromArray:friends];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
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
    return self.friends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OSCustomCellForSubsTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFriend" forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    OSCustomCellForSubTVC *friend = [[OSCustomCellForSubTVC alloc] init];
    friend.avatarURL = [[[self.friends[row]
                            objectForKey: @"avatars"]
                           objectForKey:@"small"]
                          objectForKey:@"https"];
    friend.name = [self.friends[row] objectForKey:@"fullname"];
    friend.userID = [[self.friends[row] objectForKey:@"id"] integerValue];
    
    [cell fillCellWithModel: friend];
    
    if(indexPath.row == self.friends.count) {
        [self getFriends];
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyPageVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"myPage"];
    vc.userID = [[self.friends[indexPath.row] objectForKey:@"id"] integerValue];
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
