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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

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
