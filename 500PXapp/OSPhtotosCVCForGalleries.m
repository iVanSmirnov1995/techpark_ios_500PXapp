//
//  OSPhtotosCVCForGalleries.m
//  500PXapp
//
//  Created by user on 20.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "OSPhtotosCVCForGalleries.h"
#import "CellPhotos.h"
#import "ISRootPegeVC.h"
#import "ISServerManager.h"

#import "UIImageView+AFNetworking.h"

@interface OSPhtotosCVCForGalleries () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray* photos;
@property (assign, nonatomic) NSInteger photosCount;

@end

@implementation OSPhtotosCVCForGalleries

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
     getPhotosFromGallerie:self.gallerieID
     onUserID:self.userID onPage:self.photos.count/20 + 1
     onSuccess:^(NSArray* photos, NSInteger photosCount) {
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
     
     }
     onError:^(NSError* error, NSInteger statusCode) {
        
     }];

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
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
    
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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

@end
