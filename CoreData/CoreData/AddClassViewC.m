//
//  AddClassViewC.m
//  CoreData
//
//  Created by mini on 15/12/18.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "AddClassViewC.h"

@interface AddClassViewC ()

@end

@implementation AddClassViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnClicked:(UIButton *)sender {
    
    switch (sender.tag) {
        case 101://取消
        {
            [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:nil];
        }
            break;
        case 102://添加
        {
            if (self.textField.text.length == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入班级名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController: alert animated: YES completion: nil];
                break;
            }
            NSError *error = [[CoreDataBase shareInstance] addClassroom:self.textField.text];
            if (error) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"改班级已存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
                
                [alert addAction:action];
                [self presentViewController: alert animated: YES completion: nil];
                break;
            }
            self.addClassResultBlock(self.textField.text,nil);
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

@end
