//
//  EditItemViewController.h
//  MilkAndEggs
//
//  Created by Mickey Phelps on 3/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MilkAndEggsAppDelegate.h"
#import "Item.h"

@interface EditItemViewController : UIViewController {
	UITextField *iname;
	UITextField *idesc;
	
	Item *item;
}

@property (nonatomic, retain) IBOutlet UITextField *iname;
@property (nonatomic, retain) IBOutlet UITextField *idesc;
@property (nonatomic, retain) Item *item;

- (IBAction) backgroundTap: (id) sender;

@end
