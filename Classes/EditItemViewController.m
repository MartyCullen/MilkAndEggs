//
//  EditItemViewController.m
//  MilkAndEggs
//
//  Created by Mickey Phelps on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EditItemViewController.h"


@implementation EditItemViewController

@synthesize iname;
@synthesize item;
@synthesize idesc;

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
	
	self.iname.text = self.item.itemName;
	self.idesc.text = self.item.itemDescription;
}

- (void) viewWillDisappear:(BOOL)animated
{
	MilkAndEggsAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context = appDelegate.managedObjectContext;
	
	self.item.itemName = self.iname.text;
	self.item.itemDescription = self.idesc.text;
	
	NSError *error;
	
	[context save: &error];
	
}

- (IBAction) backgroundTap: (id) sender
{
	[iname resignFirstResponder];
	[idesc resignFirstResponder];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.item = nil;
	self.iname = nil; 
	self.idesc = nil;
}


- (void)dealloc {
    [super dealloc];
	
	[item release];
	[iname release];
	[idesc release];
}


@end
