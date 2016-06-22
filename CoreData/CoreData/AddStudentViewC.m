//
//  AddStudentViewC.m
//  CoreData
//
//  Created by mini on 15/12/18.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "AddStudentViewC.h"

@interface AddStudentViewC ()

@end

@implementation AddStudentViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.classNameTextF.text = self.classRoom.clsName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClicked:(UIButton *)sender {
    
    switch (sender.tag) {
        case 101:
        {
            [self performSelector:@selector(popViewControllerAnimated:) withObject:nil];
        }
            break;
        case 102:
        {
            if (self.stuNameTextF.text.length == 0 || self.stuNumTextF.text.length == 0 || self.classNameTextF.text.length == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入完整信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                break;
            }
           NSError *error = [[CoreDataBase shareInstance] addStudent:self.stuNameTextF.text and:[self.stuNumTextF.text intValue] atClass:self.classNameTextF.text];
            
            if (error) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:error.domain message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                break;
            }
            
            self.addClassResultBlock(YES,nil);
            [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:nil];
        }
            break;
            
        default:
            break;
    }
}

- (void)returnRuslt:(AddClassOperateFinished)block
{
    self.addClassResultBlock = block;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
