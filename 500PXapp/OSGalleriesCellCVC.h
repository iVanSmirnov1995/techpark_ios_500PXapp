//
//  OSGalleriesCellCVC.h
//  500PXapp
//
//  Created by user on 19.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSGalleriesCellModel.h"
#import "UIImageView+AFNetworking.h"

@interface OSGalleriesCellCVC : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;

- (void)fillCellWithModel:(OSGalleriesCellModel *)model;

@end
