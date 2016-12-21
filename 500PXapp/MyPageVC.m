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
#import "PhotoCollectionVC.h"
#import "UIImageView+AFNetworking.h"
#import "ISUserData+CoreDataProperties.h"
#import "OSGalleriesCVC.h"


@interface MyPageVC ()

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIImageView *miniature;
@property (weak, nonatomic) IBOutlet UIView *avatarParentView;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *folowers;
@property (weak, nonatomic) IBOutlet UIButton *friends;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;
@property (weak, nonatomic) IBOutlet UIButton *setingButton;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (assign, nonatomic) BOOL isFollow;

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
    
    self.fullName.text = @"";
    self.userName.text = @"";
    [self.folowers setTitle:@"" forState:UIControlStateNormal];
    [self.friends setTitle:@"" forState:UIControlStateNormal];
    
    self.followButton.hidden = YES;
    
    [self setUser];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - MyMethods

-(void) setUser {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ISUserData"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    ISUserData * userData = resultArray[0];
    
    if(!self.userID || self.userID == userData.userID) {
        self.userID = userData.userID;
        [self getMyUserFromServer];
    } else {
        self.exitButton.hidden = YES;
        self.setingButton.hidden = YES;
        [self getSpecifiedUserFromServer];
    }
}


#pragma mark - API

-(void) getMyUserFromServer {
    [[ISServerManager sharedManager] getUserOnSuccess:^(ISUser *user) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.userName.text = user.username;
            
            if(![user.firstName isEqual: [NSNull null]]) {
                self.fullName.text = [NSString stringWithFormat:@"%@", user.firstName];
                if(![user.lastName isEqual: [NSNull null]]) {
                    self.fullName.text = [NSString stringWithFormat:@"%@ %@",
                                          self.fullName.text, user.lastName];
                }
            } else if (![user.lastName isEqual: [NSNull null]]) {
                self.fullName.text = [NSString stringWithFormat:@"%@", user.lastName];
            }
            
            if(![user.cover isEqual: [NSNull null]]) {
                [self.miniature setImageWithURL:[NSURL URLWithString:user.cover]];
            }
            
            if(![user.avatar isEqual: [NSNull null]]) {
                [self.avatar setImageWithURL: [NSURL URLWithString:user.avatar]];
            }
            [self.folowers setTitle:
             [NSString stringWithFormat:@"%ld подписчиков", (long)user.followersCount]
                           forState:UIControlStateNormal];
            
            [self.friends setTitle:[NSString stringWithFormat:@"%ld друзей", (long)user.friendsCount]
                          forState:UIControlStateNormal];
            
            [self.indicator stopAnimating];
        });
        
    } onFailure:^(NSError *erroor, NSInteger errorCode) {
        NSLog(@"ERROR");
    }];
}

