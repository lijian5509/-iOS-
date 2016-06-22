//
//  CoreDataBase.m
//  CoreData
//
//  Created by mini on 15/12/18.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "CoreDataBase.h"

@implementation CoreDataBase

+ (instancetype)shareInstance
{
    static id shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

- (NSManagedObjectContext *)context
{
    if (!_context) {
        AppDelegate *myAppDelgate = [UIApplication sharedApplication].delegate;
        _context = myAppDelgate.managedObjectContext;
    }
    return _context;
}

- (NSArray *)getAllClass
{
    NSFetchRequest *req = [[NSFetchRequest alloc]initWithEntityName:CLASSROOM];
    NSArray *arr = [self.context executeFetchRequest:req error:nil];
    return arr;
}

- (NSArray *)getAllStudentOfClass:(ClassRoom *)class
{
    NSFetchRequest *req = [[NSFetchRequest alloc]initWithEntityName:STUDENT];
    req.predicate = [NSPredicate predicateWithFormat:@"classRoom = %@",class];
    NSArray *arr = [self.context executeFetchRequest:req    error:nil];
    return arr;
}

- (NSError *)addClassroom:(NSString *)className
{
    //查询条件不能定义为宏   可以  == = contain like 不区分大小写
    NSError *error = nil;
    NSFetchRequest *req = [[NSFetchRequest alloc]initWithEntityName:CLASSROOM];
    req.predicate = [NSPredicate predicateWithFormat:@"clsName = %@",className];
    
    NSArray *arr = [self.context executeFetchRequest:req error:nil];
    
    if (arr.count != 0) {
        error = [NSError errorWithDomain:@"该班级已存在" code:102 userInfo:nil];
        return error;
    }
    
    ClassRoom *cls = [NSEntityDescription insertNewObjectForEntityForName:CLASSROOM inManagedObjectContext:self.context];
    
    cls.clsName = className;
    
    [self.context save:&error];
    if (error) {
        NSLog(@"创建班级失败");
    }else{
        NSLog(@"创建班级成功");
    }
    return error;
}

- (NSError *)addStudent:(NSString *)stuName
                    and:(int)stuNum
                atClass:(NSString *)classNmae
{
    NSError *error = nil;
    //查询对应班级
    NSFetchRequest *req = [[NSFetchRequest alloc]initWithEntityName:CLASSROOM];
    req.predicate = [NSPredicate predicateWithFormat:@"clsName = %@",classNmae];
    NSArray *arr = [self.context executeFetchRequest:req error:nil];
    
    if (arr.count == 0) {
        error = [NSError errorWithDomain:@"该班级不存在" code:101 userInfo:nil];
        return error;
    }
    
    //新创建一个学生
    Student *stu = [NSEntityDescription insertNewObjectForEntityForName:STUDENT
                                                 inManagedObjectContext:self.context];
    stu.stuName = stuName;
    stu.stuNum = [NSNumber numberWithInt:stuNum];
    
    //添加到班级
    [arr[0] addStudentsObject:stu];
    //保存
    [self.context save:&error];
    return error;
}

- (NSError *)deleteClass:(ClassRoom *)classroom
{
    [self.context deleteObject:classroom];
    NSError *error = nil;
    [_context save:&error];
    return error;
}

- (NSError *)deleteStudent:(Student *)student
{
    [self.context deleteObject:student];
    NSError *error = nil;
    [self.context save:&error];
    return error;
}

- (NSError *)updateClass:(ClassRoom *)newClass with:(ClassRoom *)oldClass
{
    NSError *error = nil;
    NSFetchRequest *req = [[NSFetchRequest alloc]initWithEntityName:CLASSROOM];
    req.predicate = [NSPredicate predicateWithFormat:@"clsName = %@",oldClass.clsName];
    NSArray *array = [self.context executeFetchRequest:req error:&error];
    [array[0] setClsName:newClass.clsName];
    [self.context save:&error];
    return error;
}

- (NSError *)updateStudent:(Student *)newStudent with:(Student *)oldStudent
{
    NSFetchRequest *req = [[NSFetchRequest alloc]initWithEntityName:STUDENT];
    req.predicate = [NSPredicate predicateWithFormat:@"stuName = %@",oldStudent.stuName];
    NSArray *arr = [self.context executeFetchRequest:req error:nil];
    [arr[0] setStuName:newStudent.stuName];
    [arr[0] setStuNum:newStudent.stuNum];
    NSError *error = nil;
    [self.context save:&error];
    return error;
}


@end
