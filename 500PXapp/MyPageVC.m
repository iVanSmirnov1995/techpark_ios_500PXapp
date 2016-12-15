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

#import "UIImageView+AFNetworking.h"


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
    
    self.fullName.text = @"";
    self.userName.text = @"";
    [self.folowers setTitle:@"" forState:UIControlStateNormal];
    [self.friends setTitle:@"" forState:UIControlStateNormal];
    
    [self getUserFromServer];
}

#pragma mark - API

-(void) getUserFromServer {
    [[ISServerManager sharedManager] getUserOnSuccess:^(ISUser *user) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(![user.cover isEqual:[NSNull null]]) {
                [self.miniature setImageWithURL:[NSURL URLWithString:user.cover]];
            }
            
            if(![user.avatar isEqual:[NSNull null]]) {
                [self.avatar setImageWithURL: [NSURL URLWithString:user.avatar]];
            }
            
            if(![user.firstName isEqual:[NSNull null]]) {
                self.fullName.text = [NSString stringWithFormat:@"%@", user.firstName];
                if(![user.lastName isEqual:[NSNull null]]) {
                    self.fullName.text = [NSString stringWithFormat:@"%@ %@",
                                          self.fullName.text, user.lastName];
                }
            } else if (![user.lastName isEqual:[NSNull null]]) {
                self.fullName.text = [NSString stringWithFormat:@"%@", user.lastName];
            }
            self.userName.text = user.username;
            [self.folowers setTitle:[NSString stringWithFormat:@"%@ подписчиков", user.followersCount]
                           forState:UIControlStateNormal];
            [self.friends setTitle:[NSString stringWithFormat:@"%@ друзей", user.friendsCount]
                          forState:UIControlStateNormal];
            
            [self.avatarParentView layoutIfNeeded];
            self.avatarParentView.layer.masksToBounds = YES;
            self.avatarParentView.layer.cornerRadius = self.avatarParentView.frame.size.width / 2;
            
            [self.avatar layoutIfNeeded];
            self.avatar.layer.masksToBounds = YES;
            self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
            
            [self.editProfileView layoutIfNeeded];
            self.editProfileView.layer.masksToBounds = YES;
            self.editProfileView.layer.cornerRadius = 15;
            [self.view reloadInputViews];
            [self.indicator stopAnimating];

        });
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)folowersButtonPressed:(id)sender {
    OSSubscribersTableVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"usersList"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)friendsButtonPressed:(id)sender {
    OSSubscribersTableVC* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"usersList"];
    [self.navigationController pushViewController:vc animated:YES];
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
