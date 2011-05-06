//
//  ItemsViewController.h
//  MilkAndEggs
//
//  Created by Mickey Phelps on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditItemViewController.h"
#import "Item.h"

@interface ItemsViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate>
{
	UISearchBar *itemSearchBar;
	UITableView *itemTableView;
	UIBarButtonItem *savedButton;
	
@private
	NSFetchedResultsController *_fetchedResultsController;

}

@property (nonatomic, retain) IBOutlet UISearchBar *itemSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *itemTableView;
@property (nonatomic, retain) UIBarButtonItem *savedButton;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (IBAction) backgroundTap: (id) sender;
- (void) toggleEdit;
- (void) insertNewObject;
- (NSPredicate *) getListPredicate;

@end
