//
//  MSPhotoSearchVC.m
//  500PXapp
//
//  Created by Максим Стегниенко on 18.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "MSPhotoSearchVC.h"
#import "IsSearchVC.h"
#import "UIImageView+AFNetworking.h"
#import "MSPhotoCellCollection.h"
#import "GreedoCollectionViewLayout.h"

@import Photos;

@interface MSPhotoSearchVC () <GreedoCollectionViewLayoutDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) GreedoCollectionViewLayout *collectionViewSizeCalculator;
@property (strong, nonatomic) PHFetchResult *assetFetchResults;

@end

@implementation MSPhotoSearchVC


-(UIStatusBarStyle) preferredStatusBarStyle {
    
    return  UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
  //  [self.navigationBar setTintColor:[UIColor redColor]];
    //self.navigationItem.titleView = nil ;
    
  //  MSPhotoSearchVC *vc = [[MSPhotoSearchVC alloc] init];
    
    self.label.text = self.str;
    [self.imagePhoto setImageWithURL:self.url];
 //   NSLog(@"%@",self.str);
    [ self.navigationBar setBackgroundImage:[UIImage imageNamed:@"Rectangle48@2x.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    self.collectionViewSizeCalculator.rowMaximumHeight = CGRectGetHeight(self.collectionView.bounds) / 3;
    self.collectionViewSizeCalculator.fixedHeight = self.hasFixedHeight;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Configure spacing between cells
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5.0f;
    layout.minimumLineSpacing = 5.0f;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 5.0f, 5.0f, 5.0f);
    
    self.collectionView.collectionViewLayout = layout;
    
    [self retrieveImagesFromDevice];
    
    
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

- (IBAction)backbutton:(id)sender {
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)retrieveImagesFromDevice
{
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.assetFetchResults = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = self.assetFetchResults[indexPath.item];
    
    MSPhotoCellCollection *cell = (MSPhotoCellCollection *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MSPhotoCellCollection class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    options.version = PHImageRequestOptionsVersionCurrent;
    options.synchronous = NO;
    
    CGFloat scale = MIN(2.0, [[UIScreen mainScreen] scale]);
    CGSize requestImageSize = CGSizeMake(CGRectGetWidth(cell.bounds) * scale, CGRectGetHeight(cell.bounds) * scale);
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset
                                                      targetSize:requestImageSize
                                                     contentMode:PHImageContentModeAspectFit
                                                         options:options
                                                   resultHandler:^(UIImage *result, NSDictionary *info) {
                                                       cell.imageView.image = result;
                                                   }];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetFetchResults.count;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.collectionViewSizeCalculator sizeForPhotoAtIndexPath:indexPath];
}

#pragma mark - <GreedoCollectionViewLayoutDataSource>

- (CGSize)greedoCollectionViewLayout:(GreedoCollectionViewLayout *)layout originalImageSizeAtIndexPath:(NSIndexPath *)indexPath
{
    // Return the image size to GreedoCollectionViewLayout
    if (indexPath.item < self.assetFetchResults.count) {
        PHAsset *asset = self.assetFetchResults[indexPath.item];
        return CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    }
    
    return CGSizeMake(0.1, 0.1);
}

#pragma mark - Lazy Loading

- (GreedoCollectionViewLayout *)collectionViewSizeCalculator
{
    if (!_collectionViewSizeCalculator) {
        _collectionViewSizeCalculator = [[GreedoCollectionViewLayout alloc] initWithCollectionView:self.collectionView];
        _collectionViewSizeCalculator.dataSource = self;
    }
    
    return _collectionViewSizeCalculator;
}


@end
