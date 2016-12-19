//
//  ISTableViewInfoAndSareCell.h
//  500PXapp
//
//  Created by Smirnov Ivan on 18.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISHomeVC.h"
#import "ISNewsFeedModel.h"

@interface ISTableViewInfoAndSareCell : UITableViewCell
- (IBAction)infoAction:(UIButton *)sender;
- (IBAction)sareAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *sareButton;
@property(weak,nonatomic)ISHomeVC* homeVC;
@property(strong,nonatomic)ISNewsFeedModel* model;

@end
