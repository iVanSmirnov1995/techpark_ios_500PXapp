//
//  MyPageVC.m
//  500PXapp
//
//  Created by user on 20.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "MyPageVC.h"
#import "ISServerManager.h"
#import "ISUser.h"
#import "OSSubscribersTableVC.h"
#import "OSFriendsTVC.h"
#import "ISTabBarVC.h"

#import "UIImageView+AFNetworking.h"
#import "ISUserData+CoreDataProperties.h"


@interface MyPageVC ()

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIImageView *miniature;
@property (weak, nonatomic) IBOutlet UIView *avatarParentView;
@property (weak, nonatomic) IBOutlet UIView *editProfileView;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *folowers;
@property (weak, nonatomic) IBOutlet UIButton *friends;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation MyPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.avatarParentView layoutIfNeeded];
    self.avatarParentView.layer.masksToBounds = YES;
    self.avatarParentView.layer.cornerRadius = self.avatarParentView.frame.size.width / 2;
    
    [self.avatar layoutIfNeeded];
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ISUserData"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    ISUserData * userData = resultArray[0];
    
    self.userID = userData.userID;
    
    self.userName.text = userData.userName;
    NSLog(@"%@", self.userName.text);
    
    if(![userData.firstName isEqual:[NSNull null]]) {
        self.fullName.text = [NSString stringWithFormat:@"%@", userData.firstName];
        if(![userData.lastName isEqual:[NSNull null]]) {
            self.fullName.text = [NSString stringWithFormat:@"%@ %@",
                                  self.fullName.text, userData.lastName];
        }
    } else if (![userData.lastName isEqual:[NSNull null]]) {
        self.fullName.text = [NSString stringWithFormat:@"%@", userData.lastName];
    }
    NSLog(@"%@", self.fullName.text);
    
    
    if(![userData.cover isEqual:[NSNull null]]) {
        [self.miniature setImageWithURL:[NSURL URLWithString:userData.cover]];
    }
    
    if(![userData.avatar isEqual:[NSNull null]]) {
        [self.avatar setImageWithURL: [NSURL URLWithString:userData.avatar]];
    }
    [self.folowers setTitle:
     [NSString stringWithFormat:@"%ld подписчиков", (long)userData.followersCount]
                   forState:UIControlStateNormal];
    NSLog(@"%@", self.folowers.currentTitle);
    [self.friends setTitle:[NSString stringWithFormat:@"%ld друзей", (long)userData.friendsCount]
                  forState:UIControlStateNormal];
    
    [self.indicator stopAnimating];
}

//#pragma mark - API


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)folowersButtonPressed:(id)sender {
    
    OSSubscribersTableVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"usersList"];
    vc.userID = self.userID;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)friendsButtonPressed:(id)sender {
    
    OSFriendsTVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"friendsList"];
    vc.userID = self.userID;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)exitButtonPressed:(id)sender {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ISUserData"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    ISUserData * userData = resultArray[0];
    userData.avatar = nil;
    userData.cover = nil;
    userData.firstName = nil;
    userData.followersCount = 0;
    userData.friendsCount = 0;
    userData.lastName = nil;
    userData.name = nil;
    userData.oauthToken = nil;
    userData.oauthTokenSecret = nil;
    userData.userID = 0;
    userData.userName = nil;
    
    ISTabBarVC* vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ISTabBarVC"];
    
    [self presentViewController:vc animated:YES completion: nil];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
