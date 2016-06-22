//
//  ClassRoom+CoreDataProperties.h
//  CoreData
//
//  Created by mini on 15/12/18.
//  Copyright © 2015年 mini. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ClassRoom.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassRoom (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *clsName;
@property (nullable, nonatomic, retain) NSSet<Student *> *students;

@end

@interface ClassRoom (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet<Student *> *)values;
- (void)removeStudents:(NSSet<Student *> *)values;

@end

NS_ASSUME_NONNULL_END
