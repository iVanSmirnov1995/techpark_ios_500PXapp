//
//  OSGalleriesCellCVC.m
//  500PXapp
//
//  Created by user on 19.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "OSGalleriesCellCVC.h"


@implementation OSGalleriesCellCVC

- (void)fillCellWithModel:(OSGalleriesCellModel *)model {
    self.name.text = model.name;
    [self.image setImageWithURL:[NSURL URLWithString:model.imageURL]];
}

-(void) prepareForReuse {
    self.name.text = nil;
    self.image.image = nil;
}

@end
