//
//  ISCoreDataTableViewController.h
//  myDacha
//
//  Created by Smirnov Ivan on 13.07.15.
//  Copyright (c) 2015 Ivan Smirnov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISDataManager.h"

@interface ISCoreDataTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
