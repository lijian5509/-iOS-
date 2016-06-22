//
//  MianViewController.m
//  豆瓣搜索
//
//  Created by mini on 15/10/12.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "MianViewController.h"

@interface MianViewController ()

@end

@implementation MianViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (AMTumblrHud *)amTumblrHud
{
    if (_amTumblrHud == nil) {
        _amTumblrHud = [[AMTumblrHud alloc] initWithFrame:CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5),
                                                                     (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20)];
    }
    return _amTumblrHud;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 创建导航栏标题

- (void)addTitleViewWithTitle:(NSString *)title
{
    UILabel *label = [MyControl creatLabelWithFrame:CGRectMake(0, 0, 100, 44) text:title];
 
    label.textColor = [UIColor colorWithRed:30/255.f green:160/255.f blue:230/255.f alpha:1];
    
    label.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:22];
    
    label.textAlignment = NSTextAlignmentCenter;

    self.navigationItem.titleView = label;
    
}

#pragma mark - 创建左右按钮

- (void)addBarButtonItemWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action isLeft:(BOOL)isLeft
{
    
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 40, 30) target:target sel:action tag:0 image:imageName title:title];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    if (isLeft) {
    
        self.navigationItem.leftBarButtonItem = item;
    
    }else{
    
        self.navigationItem.rightBarButtonItem = item;
    
    }
    
}

#pragma mark - 网络请求

- (void)requestDataWith:(NSDictionary *)parameter and:(NSString *)urlPath isPost:(BOOL)isPost
{
    [self.view addSubview:self.amTumblrHud];
    
    [self.amTumblrHud showAnimated:YES];
    
    if (isPost) {
        
        [LJFHttpRequest post:urlPath parameters:parameter success:^(id responseObject) {
            
            [self.amTumblrHud removeFromSuperview];
            
            [self requestSuccessWith:responseObject];
            
        } fail:^{
            
            [self.amTumblrHud removeFromSuperview];
            
            [self requestFailed];
            
        }];
        
    }else{
       
        [LJFHttpRequest get:urlPath parameters:parameter success:^(id responseObject) {
           
            [self.amTumblrHud removeFromSuperview];
            
            [self requestSuccessWith:responseObject];
            
        } fail:^{
            
            [self.amTumblrHud removeFromSuperview];
            
            [self requestFailed];
            
        }];
    }
}

#pragma mark - 请求失败   ,子类根据需求重新实现

- (void)requestFailed
{
    [self showAlert:@"网络错误"];
}

#pragma mark - 请求成功    ,子类根据需求重新实现

- (void)requestSuccessWith:(id)responsData
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
