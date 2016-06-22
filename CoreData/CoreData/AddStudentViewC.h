//
//  AddStudentViewC.h
//  CoreData
//
//  Created by mini on 15/12/18.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddClassOperateFinished)(BOOL result,NSError *error);

@interface AddStudentViewC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *stuNameTextF;

@property (weak, nonatomic) IBOutlet UITextField *stuNumTextF;

@property (weak, nonatomic) IBOutlet UITextField *classNameTextF;

@property (nonatomic, copy)AddClassOperateFinished addClassResultBlock;

- (void)returnRuslt:(AddClassOperateFinished)block;

@property (nonatomic,strong) ClassRoom *classRoom;

@end
