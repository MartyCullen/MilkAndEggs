//
//  ListsViewController.h
//  MilkAndEggs
//
//  Created by Mickey Phelps on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditListViewController.h"

typedef enum ScreenStatuses {
    kScreenListEdit,
    kScreenListDisplay,
    kScreenListSearch,
    kScreenEditSearch
} ScreenStatus;


@interface ListsViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate, UIActionSheetDelegate>
{
	UISearchBar *listSearchBar;
	UITableView *listTableView;
	UIBarButtonItem *savedButton;
    UIToolbar *toolBar;
	
@private
	NSFetchedResultsController *_fetchedResultsController;
	
}

@property ScreenStatus currentStatus;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) IBOutlet UISearchBar *listSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *listTableView;
@property (nonatomic, retain) UIBarButtonItem *savedButton;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (IBAction) backgroundTap: (id) sender;
- (void) toggleEdit;
- (void) insertNewObject;
- (NSPredicate *) getListPredicate;
- (void) editPressed;
- (void) donePressed;
- (void) drawButtons;

@end
