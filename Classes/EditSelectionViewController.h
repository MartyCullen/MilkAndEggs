//
//  EditSelectionViewController.h
//  MilkAndEggs
//
//  Created by John Goode on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MilkAndEggsAppDelegate.h"
#import "Selection.h"
#import "Item.h"
#import "List.h"

@interface EditSelectionViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate>
{
      UISearchBar *itemSearchBar;
      UITableView *itemTableView;
      Selection *selection;
      
   @private
      NSFetchedResultsController *_fetchedResultsController;
      
}

@property (nonatomic, retain) IBOutlet UISearchBar *itemSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *itemTableView;
@property (nonatomic, retain) Selection *selection;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;


- (NSPredicate *) getListPredicate;


@end
