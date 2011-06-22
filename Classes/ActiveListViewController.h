//
//  ActiveListViewController.h
//  MilkAndEggs
//
//  Created by Mickey Phelps on 3/9/11.
//  Copyright 2011 Milk and Eggs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditSelectionViewController.h"
#import "Selection.h"
#import "Item.h"
#import "List.h"
#import "MilkAndEggs.h"

@interface ActiveListViewController  : UIViewController 
<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate>
{
	UIToolbar *toolBar;
    UISearchBar *selectionSearchBar;
	UITableView *selectionTableView;
    List *activeList;
    ScreenStatus currentStatus;
	
@private
	NSFetchedResultsController *_fetchedResultsController;
    
}

@property (nonatomic, retain) IBOutlet UISearchBar *selectionSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *selectionTableView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) List *activeList;
@property ScreenStatus currentStatus;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (IBAction) backgroundTap: (id) sender;
//- (void) toggleEdit;
- (void) insertNewObject;
- (NSPredicate *) getListPredicate;
- (void) editPressed;
- (void) donePressed;
- (void) drawButtons;
@end
