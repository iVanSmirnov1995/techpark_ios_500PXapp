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

@interface PhotoCollectionVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation PhotoCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.photos = [NSMutableArray new];

    for (int i = 0; i<100; i++) {
        [self.photos addObject:[UIImage imageNamed: [NSString stringWithFormat:@"%d.jpg",
                                                arc4random() % 5 + 1]]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    CellPhotos *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    PhotosCellModel *item = [[PhotosCellModel alloc] init];
    item.imgPhoto = self.photos[row];
    NSLog(@"----------------------------------%li", (long)row);
    [cell fillCellWithModel: item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

// ----//----
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ISRootPegeVC* vc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"rootPage"];
    [self presentViewController:vc animated:YES completion: nil];
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
