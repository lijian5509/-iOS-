//
//  CoreDataBase.h
//  CoreData
//
//  Created by mini on 15/12/18.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CoreDataBase : NSObject

@property (nonatomic,strong) NSManagedObjectContext *context;


+ (instancetype)shareInstance;

//获取所有班级
- (NSArray *)getAllClass;
//获取指定班级的所有学生
- (NSArray *)getAllStudentOfClass:(ClassRoom *)class;
//创建班级
- (NSError *)addClassroom:(NSString *)className;
//增加学生
- (NSError *)addStudent:(NSString *)stuName
               and:(int)stuNum
           atClass:(NSString *)classNmae;
//删除学生
- (NSError *)deleteStudent:(Student *)student;
//删除班级
- (NSError *)deleteClass:(ClassRoom *)classroom;
//修改班级信息
- (NSError *)updateClass:(ClassRoom *)newClass
               with:(ClassRoom *)oldClass;
//修改学生信息
- (NSError *)updateStudent:(Student *)newStudent
                 with:(Student *)oldStudent;

@end
