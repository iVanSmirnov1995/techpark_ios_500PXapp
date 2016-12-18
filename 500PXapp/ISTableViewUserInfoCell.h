//
//  ISTableViewUserInfoCell.h
//  500PXapp
//
//  Created by Smirnov Ivan on 18.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ISTableViewUserInfoCellDelegate;


@interface ISTableViewUserInfoCell : UITableViewCell

@property (weak, nonatomic) id <ISTableViewUserInfoCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *data;
- (IBAction)addLike:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@protocol ISTableViewUserInfoCellDelegate

@required


- (void) likeDidSet:(ISTableViewUserInfoCell*) cell;


@end

