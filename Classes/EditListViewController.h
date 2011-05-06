//
//  EditListViewController.h
//  MilkAndEggs
//
//  Created by Marty Cullen on 4/13/11.
//  Copyright 2011 MartyCullen.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MilkAndEggsAppDelegate.h"
#import "List.h"



@interface EditListViewController : UIViewController {
		UITextField *iname;
		UITextField *idesc;
		
		List *list;
}

@property (nonatomic, retain) IBOutlet UITextField *iname;
@property (nonatomic, retain) IBOutlet UITextField *idesc;
@property (nonatomic, retain) List *list;

- (IBAction) backgroundTap: (id) sender;

@end
