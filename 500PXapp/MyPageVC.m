//
//  MyPageVC.m
//  500PXapp
//
//  Created by user on 20.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "MyPageVC.h"

@interface MyPageVC ()

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIImageView *miniature;
@property (weak, nonatomic) IBOutlet UIView *avatarParentView;
@property (weak, nonatomic) IBOutlet UIView *editProfileView;

@end

@implementation MyPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.miniature.image = [UIImage imageNamed:@"3.jpg"];
    self.avatar.image = [UIImage imageNamed:@"1.jpg"];

    [self.avatarParentView layoutIfNeeded];
    self.avatarParentView.layer.masksToBounds = YES;
    self.avatarParentView.layer.cornerRadius = self.avatarParentView.frame.size.width / 2;
    
    [self.avatar layoutIfNeeded];
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
    
    [self.editProfileView layoutIfNeeded];
    self.editProfileView.layer.masksToBounds = YES;
    self.editProfileView.layer.cornerRadius = 15;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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
