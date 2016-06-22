//
//  ViewController.h
//  LJFNavigationCV
//
//  Created by mini on 15/12/23.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NAViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

