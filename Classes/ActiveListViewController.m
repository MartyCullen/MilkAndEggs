//
//  ItemsViewController.m
//  MilkAndEggs
//
//  Created by Mickey Phelps on 3/9/11.
//  Copyright 2011 Milk And Eggs, Incf. All rights reserved.
//

#import "ActiveListViewController.h"


@implementation ActiveListViewController

@synthesize selectionSearchBar;
@synthesize selectionTableView;
@synthesize toolBar;
@synthesize activeList;
@synthesize currentStatus;

@synthesize fetchedResultsController=_fetchedResultsController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.currentStatus = kScreenListDisplay;
    [self drawButtons];
	NSError *error = nil;
	_fetchedResultsController = nil;
	if (![[self fetchedResultsController] performFetch: &error]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Error Loading Data",
                                                                                   @"Error Loading Data")
                                                        message: [NSString stringWithFormat: NSLocalizedString(@"Error was: %@.  Quitting.",
                                                                                                               @"Error was: %@.  Quitting."),
                                                                  [error localizedDescription],
                                                                  [error localizedDescription]]
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
	
}


- (void) viewWillAppear:(BOOL)animated
{
	
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	MilkAndEggsAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
	
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"List" 
                                              inManagedObjectContext: managedObjectContext];
    
    [fetchRequest setEntity: entity];
    
    NSPredicate *setPred = [NSPredicate predicateWithFormat: @"listActive == TRUE"];
    
	//NSPredicate *setPred = [self getListPredicate];
	
	[fetchRequest setPredicate:setPred];	
    
	// Edit the sort key as appropriate.
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"selectionSequence" 
    //                                                               ascending: YES 
    //                                                                selector: @selector(compare:)];
	
    //NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: sortDescriptor, nil];
    
    //[fetchRequest setSortDescriptors: sortDescriptors];
    NSError *error = nil;
    
    NSArray *listObjects = [managedObjectContext executeFetchRequest:fetchRequest
                                                               error:&error];
    
    [fetchRequest release];
    
    if (![listObjects count]) {
        NSLog(@"No active list");
        self.navigationItem.title =@"No Active List";
    } else {
        self.activeList = [listObjects objectAtIndex:0];
        self.navigationItem.title = self.activeList.listName;
    }
    
    self.fetchedResultsController.delegate = self;
	
	
	if (![self.fetchedResultsController performFetch: &error]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Error Loading Data",
                                                                                   @"Error Loading Data")
                                                        message: [NSString stringWithFormat: NSLocalizedString(@"Error was: %@.  Quitting.",
                                                                                                               @"Error was: %@.  Quitting."),
                                                                  [error localizedDescription],
                                                                  [error localizedDescription]]
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
	
}	

- (void) viewDidAppear: (BOOL) animated
{
	[super viewDidAppear: animated];

	[self.selectionTableView reloadData];
}


- (void) viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear: animated];
	
	self.fetchedResultsController.delegate = nil;
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void) backgroundTap:(id)sender
{
	[self.selectionSearchBar resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.selectionTableView = nil;
	self.selectionSearchBar = nil;
	self.toolBar = nil;
	_fetchedResultsController = nil;
	
}


- (void)dealloc {
    [super dealloc];
	
	[self.selectionTableView release];
	[self.selectionSearchBar release];
	[self.toolBar release];
	[_fetchedResultsController release];
}

#pragma mark -
#pragma mark Add a new object

- (void)insertNewObject 
{
	//[self toggleEdit];
	
	// Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    Selection *newManagedObject = [NSEntityDescription 
                                   insertNewObjectForEntityForName: [entity name] 
                                   inManagedObjectContext: context];
    
	// If appropriate, configure the new managed object.
	
//    [self.activeList addListContainsSelectionObject:newManagedObject];
    
	
	EditSelectionViewController *editSelectionView = [[EditSelectionViewController alloc] initWithNibName: @"EditSelectionViewController"
                                                                                                   bundle: nil];
	
	editSelectionView.title = @"New Item Selection";
    editSelectionView.selection = newManagedObject;
    editSelectionView.activeList = activeList;
	//editSelectionView.item = newManagedObject;
	[self.navigationController pushViewController: editSelectionView animated: YES];

    // Save the context.

//	NSError *error = nil;
//    if (![context save: &error]) {
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
    
    
	[editSelectionView release];
	
}


#pragma mark -
#pragma mark Table view data source

