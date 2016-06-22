//
//  ViewController.m
//  CoreData
//
//  Created by mini on 15/12/17.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "CViewController.h"
#import "AddClassViewC.h"
#import "SViewController.h"

@interface CViewController ()

@end

@implementation CViewController

- (NSMutableArray *)dataArray
{
    if(!_dataArray){
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self getData];
}

- (void)getData
{
    [self.dataArray removeAllObjects];
    CoreDataBase *coreData = [CoreDataBase shareInstance];
    [self.dataArray addObjectsFromArray:[coreData getAllClass]];
    [self.tableView reloadData];
}

- (IBAction)barItemSelector:(UIBarButtonItem *)sender
{
    if (sender.tag == 102) {
        AddClassViewC *addVC = [self.storyboard instantiateViewControllerWithIdentifier:@"addClass"];
        [addVC returnRuslt:^(NSString *className, NSError *error) {
            if (error) {
                NSLog(@"添加班级失败");
            }else{
                [self getData];
            }
        }];
        self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self.navigationController pushViewController:addVC animated:YES];
    }else{
        [self.tableView setEditing:!self.tableView.editing animated:YES];
        if ([sender.title isEqualToString:@"Edit"]) {
            sender.title = @"Done";
        }else{
            sender.title = @"Edit";
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 单元格删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassRoom *class = self.dataArray[indexPath.row];
    [[CoreDataBase shareInstance] deleteClass:class];
    [self getData];
}

#pragma mark - 设置编辑格式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - 设置右侧删除按钮显示文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    ClassRoom *class = self.dataArray[indexPath.row];
    cell.textLabel.text = class.clsName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SViewController *sv = [[SViewController alloc]init];
    sv.classRoom = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:sv animated:YES];
}

@end
