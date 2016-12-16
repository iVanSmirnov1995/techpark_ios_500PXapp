//
//  ISCoreDataViewController.h
//  myDacha
//
//  Created by Smirnov Ivan on 15.07.15.
//  Copyright (c) 2015 Ivan Smirnov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISDataManager.h"

@interface ISCoreDataViewController : UIViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UITableView *tableView;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
