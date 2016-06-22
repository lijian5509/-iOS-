//
//  ViewController.h
//  CoreData
//
//  Created by mini on 15/12/17.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

- (IBAction)barItemSelector:(UIBarButtonItem *)sender;

- (void)getData;

@end

