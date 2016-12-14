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
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        
        [self getPopularPhotoFromServer];
    });
    
    
    arrItems = [NSMutableArray new];
    arrItems2 = [NSMutableArray new];
    arrItems3 = [NSMutableArray new];
    
    
    ISSearchModel *search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Популярное";
    [arrItems addObject:search];
    

    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Выбор редакции";
    search.imgProduct = [UIImage imageNamed:@"choice.jpg"];
    [arrItems2 addObject:search];
   
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Интересное";
    search.imgProduct = [UIImage imageNamed:@"interesting.jpg"];
    [arrItems2 addObject:search];
    
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Свежее";
    search.imgProduct = [UIImage imageNamed:@"new.jpg"];
    [arrItems2 addObject:search];
    
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Дебют";
    search.imgProduct = [UIImage imageNamed:@"present.jpg"];
    [arrItems2 addObject:search];
    
    
    
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Природа";
    search.imgProduct = [UIImage imageNamed:@"nature.jpg"];
    [arrItems3 addObject:search];
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Животные";
    search.imgProduct = [UIImage imageNamed:@"animals.jpg"];
    [arrItems3 addObject:search];
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Искусство";
    search.imgProduct = [UIImage imageNamed:@"art.jpg"];
    [arrItems3 addObject:search];
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Черно-белые";
    search.imgProduct = [UIImage imageNamed:@"blackWhite.jpg"];
    [arrItems3 addObject:search];
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Еда";
    search.imgProduct = [UIImage imageNamed:@"food.jpg"];
    [arrItems3 addObject:search];
    search = [[ISSearchModel alloc]init];
    search.nameProduct = @"Подводный мир";
    search.imgProduct = [UIImage imageNamed:@"sea.jpg"];
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
       /*
        for (int i =6 ;i<12; i++) {
            MSPhotos *ph = [self.photos objectAtIndex:i];
            self.imageArray3[i-6] = ph.imageURL;
        }
        */
        
        
        ph = [self.photos objectAtIndex:5];
        self.imageArray3[0] = ph.imageURL;
        ph = [self.photos objectAtIndex:6];
        self.imageArray3[1] = ph.imageURL;
        ph = [self.photos objectAtIndex:7];
        self.imageArray3[2] = ph.imageURL;
        ph = [self.photos objectAtIndex:8];
        self.imageArray3[3] = ph.imageURL;
        ph = [self.photos objectAtIndex:9];
        self.imageArray3[4] = ph.imageURL;
        ph = [self.photos objectAtIndex:10];
        self.imageArray3[5] = ph.imageURL;
        /*
         ph = [self.photos objectAtIndex:1];
        self.imageArray2[0] = ph.imageURL;
        ph = [self.photos objectAtIndex:2];
        self.imageArray2[1] = ph.imageURL;
       ph = [self.photos objectAtIndex:3];
        self.imageArray2[2] = ph.imageURL;
        ph = [self.photos objectAtIndex:4];
        self.imageArray2[3] = ph.imageURL;
       ph = [self.photos objectAtIndex:5];
        self.imageArray2[4] = ph.imageURL;

        */
        [self.collection reloadData];
        
        
    }
                                             onFailure:^(NSError *error, NSInteger statusCode) {
                                                 NSLog(@"error = %@, code = %d" ,[error localizedDescription] , statusCode);
                                                 
                                             }];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        cell.label.text = item.nameProduct;
       // MSPhotos *ph = [self.photos objectAtIndex:0];
        
        [cell.img setImageWithURL:self.imageArray[indexPath.row] ];
        
        return cell;
    }
    if (indexPath.section ==1)
    {
         ISSearchModel* item=[arrItems2 objectAtIndex:indexPath.row];
        SearchViewCellCollection* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellItem" forIndexPath:indexPath];
        cell.label.text = item.nameProduct;
        [cell.img setImageWithURL:self.imageArray2[indexPath.row] ];
        
    
        return cell;
    }
    if (indexPath.section ==2)
    { ISSearchModel* item=[arrItems3 objectAtIndex:indexPath.row];
        SearchViewCellCollection* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellItem" forIndexPath:indexPath];
        cell.label.text = item.nameProduct;
         [cell.img setImageWithURL:self.imageArray3[indexPath.row] ];
        
      
        return cell;
    }
    
    
    return nil;
}


@end
