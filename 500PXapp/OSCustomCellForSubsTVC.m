//
//  OSCustomCellForSubsTVC.m
//  500PXapp
//
//  Created by user on 21.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "OSCustomCellForSubsTVC.h"

@implementation OSCustomCellForSubsTVC

- (void)fillCellWithModel:(OSCustomCellForSubTVC *)model {
    [self.avatar setImageWithURL: [NSURL URLWithString:model.avatarURL]];
    [self.avatar layoutIfNeeded];
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
    
    self.userName.text = model.name;
}

-(void) prepareForReuse {
    self.avatar.image = nil;
    self.userName.text =nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
