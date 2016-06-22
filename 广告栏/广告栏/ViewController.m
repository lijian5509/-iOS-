//
//  ViewController.m
//  广告栏
//
//  Created by mini on 15/11/9.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "ViewController.h"
#import "LJFAdertisementView.h"

@interface ViewController ()<LJFAdertisementDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LJFAdertisementView *scrollView = [[LJFAdertisementView alloc]initWithFrame:CGRectMake(0, 100, 320, 100) andImagesArray:@[@"校花.jpg",@"猫猫.jpg",@"速度.jpg"] isUrl:NO linkStrs:nil delegate:self TimeInterval:2.0];
    
    scrollView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:scrollView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 回调

- (void)LJFAdertisementViewBeSelected:(NSInteger)indexSite with:(NSString *)linkStr
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
