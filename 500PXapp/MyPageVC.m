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

@interface MyPageVC ()

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIImageView *miniature;
@property (weak, nonatomic) IBOutlet UIView *avatarParentView;
@property (weak, nonatomic) IBOutlet UIView *editProfileView;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *folowers;
@property (weak, nonatomic) IBOutlet UILabel *friends;

@end

@implementation MyPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getUserFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API
-(void) getUserFromServer {
    [[[ISServerManager alloc] init] getUserOnSuccess:^(ISUser *user) {
        
        self.miniature.image = [UIImage imageNamed:user.cover];
        self.avatar.image = [UIImage imageNamed:user.avatar];
        self.fullName.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        self.userName.text = user.username;
        self.folowers.text = [NSString stringWithFormat:@"%@ \n подписчик(ов)", user.followersCount];
        self.friends.text = [NSString stringWithFormat:@"%@ \n друзей", user.friendsCount];
        
        [self.avatarParentView layoutIfNeeded];
        self.avatarParentView.layer.masksToBounds = YES;
        self.avatarParentView.layer.cornerRadius = self.avatarParentView.frame.size.width / 2;
        
        [self.avatar layoutIfNeeded];
        self.avatar.layer.masksToBounds = YES;
        self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
        
        [self.editProfileView layoutIfNeeded];
        self.editProfileView.layer.masksToBounds = YES;
        self.editProfileView.layer.cornerRadius = 15;
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
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
