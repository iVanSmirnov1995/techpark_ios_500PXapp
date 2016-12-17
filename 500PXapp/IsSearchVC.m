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
#import "IsSearchCollectionLayout.h"
#import "ISServerManager.h"
#import "MSPhotos.h"
#import "UIImageView+AFNetworking.h"

@interface IsSearchVC () <UICollectionViewDelegate ,UICollectionViewDataSource> {
    NSMutableArray *arrItems;
    NSMutableArray *arrItems2;
    NSMutableArray *arrItems3;
}

@property (weak,nonatomic)IBOutlet UICollectionView *collection;
@property (strong,nonatomic) NSMutableArray *photos;
@property (strong,nonatomic) NSDictionary *dict;
@property (strong,nonatomic) NSString *str;
@property (strong , nonatomic) UIImage *img;
@property (strong,nonatomic) NSMutableArray *imageArray;
@property (strong,nonatomic) NSMutableArray *imageArray2;
@property (strong,nonatomic) NSMutableArray *imageArray3;
@end

@implementation IsSearchVC

-(UIStatusBarStyle) preferredStatusBarStyle {
    
    return  UIStatusBarStyleLightContent;
}


-(void)tabBegin:(UITapGestureRecognizer*)pan{
    
    [self.searchField resignFirstResponder];
    self.appearConstrain.priority = 900;
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self.view layoutIfNeeded];
        
        
    } completion:nil];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer* pan=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tabBegin:)];
    [self.collection addGestureRecognizer:pan];
    
    
    self.searchField.textAlignment = NSTextAlignmentCenter;
    UIColor *searchColour = [UIColor whiteColor];
    self.searchField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Search 500px"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: searchColour,
                                                 NSFontAttributeName : [UIFont fontWithName:@"PingFang-TC-Light" size:18.0]
                                                 }
     ];
    self.photos = [NSMutableArray array];
    self.dict = [[NSDictionary alloc] init];
    
    
    [self getPopularPhotoFromServer];
    
    
    
    arrItems = [NSMutableArray new];
    arrItems2 = [NSMutableArray new];
    arrItems3 = [NSMutableArray new];
    
    
    ISSearchModel *search = [[ISSearchModel alloc]init];
    
    search.imgProduct =[UIImage imageNamed:@"popularSticker2@2x.png"];
    search.nameProduct = @"Популярное";
    [arrItems addObject:search];
    search = [[ISSearchModel alloc]init];
    
    
    search.imgProduct =[UIImage imageNamed:@"choiceSticker2@2x.png"];
    search.nameProduct = @"Выбор редакции";
    [arrItems2 addObject:search];
    
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Интересное";
    [arrItems2 addObject:search];
    
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Свежее";
    [arrItems2 addObject:search];
    
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Дебют";
    [arrItems2 addObject:search];
    
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Природа";
    [arrItems3 addObject:search];
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Животные";
    [arrItems3 addObject:search];
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Искусство";
    [arrItems3 addObject:search];
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Черно-белые";
    [arrItems3 addObject:search];
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Еда";
    [arrItems3 addObject:search];
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Подводный мир";
    [arrItems3 addObject:search];
    search = [[ISSearchModel alloc]init];
    
    
    
    
    
    IsSearchCollectionLayout *layout = [IsSearchCollectionLayout new];
    layout.cellSize = CGSizeMake(5, 5);
    self.collection.collectionViewLayout = layout;
    
    
}

-(IBAction)cancelButton:(UIButton *)sender {
    
    [self.searchField resignFirstResponder];
    self.appearConstrain.priority = 900;
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self.view layoutIfNeeded];
        
        
    } completion:nil];
}



- (IBAction)actionTextField:(UITextField *)sender {
    
    self.appearConstrain.priority = 750;
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self.view layoutIfNeeded];
        
        
    } completion:nil];
    
    
}


