//
//  ISHomeVC.m
//  500PXapp
//
//  Created by Smirnov Ivan on 18.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//


#import "ISHomeVC.h"
#import "ISNewsFeedModel.h"

#import "ISTableViewImageCell.h"
#import "ISTableViewUserInfoCell.h"
#import "ISTableViewLikeCell.h"
#import "ISTableViewCommentsCell.h"
#import "ISTableViewInfoAndSareCell.h"

#import "ISRootPegeVC.h"

#import "ISServerManager.h"
#import "ISUser.h"
#import "UIImageView+AFNetworking.h"

@interface ISHomeVC ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSMutableArray* newsFeedArray;

@end

@implementation ISHomeVC


typedef enum {
    
    ISImageTupe=0,
    ISInfoUserTupe=1,
    ISLikeTupe=2,
    ISCommentsTupe=3,
    ISInfoAndSareTupe=4,
    
} ISTupeCell;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)startLoad{
    
    
    self.tableView.delegate=self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    [[ISServerManager sharedManager]getUserFriendsPhotoNewsOnSuccess:^(NSMutableArray *news) {
        
        
        self.newsFeedArray=news;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
        
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITableViewDelegate

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==ISImageTupe){
        
        ISRootPegeVC* vc=[self.storyboard instantiateViewControllerWithIdentifier:@"rootPage"];
        [self presentViewController:vc animated:YES completion: nil];
        
        
        
        
    }
    
    return YES;
}

#pragma mark-UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    
    
    return self.newsFeedArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString* identifier=@"";
    ISNewsFeedModel* newsModel = self.newsFeedArray[indexPath.section];
    
    if (indexPath.row==ISImageTupe) {
        identifier=@"image";
       ISTableViewImageCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell.myImageView setImageWithURL:[NSURL URLWithString:newsModel.imageName] placeholderImage:[UIImage imageNamed:@"loading.png"]];
        
        
//
        
        return cell;
    }
    
    if (indexPath.row==ISInfoUserTupe) {
        identifier=@"infoUser";
        ISTableViewUserInfoCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        [cell layoutIfNeeded];
        
        [cell.userImage setImageWithURL:[NSURL URLWithString:newsModel.userImageName] placeholderImage:[UIImage imageNamed:@"loading.png"]];
        cell.userImage.layer.cornerRadius=CGRectGetWidth(cell.userImage.frame)/2.f;
        cell.userImage.layer.masksToBounds=YES;
        cell.userName.text=newsModel.userName;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM d, yyyy HH:mm"];
        NSString *stringDate = [dateFormatter stringFromDate:newsModel.data];
        cell.data.text=stringDate;
        return cell;
    }
    
    if (indexPath.row==ISLikeTupe) {
        identifier=@"like";
        ISTableViewLikeCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.countLike.text=[NSString stringWithFormat:@"%d",newsModel.countLike];
        return cell;

    }
    
    if (indexPath.row==ISCommentsTupe) {
        identifier=@"comments";
        ISTableViewCommentsCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.lastMessage.text=newsModel.lastComent;
        return cell;
    }
    
    if (indexPath.row==ISInfoAndSareTupe) {
        identifier=@"infoAndSare";
        ISTableViewInfoAndSareCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        return cell;
    }
    
    
    
    return nil;
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
