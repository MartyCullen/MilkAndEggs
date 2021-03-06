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
#import "MilkAndEggs.h"




@interface ItemsViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate>
{
	UISearchBar *itemSearchBar;
	UITableView *itemTableView;
    UIToolbar *toolBar;
    ScreenStatus currentStatus;
    
@private
	NSFetchedResultsController *_fetchedResultsController;

}

@property ScreenStatus currentStatus;
@property (nonatomic, retain) UISearchBar *itemSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *itemTableView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (IBAction) backgroundTap: (id) sender;
- (void) editPressed;
- (void) donePressed;
- (void) insertNewObject;
- (NSPredicate *) getListPredicate;
- (void) drawButtons;

@end
