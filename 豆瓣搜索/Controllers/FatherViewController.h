//
//  FatherViewController.h
//  豆瓣搜索
//
//  Created by mini on 15/10/12.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "MianViewController.h"

@interface FatherViewController : MianViewController

//表格视图
@property (nonatomic,strong)UITableView *tableView;

//参数字典
@property (nonatomic,strong)NSMutableDictionary *parameterDict;

//刷新状态
@property (nonatomic) BOOL isRefreshing;

//页码
@property (nonatomic) NSInteger currentPage;

//失败界面
@property (nonatomic, strong)UIView *failView;

//创建刷新
- (void)creatRefreshing;

//结束刷新
- (void)endRefreshing;

@end
