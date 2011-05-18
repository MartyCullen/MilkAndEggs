//
//  ActiveListViewController.h
//  MilkAndEggs
//
//  Created by Mickey Phelps on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditSelectionViewController.h"
#import "Selection.h"
#import "Item.h"


@interface ActiveListViewController  : UIViewController 
<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate>
{
	UISearchBar *selectionSearchBar;
	UITableView *selectionTableView;
	UIBarButtonItem *savedButton;
	
@private
	NSFetchedResultsController *_fetchedResultsController;
   
}

@property (nonatomic, retain) IBOutlet UISearchBar *selectionSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *selectionTableView;
@property (nonatomic, retain) UIBarButtonItem *savedButton;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (IBAction) backgroundTap: (id) sender;
- (void) toggleEdit;
- (void) insertNewObject;
- (NSPredicate *) getListPredicate;
@end