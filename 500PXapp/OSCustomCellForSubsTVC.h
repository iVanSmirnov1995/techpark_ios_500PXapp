//
//  OSCustomCellForSubsTVC.h
//  500PXapp
//
//  Created by user on 21.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSCustomCellForSubTVC.h"
#import "UIImageView+AFNetworking.h"

@interface OSCustomCellForSubsTVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

- (void)fillCellWithModel:(OSCustomCellForSubTVC *)model;

@end
