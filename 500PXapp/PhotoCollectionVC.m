//
//  PhotoCollectionVC.m
//  500PXapp
//
//  Created by user on 24.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "PhotoCollectionVC.h"
#import "CellPhotos.h"
#import "ISRootPegeVC.h"
#import "ISServerManager.h"

#import "UIImageView+AFNetworking.h"

@interface PhotoCollectionVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray* photos;
@property (assign, nonatomic) NSInteger photosCount;

@end

@implementation PhotoCollectionVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.photos = [[NSMutableArray alloc] init];

    [self getPhotosFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - API

-(void) getPhotosFromServer {
    [[ISServerManager sharedManager]
     getPhotosOnUserID:self.userID
     withPage:self.photos.count/20 + 1
     onSuccess:^(NSArray *photos, NSInteger photosCount) {
         [self.photos addObjectsFromArray: photos];
         
         if(!self.photosCount){
             self.photosCount = photosCount;
         }
         
         NSMutableArray* newPath = [NSMutableArray array];
         for (int i = ((int)self.photos.count - (int)photos.count); i < self.photos.count; i++) {
             [newPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.collectionView insertItemsAtIndexPaths:newPath];
             [self.collectionView reloadData];
         });
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CellPhotos *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    PhotosCellModel *photo = [[PhotosCellModel alloc] init];
    
    photo.photoURL = [self.photos[row] objectForKey:@"image_url"];
    NSLog(@"%ld", (long)row);
    [cell fillCellWithModel: photo];
    
    if(row + 1 == self.photos.count && row + 1 < self.photosCount) {
        
        [self getPhotosFromServer];
    }
    
    return cell;
    
//    OSCustomCellForSubsTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    
//    NSInteger row = indexPath.row;
//    OSCustomCellForSubTVC *follower = [[OSCustomCellForSubTVC alloc] init];
//    follower.avatarURL = [[[self.followers[row]
//                            objectForKey: @"avatars"]
//                           objectForKey:@"small"]
//                          objectForKey:@"https"];
//    follower.name = [self.followers[row] objectForKey:@"fullname"];
//    
//    [cell fillCellWithModel: follower];
//    
//    if(indexPath.row == self.followers.count) {
//        [self getFollowersFromServer];
//    }
//    
//    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    ISRootPegeVC* vc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"rootPage"];
//    [self presentViewController:vc animated:YES completion: nil];
    
    ISRootPegeVC* vc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"rootPage"];
    NSMutableArray* imagesURLs=[NSMutableArray array];
    for (NSDictionary* photo in self.photos) {
        NSArray* imageSize = [photo objectForKey:@"images"];
        [imagesURLs addObject:[imageSize[1] objectForKey:@"url"]];
    }
    vc.imageURLArray = imagesURLs;
    vc.startPage = indexPath.row;
    
    [self.navigationController pushViewController:vc animated:YES];
}

// Uncomment this method to specify if the specified item should be highlighted during tracking
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    ISRootPegeVC* vc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"rootPage"];
//    [self presentViewController:vc animated:YES completion: nil];
//    
//	return YES;
//}



/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
