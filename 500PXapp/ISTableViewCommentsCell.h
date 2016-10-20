//
//  ISTableViewCommentsCell.h
//  500PXapp
//
//  Created by Smirnov Ivan on 18.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISTableViewCommentsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countComments;
@property (weak, nonatomic) IBOutlet UILabel *lastMessage;

@end
