//
//  Student+CoreDataProperties.h
//  CoreData
//
//  Created by mini on 15/12/18.
//  Copyright © 2015年 mini. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *stuNum;
@property (nullable, nonatomic, retain) NSString *stuName;
@property (nullable, nonatomic, retain) ClassRoom *classRoom;

@end

NS_ASSUME_NONNULL_END