-(void) getPopularPhotoFromServer {
    
    [[ISServerManager alloc] getPopularPhotosOnSuccess:^ (NSArray* photos){
        
        [self.photos addObjectsFromArray:photos];
        
        self.imageArray = [NSMutableArray array];
        self.imageArray2 = [NSMutableArray array];
        self.imageArray3 = [NSMutableArray array];
        
        MSPhotos *ph = [self.photos objectAtIndex:0];
        
        self.imageArray[0] = ph.imageURL;
        
        
        for (int i =1 ;i<5; i++) {
            MSPhotos *ph = [self.photos objectAtIndex:i];
            self.imageArray2[i-1] = ph.imageURL;
        }
        
        
        for (int i =5 ;i<11; i++) {
            MSPhotos *ph = [self.photos objectAtIndex:i];
            self.imageArray3[i-5] = ph.imageURL;
        }
        
        // dispatch_async(dispatch_get_main_queue(), ^{
        [self.collection reloadData];
        // });
        
    }
                                             onFailure:^(NSError *error, NSInteger statusCode) {
                                                 NSLog(@"error = %@, code = %d" ,[error localizedDescription] , statusCode);
                                                 
                                             }];
    
    
}





- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //#warning Incomplete implementation, return the number of sections
    return 3;
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
    
    if (section == 0)
    {
        
        return 1;
    }
    if (section == 1) {
        
        return 4;
    }
    else {
        
        return 6;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    if (indexPath.section ==0)
    {
        ISSearchModel* item=[arrItems objectAtIndex:indexPath.row];
        SearchViewCellCollection* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellItem" forIndexPath:indexPath];
        
        
        
        cell.label.font = [UIFont fontWithName:@"PingFang-TC-Light" size:20];
        cell.populatAtThisMoment.font = [UIFont fontWithName:@"PingFang-TC-Light" size:15];
        cell.populatAtThisMoment.text = @"Популярные на данный момент";
        cell.labelSticker.image = item.imgProduct;
        
        cell.populatAtThisMoment.translatesAutoresizingMaskIntoConstraints = NO;
        cell.label.translatesAutoresizingMaskIntoConstraints = NO;
        cell.labelSticker.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *vertical1 = [NSLayoutConstraint constraintWithItem: cell.populatAtThisMoment
                                                                     attribute: NSLayoutAttributeBottom
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: cell.contentView
                                                                     attribute: NSLayoutAttributeBottom
                                                                    multiplier: 1.0f
                                                                      constant: -10.0f
                                         ];
        
        NSLayoutConstraint *vertical2 = [NSLayoutConstraint constraintWithItem: cell.label
                                                                     attribute: NSLayoutAttributeBottom
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: cell.contentView
                                                                     attribute: NSLayoutAttributeBottom
                                                                    multiplier: 1.0f
                                                                      constant: -35.0f
                                         ];
        
        NSLayoutConstraint *center2 = [NSLayoutConstraint constraintWithItem: cell.label
                                                                   attribute: NSLayoutAttributeCenterX
                                                                   relatedBy: NSLayoutRelationEqual
                                                                      toItem: cell.contentView
                                                                   attribute: NSLayoutAttributeCenterX
                                                                  multiplier: 1.0f
                                                                    constant: 0.0f
                                       ];
        NSLayoutConstraint *center1 = [NSLayoutConstraint constraintWithItem: cell.populatAtThisMoment
                                                                   attribute: NSLayoutAttributeCenterX
                                                                   relatedBy: NSLayoutRelationEqual
                                                                      toItem: cell.contentView
                                                                   attribute: NSLayoutAttributeCenterX
                                                                  multiplier: 1.0f
                                                                    constant: 0.0f
                                       ];
        NSLayoutConstraint *center3 = [NSLayoutConstraint constraintWithItem: cell.labelSticker
                                                                   attribute: NSLayoutAttributeCenterX
                                                                   relatedBy: NSLayoutRelationEqual
                                                                      toItem: cell.contentView
                                                                   attribute: NSLayoutAttributeCenterX
                                                                  multiplier: 1.0f
                                                                    constant: 0.0f
                                       ];
        
        
        NSLayoutConstraint *vertical3 = [NSLayoutConstraint constraintWithItem: cell.labelSticker
                                                                     attribute: NSLayoutAttributeBottom
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: cell.contentView
                                                                     attribute: NSLayoutAttributeBottom
                                                                    multiplier: 1.0f
                                                                      constant: -61.0f
                                         ];
        
        
        [cell.contentView addConstraints:@[vertical1,vertical2,center1,center2,center3,vertical3]];
        
        cell.label.text = item.nameProduct;
        
        
        
        
        
        [cell.img setImageWithURL:self.imageArray[indexPath.row] ];
        
        return cell;
    }
    if (indexPath.section ==1)
    {
        ISSearchModel* item=[arrItems2 objectAtIndex:indexPath.row];
        SearchViewCellCollection* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellItem" forIndexPath:indexPath];
        
        
        cell.label.font = [UIFont fontWithName:@"PingFang-TC-Light" size:14];
        cell.populatAtThisMoment.text = @"";
        cell.labelSticker.image = nil;
        
        cell.label.translatesAutoresizingMaskIntoConstraints = NO;
        cell.labelSticker.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        
        
        NSLayoutConstraint *vertical2 = [NSLayoutConstraint constraintWithItem: cell.label
                                                                     attribute: NSLayoutAttributeBottom
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: cell.contentView
                                                                     attribute: NSLayoutAttributeBottom
                                                                    multiplier: 1.0f
                                                                      constant: -15.0f
                                         ];
        
        NSLayoutConstraint *center2 = [NSLayoutConstraint constraintWithItem: cell.label
                                                                   attribute: NSLayoutAttributeCenterX
                                                                   relatedBy: NSLayoutRelationEqual
                                                                      toItem: cell.contentView
                                                                   attribute: NSLayoutAttributeCenterX
                                                                  multiplier: 1.0f
                                                                    constant: 0.0f
                                       ];
        
        
        
        
        [cell.contentView addConstraints:@[vertical2,center2]];
        
        
        cell.label.text = item.nameProduct;
        [cell.img setImageWithURL:self.imageArray2[indexPath.row] ];
        
        
        return cell;
    }
    if (indexPath.section ==2)
    {
        ISSearchModel* item=[arrItems3 objectAtIndex:indexPath.row];
        SearchViewCellCollection* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellItem" forIndexPath:indexPath];
        
        
        cell.label.font = [UIFont fontWithName:@"PingFang-TC-Light" size:14];
        cell.populatAtThisMoment.text = @"";
        cell.labelSticker.image = nil;
        
        cell.label.translatesAutoresizingMaskIntoConstraints = NO;
        cell.labelSticker.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        NSLayoutConstraint *vertical2 = [NSLayoutConstraint constraintWithItem: cell.label
                                                                     attribute: NSLayoutAttributeBottom
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: cell.contentView
                                                                     attribute: NSLayoutAttributeBottom
                                                                    multiplier: 1.0f
                                                                      constant: -15.0f
                                         ];
        
        NSLayoutConstraint *center2 = [NSLayoutConstraint constraintWithItem: cell.label
                                                                   attribute: NSLayoutAttributeCenterX
                                                                   relatedBy: NSLayoutRelationEqual
                                                                      toItem: cell.contentView
                                                                   attribute: NSLayoutAttributeCenterX
                                                                  multiplier: 1.0f
                                                                    constant: 0.0f
                                       ];
        
        
        
        
        [cell.contentView addConstraints:@[vertical2,center2]];
        
        
        cell.label.text = item.nameProduct;
        
        [cell.img setImageWithURL:self.imageArray3[indexPath.row] ];
        
        
        return cell;
        
    }
    
    
    return nil;
}


@end
