//
//  SViewController.m
//  CoreData
//
//  Created by mini on 15/12/18.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "SViewController.h"
#import "AddStudentViewC.h"

@interface SViewController ()

@property (nonatomic, strong)UITableView *sTableView;

@end

@implementation SViewController

- (UITableView *)sTableView
{
    if (!_sTableView) {
        _sTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
        _sTableView.delegate = self;
        _sTableView.dataSource = self;
    }
    return _sTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(barItemSelector:)];
    self.navigationItem.rightBarButtonItem = item;
 
    [self.view addSubview:self.sTableView];
    // Do any additional setup after loading the view.
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[[CoreDataBase shareInstance] getAllStudentOfClass:self.classRoom]];
    [self.sTableView reloadData];
}

- (void)barItemSelector:(UIBarButtonItem *)sender
{
    AddStudentViewC *addSC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"addStudent"];
    [addSC returnRuslt:^(BOOL result, NSError *error) {
        if (!result) {
            NSLog(@"添加学生失败");
        }else{
            [self getData];
        }
    }];
    addSC.classRoom = self.classRoom;
    self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self.navigationController pushViewController:addSC animated:YES];
}

#pragma mark - 单元格删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassRoom *class = self.dataArray[indexPath.row];
    [[CoreDataBase shareInstance] deleteClass:class];
    [self getData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"student";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    Student *stu = self.dataArray[indexPath.row];
    cell.textLabel.text = stu.stuName;
    cell.detailTextLabel.text = [stu.stuNum stringValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
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
