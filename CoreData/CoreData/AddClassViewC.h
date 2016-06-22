//
//  AddClassViewC.h
//  CoreData
//
//  Created by mini on 15/12/18.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddClassOperateFinished)(NSString *className,NSError *error);

@interface AddClassViewC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, copy)AddClassOperateFinished addClassResultBlock;

- (IBAction)btnClicked:(UIButton *)sender;

- (void)returnRuslt:(AddClassOperateFinished)block;


@end
