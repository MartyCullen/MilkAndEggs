//
//  ListsViewController.h
//  MilkAndEggs
//
//  Created by Mickey Phelps on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditListViewController.h"

@interface ListsViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate, UIActionSheetDelegate>
{
	UISearchBar *listSearchBar;
	UITableView *listTableView;
	UIBarButtonItem *savedButton;
	
@private
	NSFetchedResultsController *_fetchedResultsController;
	
}

@property (nonatomic, retain) IBOutlet UISearchBar *listSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *listTableView;
@property (nonatomic, retain) UIBarButtonItem *savedButton;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (IBAction) backgroundTap: (id) sender;
- (void) toggleEdit;
- (void) insertNewObject;
- (NSPredicate *) getListPredicate;

@end
