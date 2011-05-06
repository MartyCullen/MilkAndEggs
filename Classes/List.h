//
//  List.h
//  MilkAndEggs
//
//  Created by Marty Cullen on 4/13/11.
//  Copyright 2011 MartyCullen.Com. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Selection;

@interface List :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * listName;
@property (nonatomic, retain) NSString * listDescription;
@property (nonatomic, retain) NSNumber * listActive;
@property (nonatomic, retain) NSSet* listContainsSelection;

@end


@interface List (CoreDataGeneratedAccessors)
- (void)addListContainsSelectionObject:(Selection *)value;
- (void)removeListContainsSelectionObject:(Selection *)value;
- (void)addListContainsSelection:(NSSet *)value;
- (void)removeListContainsSelection:(NSSet *)value;

@end

