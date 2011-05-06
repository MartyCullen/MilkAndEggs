//
//  Selection.h
//  MilkAndEggs
//
//  Created by Marty Cullen on 4/13/11.
//  Copyright 2011 MartyCullen.Com. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Item;
@class List;

@interface Selection :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * selectionSequence;
@property (nonatomic, retain) NSNumber * selectionComplete;
@property (nonatomic, retain) NSNumber * selectionQuantity;
@property (nonatomic, retain) Item * selectionContainsItem;
@property (nonatomic, retain) List * selectionOfList;

@end



