//
//  OSInformationCellTVC.h
//  500PXapp
//
//  Created by user on 21.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSInformationCellModel.h"

@interface OSInformationCellTVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *key;
@property (weak, nonatomic) IBOutlet UILabel *value;

-(void) fillCellWithModel: (OSInformationCellModel*) model;

@end
