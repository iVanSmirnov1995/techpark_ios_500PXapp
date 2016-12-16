//
//  ISCoreDataTabBarVCViewController.h
//  500PXapp
//
//  Created by Smirnov Ivan on 16.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISDataManager.h"

@interface ISCoreDataTabBarVCViewController : UITabBarController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UITableView *tableView;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;


@end