- (void) configureCell: (UITableViewCell *) cell
           atIndexPath: (NSIndexPath *) indexPath
{
	NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
	NSError *error;
	if (![context save: &error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error in configureCell: %@, %@", error, [error userInfo]);
        abort();
    }
	
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView 
{
	NSUInteger count = [[self.fetchedResultsController sections] count];
    return (count == 0) ? 1 : count;
}


- (NSInteger) tableView: (UITableView *) tableView 
  numberOfRowsInSection: (NSInteger)section 
{
    NSArray *sections = [self.fetchedResultsController sections];
    NSUInteger count = 0;
    if ([sections count]) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
        count = [sectionInfo numberOfObjects];
    }
    return count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *) tableView: (UITableView *) tableView 
          cellForRowAtIndexPath: (NSIndexPath *) indexPath 
{
	Selection *cellManagedObject = [self.fetchedResultsController objectAtIndexPath: indexPath]; 
    
    static NSString *CellIdentifier = @"selectionCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle 
                                       reuseIdentifier: CellIdentifier] 
                autorelease];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.detailTextLabel.text = cellManagedObject.selectionContainsItem.itemDescription;
	cell.textLabel.text = cellManagedObject.selectionContainsItem.itemName;
	
	// cell.gestureRecognizers = defaultApp.gestureRecognizers;
	
    return cell;
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void) tableView: (UITableView *) tableView 
commitEditingStyle: (UITableViewCellEditingStyle) editingStyle 
 forRowAtIndexPath: (NSIndexPath *) indexPath 
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
		// Save the context.
		NSError *error;
        error = nil;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}


- (BOOL) tableView: (UITableView *) tableView 
canMoveRowAtIndexPath: (NSIndexPath *) indexPath 
{
	// The table view should not be re-orderable.
    return NO;
}

/*
 - (void) tableView: (UITableView *) tableView
 willDisplayCell: (UITableViewCell *) cell
 forRowAtIndexPath: (NSIndexPath *) indexPath
 {
 
 }	
 */

#pragma mark -
#pragma mark Table view delegate

- (void) tableView: (UITableView *) tableView 
didSelectRowAtIndexPath: (NSIndexPath *) indexPath 
{
	// Navigation logic may go here -- for example, create and push another view controller.
    
	Selection *selectedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    selectedObject.selectionComplete = [NSNumber numberWithBool:![selectedObject.selectionComplete boolValue]];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
	if ([selectedObject.selectionComplete boolValue]) {
        cell.imageView.image = [UIImage imageNamed:@"GrnCheck.png"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"BlankCheck.png"];
    }
}

-(void)tableView:(UITableView *)tableView 
 willDisplayCell:(UITableViewCell *)cell 
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
	Selection *selectedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if ([selectedObject.selectionComplete boolValue]) {
        cell.imageView.image = [UIImage imageNamed:@"GrnCheck.png"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"BlankCheck.png"];
    }
}

/*
 - (void) tableView: (UITableView *) tableView
 accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *) indexPath
 {
 
 }
 */

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *) fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    /*
     Set up the fetched results controller.
	 */
	// Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	MilkAndEggsAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
	
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"Selection" 
                                              inManagedObjectContext: managedObjectContext];
    [fetchRequest setEntity: entity];
	// Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
	NSPredicate *setPred = [self getListPredicate];
	
	[fetchRequest setPredicate:setPred];	
    
	// Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"selectionSequence" 
                                                                   ascending: YES 
                                                                    selector: @selector(compare:)];
	
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors: sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
	// nil for section name key path means "no sections".
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest: fetchRequest 
                                                                          managedObjectContext: managedObjectContext 
                                                                            sectionNameKeyPath: nil 
                                                                                     cacheName: nil];
    frc.delegate = self;
    _fetchedResultsController = frc;
    
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
    return _fetchedResultsController;
}    

- (NSPredicate *) getListPredicate
{
	NSPredicate *setPredicate = nil;
	if ([self.selectionSearchBar.text length] > 0) {
		setPredicate = [NSPredicate predicateWithFormat: @"selectionContainsItem.itemName contains[cd] %@ AND selectionOfList.listActive == TRUE", 
                        self.selectionSearchBar.text];
	}
	
	if (setPredicate == nil) {
		//setPredicate = [NSPredicate predicateWithFormat: @"TRUEPREDICATE"];
        setPredicate = [NSPredicate predicateWithFormat: @"selectionOfList.listActive == TRUE"];
	}
	
	return setPredicate;
}

#pragma mark -
#pragma mark Fetched results controller delegate


- (void) controllerWillChangeContent: (NSFetchedResultsController *) controller 
{
    [self.selectionTableView beginUpdates];
}