-(void) getSpecifiedUserFromServer {
    [[ISServerManager sharedManager] getUserOnID: self.userID onSuccess:^(NSDictionary *user) {
        
//        user.firstName=[userDic objectForKey:@"firstname"];
//        user.lastName=[userDic objectForKey:@"lastname"];
//        //                  user.sex=[[userDic objectForKey:@"sex"]floatValue];
//        user.city=[userDic objectForKey:@"city"];
//        user.avatar=[[[userDic objectForKey:@"avatars"]objectForKey:@"small"] objectForKey:@"https"];
//        user.userId=[[userDic objectForKey:@"id"]longValue];
//        user.username=[userDic objectForKey:@"username"];
//        user.cover = [userDic objectForKey:@"cover_url"];
//        user.friendsCount = [[userDic objectForKey:@"friends_count"] integerValue];
//        user.followersCount = [[userDic objectForKey:@"followers_count"] integerValue];
//        user.fullName = [ userDic objectForKey:@"full_name"];
//        //                  self.user=user;

        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.userName.text = [user objectForKey:@"username"];
            
            if(![[user objectForKey:@"firstname"] isEqual: [NSNull null]]) {
                self.fullName.text = [NSString stringWithFormat:@"%@", [user objectForKey:@"firstname"]];
                if(![[user objectForKey:@"lastname"] isEqual: [NSNull null]]) {
                    self.fullName.text = [NSString stringWithFormat:@"%@ %@",
                                          self.fullName.text, [user objectForKey:@"lastname"]];
                }
            } else if (![[user objectForKey:@"lastname"] isEqual: [NSNull null]]) {
                self.fullName.text = [NSString stringWithFormat:@"%@", [user objectForKey:@"lastname"]];
            }
            
            if(![[user objectForKey:@"cover_url"] isEqual: [NSNull null]]) {
                [self.miniature setImageWithURL:[NSURL URLWithString:[user objectForKey:@"cover_url"]]];
            }
            
            NSString* avatar = [[[user objectForKey:@"avatars"]objectForKey:@"small"] objectForKey:@"https"];
            if(![avatar isEqual: [NSNull null]]) {
                [self.avatar setImageWithURL: [NSURL URLWithString:avatar]];
            }
            
            [self.folowers setTitle:
             [NSString stringWithFormat:@"%@ подписчиков", [user objectForKey:@"followers_count"]]
                           forState:UIControlStateNormal];
            
            [self.friends setTitle:[NSString stringWithFormat:@"%@ друзей", [user objectForKey:@"friends_count"]]
                          forState:UIControlStateNormal];
            
            self.isFollow = [[user objectForKey:@"following"] boolValue];
            
            if(self.isFollow) {
                [self.followButton setTitle:@"Отписаться" forState:UIControlStateNormal];
                self.followButton.backgroundColor = [UIColor clearColor];
            } else {
                [self.followButton setTitle:@"Подписаться" forState:UIControlStateNormal];
                self.followButton.backgroundColor = [UIColor colorWithRed:0.7 green:1 blue:0.7 alpha:1];
                [self.followButton setTitleColor:[UIColor darkGrayColor] forState:0];
            }
            
            [self.followButton layoutIfNeeded];
            self.followButton.layer.masksToBounds = YES;
            self.followButton.layer.cornerRadius = self.followButton.frame.size.height / 2;
            
            self.followButton.hidden = NO;

            [self.indicator stopAnimating];
            
//            self.userName.text = user.username;
//            
//            if(![user.firstName isEqual: [NSNull null]]) {
//                self.fullName.text = [NSString stringWithFormat:@"%@", user.firstName];
//                if(![user.lastName isEqual: [NSNull null]]) {
//                    self.fullName.text = [NSString stringWithFormat:@"%@ %@",
//                                          self.fullName.text, user.lastName];
//                }
//            } else if (![user.lastName isEqual: [NSNull null]]) {
//                self.fullName.text = [NSString stringWithFormat:@"%@", user.lastName];
//            }
//            
//            if(![user.cover isEqual: [NSNull null]]) {
//                [self.miniature setImageWithURL:[NSURL URLWithString:user.cover]];
//            }
//            
//            if(![user.avatar isEqual: [NSNull null]]) {
//                [self.avatar setImageWithURL: [NSURL URLWithString:user.avatar]];
//            }
//            [self.folowers setTitle:
//             [NSString stringWithFormat:@"%ld подписчиков", (long)user.followersCount]
//                           forState:UIControlStateNormal];
//            
//            [self.friends setTitle:[NSString stringWithFormat:@"%ld друзей", (long)user.friendsCount]
//                          forState:UIControlStateNormal];
//            
//            //            self.isFollow = [user ]
//            
//            [self.indicator stopAnimating];
        });
        
    } onFailure:^(NSError *erroor, NSInteger errorCode) {
        
    }];
}




#pragma mark - Actions
- (IBAction)followButtonPressed:(id)sender {
    if(self.isFollow) {
        [[ISServerManager sharedManager] deleteFollowOnUser:self.userID onSuccess:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.followButton setTitle:@"Подписаться" forState:UIControlStateNormal];
                self.followButton.backgroundColor = [UIColor colorWithRed:0.7 green:1 blue:0.7 alpha:1];
                [self.followButton setTitleColor:[UIColor darkGrayColor] forState:0];
                self.isFollow = NO;
            });
        } onFailure:^{
            
        }];
        
    } else if(!self.isFollow) {
        [[ISServerManager sharedManager] postFollowOnUser:self.userID onSuccess:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.followButton setTitle:@"Отписаться" forState:UIControlStateNormal];
                self.followButton.backgroundColor = [UIColor clearColor];
                self.isFollow = YES;
            });
        } onFailure:^{
            
        }];
        
    }
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

- (IBAction)galleriesButtonPressed:(id)sender {
    OSGalleriesCVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"galleries"];
    vc.userID = self.userID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)photosButtonPressed:(id)sender {
    
    PhotoCollectionVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"photos"];
    vc.userID = self.userID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)exitButtonPressed:(id)sender {
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ISUserData"
//                                              inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
//    
//    ISUserData * userData = resultArray[0];
//    userData.avatar = nil;
//    userData.cover = nil;
//    userData.firstName = nil;
//    userData.followersCount = 0;
//    userData.friendsCount = 0;
//    userData.lastName = nil;
//    userData.name = nil;
//    userData.oauthToken = nil;
//    userData.oauthTokenSecret = nil;
//    userData.userID = 0;
//    userData.userName = nil;
//    
//    ISTabBarVC* vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ISTabBarVC"];
//    
//    [self presentViewController:vc animated:YES completion: nil];
    
}


@end
