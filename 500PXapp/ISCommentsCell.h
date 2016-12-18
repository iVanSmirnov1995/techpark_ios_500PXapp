//
//  ISCommentsCell.h
//  500PXapp
//
//  Created by Smirnov Ivan on 18.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISCommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *comment;


@end
