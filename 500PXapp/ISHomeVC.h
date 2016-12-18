//
//  ISHomeVC.h
//  500PXapp
//
//  Created by Smirnov Ivan on 18.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISUser,ISCoreDataTabBarVCViewController;
@interface ISHomeVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)ISUser* user;
@property(strong,nonatomic)ISCoreDataTabBarVCViewController* tapVC;

-(void)startLoad;

@end
