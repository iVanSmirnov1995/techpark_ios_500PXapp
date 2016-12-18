//
//  ISCommentsVC.m
//  500PXapp
//
//  Created by Smirnov Ivan on 18.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ISCommentsVC.h"
#import "ISServerManager.h"
#import "ISCommentsCell.h"
#import "ISComments.h"
#import "ISUser.h"
#import "UIImageView+AFNetworking.h"

@interface ISCommentsVC ()<UITableViewDelegate>

@property(strong,nonatomic)NSMutableArray* commentsArray;
@property(strong,nonatomic)NSMutableArray* userAr;

@end

@implementation ISCommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate=self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
    
    [[ISServerManager sharedManager]getPhotoComentsWithId:self.photoId OnSuccess:^(NSMutableArray *coments) {
        
        self.commentsArray=coments;
        self.userAr=[NSMutableArray array];
        for (ISComments* c in coments) {
            
            [self.userAr addObject:c.user];
        }
        
        
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.commentsArray.count;
}


- (ISCommentsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commecell" forIndexPath:indexPath];
    


    

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ISCommentsCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    ISComments* com=self.commentsArray[indexPath.row];
    ISUser* user=self.userAr[indexPath.row];
    [cell layoutIfNeeded];
    [cell.userAvatar setImageWithURL:[NSURL URLWithString:user.avatar]];
    cell.userAvatar.layer.cornerRadius=CGRectGetWidth(cell.userAvatar.frame)/2.f;
    cell.userAvatar.layer.masksToBounds=YES;
    cell.name.text=[NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
    cell.comment.text=com.body;
    
}


@end