- (void) controller: (NSFetchedResultsController *) controller 
   didChangeSection: (id <NSFetchedResultsSectionInfo>) sectionInfo
            atIndex: (NSUInteger) sectionIndex 
      forChangeType: (NSFetchedResultsChangeType) type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.selectionTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] 
                                   withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.selectionTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] 
                                   withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller: (NSFetchedResultsController *) controller 
   didChangeObject: (id) anObject
       atIndexPath: (NSIndexPath *)indexPath 
     forChangeType: (NSFetchedResultsChangeType) type
      newIndexPath: (NSIndexPath *) newIndexPath 
{
    
	// UITableView *tableView = self.documentTableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.selectionTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.selectionTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell: [self.selectionTableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.selectionTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.selectionTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void) controllerDidChangeContent: (NSFetchedResultsController *) controller 
{
    [self.selectionTableView endUpdates];
}


/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

#pragma mark -
#pragma mark Search Bar Delegate

- (void)searchBar:(UISearchBar *)searchBar 
    textDidChange:(NSString *)searchText
{
	NSError *error;
	
	[self.fetchedResultsController.fetchRequest setPredicate: [self getListPredicate]];
	if (![self.fetchedResultsController performFetch: &error]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Error Loading Data",
                                                                                   @"Error Loading Data")
                                                        message: [NSString stringWithFormat: NSLocalizedString(@"Error was: %@.  Quitting.",
                                                                                                               @"Error was: %@.  Quitting."),
                                                                  [error localizedDescription],
                                                                  [error localizedDescription]]
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
	
	[self.selectionTableView reloadData];	
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[self.selectionSearchBar resignFirstResponder];
}

- (void) searchBarCancelButtonClicked: (UISearchBar *) searchBar
{
	[self.selectionSearchBar resignFirstResponder];
	
	self.selectionSearchBar.text = @"";
	NSError *error;
	
	[self.fetchedResultsController.fetchRequest setPredicate: [self getListPredicate]];
    if (![self.fetchedResultsController performFetch: &error]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Error Loading Data",
                                                                                   @"Error Loading Data")
                                                        message: [NSString stringWithFormat: NSLocalizedString(@"Error was: %@.  Quitting.",
                                                                                                               @"Error was: %@.  Quitting."),
                                                                  [error localizedDescription],
                                                                  [error localizedDescription]]
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
    [self.selectionTableView reloadData];	
}

#pragma mark -
#pragma mark Toolbar methods

-(void) drawButtons 
{
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchPressed)];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editPressed)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)];
    
    
    
    switch (currentStatus) {
        case kScreenListDisplay :
        {
            NSArray *itemsArray = [[NSArray alloc] initWithObjects:editButton, flexSpace, searchButton, flexSpace, addButton,  nil];
            [toolBar setItems:itemsArray animated:YES];
            [itemsArray release];
        }    
            break;
        case kScreenListSearch :
        {
            
            self.selectionSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 230.0, 43.0)];
            
            self.selectionSearchBar.delegate = self;
            UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:self.selectionSearchBar];
            
            NSArray *itemsArray = [[NSArray alloc] initWithObjects:searchItem,cancelButton, nil];
            [toolBar setItems:itemsArray animated:YES];
            [itemsArray release];
            [self.selectionSearchBar becomeFirstResponder];
            [searchItem release];
            [selectionSearchBar release];
        }    
            break;       
        case kScreenEditSearch:
        {
            
            self.selectionSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 230.0, 43.0)];
            
            self.selectionSearchBar.delegate = self;
            
            UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:self.selectionSearchBar];
            
            NSArray *itemsArray = [[NSArray alloc] initWithObjects:searchItem,flexSpace,cancelButton,flexSpace,doneButton,  nil];
            [toolBar setItems:itemsArray animated:YES];
            [itemsArray release]; 
            [searchItem release];
            [selectionSearchBar release];
            
        }
            break;        
        case kScreenListEdit:
        {
            NSArray *itemsArray = [[NSArray alloc] initWithObjects:doneButton, flexSpace, searchButton,  nil];
            [toolBar setItems:itemsArray animated:YES];
            [itemsArray release];            
        }
            break;
        default:
            break;
    }
    
    [flexSpace release];
    [addButton release];
    [searchButton release];
    [editButton release];
    [doneButton release];
    [cancelButton release];
    
    
    
}

-(void) returnState {
    [self.selectionTableView setEditing: FALSE animated: YES];
    
    self.currentStatus = kScreenListDisplay;
    
    [self drawButtons];
}

-(void) cancelPressed {
    // clear out the search text
    self.selectionSearchBar.text = @"";
    // refreshes from coredata
    [self getListPredicate];
    // return first button bar state
    [self returnState];
}

- (void) editPressed
{
	[self.selectionTableView setEditing: TRUE animated: YES];
    
    self.currentStatus = kScreenListEdit;
    
    [self drawButtons];
}

-(void) donePressed
{
    
    [self returnState];
    
}

-(void) searchPressed {
    //[self.selectionTableView setEditing: FALSE animated: YES];
    if (self.currentStatus == kScreenListDisplay) {
        self.currentStatus = kScreenListSearch;
    }
    
    if (self.currentStatus == kScreenListEdit) {
        self.currentStatus = kScreenEditSearch;
    }
    
    [self drawButtons];
}

@end
