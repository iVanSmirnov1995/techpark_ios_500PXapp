//
//  CellPhotos.h
//  500PXapp
//
//  Created by user on 24.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosCellModel.h"
#import "UIImageView+AFNetworking.h"

@interface CellPhotos : UICollectionViewCell {
    
}

@property (nonatomic, strong) IBOutlet UIImageView *img;

- (void)fillCellWithModel:(PhotosCellModel *)model;

@end
