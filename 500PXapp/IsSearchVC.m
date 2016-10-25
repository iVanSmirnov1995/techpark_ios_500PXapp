//
//  IsSearchVC.m
//  500PXapp
//
//  Created by Максим Стегниенко on 20.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "IsSearchVC.h"
#import "ISSearchModel.h"
#import "SearchViewCellCollection.h"

@interface IsSearchVC () <UICollectionViewDelegate ,UICollectionViewDataSource> {
    NSMutableArray *arrItems;
}



@end

@implementation IsSearchVC

-(UIStatusBarStyle) preferredStatusBarStyle {
    
    return  UIStatusBarStyleLightContent;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.searchField.textAlignment = NSTextAlignmentCenter;
    UIColor *searchColour = [UIColor whiteColor];
    self.searchField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Search 500px"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: searchColour,
                                                 NSFontAttributeName : [UIFont fontWithName:@"PingFang-TC-Light" size:18.0]
                                                 }
     ];
    
    
    [self.photoSegmentedControl setFrame:CGRectMake(7, 70, 352, 29)];
    
    arrItems = [NSMutableArray arrayWithCapacity:3];
    
    
    ISSearchModel *search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Популярное";
    search.imgProduct = [UIImage imageNamed:@"popular.jpq"];
    [arrItems addObject:search];
    NSLog(@"%@",search.imgProduct);
    
    // NSLog(@"%d",arrItems.count);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark-UICollectionViewDataSource



- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    
    return arrItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchViewCellCollection* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellItem" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    ISSearchModel* item = arrItems[row];
    cell.label.text = item.nameProduct;
    
    
    cell.img.image = item.imgProduct;
    NSLog(@"%@",item.imgProduct);
    return cell;
}



- (IBAction)actionSegmentedControl:(id)sender {
}
@end
