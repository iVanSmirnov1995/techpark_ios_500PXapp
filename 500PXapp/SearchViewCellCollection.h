//
//  SearchViewCellCollection.h
//  500PXapp
//
//  Created by Максим Стегниенко on 24.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewCellCollection : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIImageView *labelSticker;
@property (strong, nonatomic) IBOutlet UILabel *populatAtThisMoment;

@end
