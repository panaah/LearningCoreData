//
//  ListTableViewController.h
//  LearningCoreData
//
//  Created by Thakur VJ on 05/02/15.
//  Copyright (c) 2015 Thakur VJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ListTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
