//
//  Item.h
//  MilkAndEggs
//
//  Created by Marty Cullen on 4/13/11.
//  Copyright 2011 MartyCullen.Com. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Selection;

@interface Item :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * itemName;
@property (nonatomic, retain) NSString * itemDescription;
@property (nonatomic, retain) NSSet* itemOfSelection;

@end


@interface Item (CoreDataGeneratedAccessors)
- (void)addItemOfSelectionObject:(Selection *)value;
- (void)removeItemOfSelectionObject:(Selection *)value;
- (void)addItemOfSelection:(NSSet *)value;
- (void)removeItemOfSelection:(NSSet *)value;

@end

