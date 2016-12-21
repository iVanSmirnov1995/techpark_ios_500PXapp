//
//  OSInformationCellTVC.m
//  500PXapp
//
//  Created by user on 21.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "OSInformationCellTVC.h"
#import "OSInformationCellModel.h"

@implementation OSInformationCellTVC

-(void) fillCellWithModel: (OSInformationCellModel*) model {
    self.key.text = model.key;
    self.value.text = model.value;
}

-(void) prepareForReuse {
    self.key.text = nil;
    self.value.text = nil;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
