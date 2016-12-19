//
//  CellPhotos.m
//  500PXapp
//
//  Created by user on 24.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "CellPhotos.h"

@implementation CellPhotos

- (void)fillCellWithModel:(PhotosCellModel *)model {
    [self.img setImageWithURL:[NSURL URLWithString: model.photoURL]];
}

- (void)prepareForReuse {
    self.img.image = nil;
}

@end
