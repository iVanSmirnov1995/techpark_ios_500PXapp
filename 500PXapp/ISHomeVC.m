//
//  ISHomeVC.m
//  500PXapp
//
//  Created by Smirnov Ivan on 18.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//


#import "ISHomeVC.h"
#import "ISNewsFeedModel.h"
#import "UIViewController+Charleene.h"
#import "ISTableViewImageCell.h"
#import "ISTableViewUserInfoCell.h"
#import "ISTableViewLikeCell.h"
#import "ISTableViewCommentsCell.h"
#import "ISTableViewInfoAndSareCell.h"
#import "ISRootPegeVC.h"
#import "ISServerManager.h"
#import "ISUser.h"
#import "UIImageView+AFNetworking.h"
#import "ISComments.h"
#import "ISCommentsVC.h"
#import "ISCommentsCell.h"
#import "MyPageVC.h"
#import "ISTabBarVC.h"

@interface ISHomeVC ()<UITableViewDataSource,UITableViewDelegate,ISTableViewUserInfoCellDelegate>

@property(strong,nonatomic)NSMutableArray* newsFeedArray;
@property(strong,nonatomic)UIRefreshControl* refreshControl;

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
    self.tableView.separatorColor=[UIColor whiteColor];
}

-(void)startLoad{
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
//    self.tableView.refreshControl=self.refreshControl;
    self.tableView.delegate=self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.separatorColor=[UIColor grayColor];
    
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
        NSMutableArray* imArr=[NSMutableArray array];
        for (ISNewsFeedModel* news in self.newsFeedArray) {
            
            [imArr addObject:news.imageName];
        }
        vc.imageURLArray=imArr;
        vc.startPage=indexPath.section;
        
        [self presentViewController:vc animated:YES completion: nil];
        
    }
    
    if(indexPath.row==ISCommentsTupe){
        
        
            
        ISCommentsVC* vc=[self.storyboard instantiateViewControllerWithIdentifier:@"comments"];
        ISNewsFeedModel* news=_newsFeedArray[indexPath.section];
        vc.photoId=news.photoID;
        [self presentCharleeneModally:vc transitionMode:KSModalTransitionModeFromBottom];
        
    }
    
    if(indexPath.row==ISInfoUserTupe){
        
        UIStoryboard* st=[UIStoryboard storyboardWithName:@"MyPageTab"
                                                   bundle:[NSBundle mainBundle]];
        MyPageVC* vc = [st instantiateViewControllerWithIdentifier:@"myPage"];
        ISNewsFeedModel* news=_newsFeedArray[indexPath.section];
        vc.userID = news.userID;

        [self.navigationController pushViewController:vc animated:YES];
        
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
        
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
        
        return cell;
    }
    
    if (indexPath.row==ISInfoUserTupe) {
        identifier=@"infoUser";
        ISTableViewUserInfoCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell layoutIfNeeded];
        
        [cell.userImage setImageWithURL:[NSURL URLWithString:newsModel.userImageName] placeholderImage:[UIImage imageNamed:@"loading.png"]];
        cell.userImage.layer.cornerRadius=CGRectGetWidth(cell.userImage.frame)/2.f;
        cell.userImage.layer.masksToBounds=YES;
        cell.userName.text=newsModel.userName;
        cell.data.text=newsModel.data;
        cell.likeButton.tag=newsModel.photoID;
        cell.like=newsModel.liked;
        cell.likeButton.enabled=YES;
        
        if (newsModel.liked) {
        [cell.likeButton setImage:[UIImage imageNamed:@"like3"] forState:UIControlStateNormal];
        }else {
            
        [cell.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
            
        }
        cell.delegate=self;
        
        
        return cell;
    }
    
    if (indexPath.row==ISLikeTupe) {
        identifier=@"like";
        ISTableViewLikeCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.countLike.text=[NSString stringWithFormat:@"%ld",(long)newsModel.countLike];
        return cell;

    }
    
    if (indexPath.row==ISCommentsTupe) {
        identifier=@"comments";
        ISTableViewCommentsCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (newsModel.countComent==0) {
            cell.countComments.text=
            [NSString stringWithFormat:@"Коментариев пока нет"];
        }else
        
        cell.countComments.text=
        [NSString stringWithFormat:@"%ld коментарий(я)",(long)newsModel.countComent];
        
        return cell;
    }
    
    if (indexPath.row==ISInfoAndSareTupe) {
        identifier=@"infoAndSare";
        ISTableViewInfoAndSareCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sareButton.tag=newsModel.photoID;
        cell.infoButton.tag=newsModel.photoID;
        cell.homeVC=self;
        cell.model=newsModel;
        
        return cell;
    }
    
    
    
    return nil;
}

#pragma mark-ISTableViewUserInfoCellDelegate

- (void) likeDidSet:(ISTableViewUserInfoCell*) cell{
  
    [self startLoad];
    
}


-(void)refreshData
{
    //Put your logic here
    
    
    //reload table & remove refreshing image

    [self startLoad];
    [self.refreshControl endRefreshing];
}


@end
