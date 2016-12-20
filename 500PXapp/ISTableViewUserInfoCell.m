//
//  ISTableViewUserInfoCell.m
//  500PXapp
//
//  Created by Smirnov Ivan on 18.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ISTableViewUserInfoCell.h"
#import "ISServerManager.h"

@implementation ISTableViewUserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addLike:(UIButton *)sender {
    
    sender.enabled=NO;
    if (!self.like) {
        
    [sender setImage:[UIImage imageNamed:@"like3"] forState:UIControlStateNormal];
    [[ISServerManager sharedManager]POSTLike:YES PhotoWithId:sender.tag OnSuccess:^(NSMutableArray *coments) {
        
        [self.delegate likeDidSet:self];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];}
          else
    {
    [sender setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [[ISServerManager sharedManager]DELETELike:YES PhotoWithId:sender.tag OnSuccess:^(NSMutableArray *coments) {
        
         [self.delegate likeDidSet:self];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        
    }];
    
    }
    
}
@end
