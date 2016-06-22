//
//  AppDelegate.h
//  CoreData
//
//  Created by mini on 15/12/17.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//被管理对象上下文 （数据管理器）
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//数据对象模型 （数据模型器）
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久化存储助理（数据链接器）
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

