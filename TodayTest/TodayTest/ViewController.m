//
//  ViewController.m
//  TodayTest
//
//  Created by mini on 15/9/11.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults* userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.lijianfan"];
    [userDefault setObject:@"lijianfan today test" forKey:@"group.lijianfan.nickname"];
    [userDefault synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClicked:(UIButton *)sender {
}
@end
