//
//  OSGalleriesCVC.m
//  500PXapp
//
//  Created by user on 19.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "OSGalleriesCVC.h"
#import "ISRootPegeVC.h"
#import "ISServerManager.h"
#import "OSGalleriesCellModel.h"
#import "OSGalleriesCellCVC.h"
#import "OSPhtotosCVCForGalleries.h"

#import "UIImageView+AFNetworking.h"

@interface OSGalleriesCVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray* galleries;
@property (assign, nonatomic) NSInteger galleriesCount;

@end

@implementation OSGalleriesCVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.galleries = [[NSMutableArray alloc] init];
    
    [self getGalleriesFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - API 

-(void) getGalleriesFromServer {
    [[ISServerManager sharedManager]
     getGalleriesOnUserID:self.userID
     onPage:self.galleries.count/20 + 1
     onSuccess:^(NSArray* galleries, NSInteger galleriesCount) {
         
         [self.galleries addObjectsFromArray:galleries];
         
         if(!self.galleriesCount) {
             self.galleriesCount = galleriesCount;
         }
         
         NSMutableArray* newPath = [NSMutableArray array];
         for (int i = ((int)self.galleries.count - (int)galleries.count); i < self.galleries.count; i++) {
             [newPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.collectionView insertItemsAtIndexPaths:newPath];
             [self.collectionView reloadData];
         });
     } onError:^(NSError* error, NSInteger statusCode) {
     
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
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.galleries.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    OSGalleriesCellCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    
    OSGalleriesCellModel* gallerie = [[OSGalleriesCellModel alloc] init];
    
    NSArray* arr = [self.galleries[row] objectForKey:@"thumbnail_photos"];
    
    gallerie.imageURL = [arr[0] objectForKey:@"image_url"];
    gallerie.name = [self.galleries[row] objectForKey:@"name"];
    
    [cell fillCellWithModel: gallerie];
    
    if(indexPath.row + 1 == self.galleries.count && indexPath.row + 1 < self.galleriesCount) {
        [self getGalleriesFromServer];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    OSPhtotosCVCForGalleries* vc=[[UIStoryboard storyboardWithName:@"MyPageTab" bundle:nil] instantiateViewControllerWithIdentifier:@"photosFromGalleries"];

    vc.userID = self.userID;
    vc.gallerieID = [[self.galleries[indexPath.row] objectForKey:@"id"] integerValue];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
