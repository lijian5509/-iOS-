//
//  ViewController.m
//  豆瓣搜索
//
//  Created by mini on 15/10/12.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic) NSInteger searchOperation; //搜索状态记录 1 搜书 2 搜视频 3 搜音乐

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.searchOperation = 1;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"123.jpg"]];
    
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)view;
            
            btn.layer.cornerRadius = 3;
            
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClicked:(UIButton *)sender {
    
    [self.textField resignFirstResponder];
    
    if (self.textField.text.length == 0) {
        
        [self showAlert:@"请输入查找内容"];
        
        return;
    }
    
    switch (sender.tag) {
            
        case 101://搜书
        {
            [self searchBook];
        }
            break;
            
        case 102://搜视频
        {
            [self searchMovie];
        }
            break;
            
        case 103://搜音乐
        {
            [self searchMusic];
        }
            break;
            
            
        default:
            break;
    }
    
}

#pragma mark - 搜书

- (void)searchBook
{
    NSString *requestUrl = [CommonUrl(@"book") stringByAppendingPathComponent:SearchUrl];
    
    [self requestDataWith:@{@"q":self.textField.text,@"start":@"0",@"count":@"10"} and:requestUrl isPost:YES];
}

#pragma mark - 搜电影

- (void)searchMovie
{
    NSString *requestUrl = [CommonUrl(@"movie") stringByAppendingPathComponent:SearchUrl];
    
    [self requestDataWith:@{@"q":self.textField.text,@"start":@"0",@"count":@"10"} and:requestUrl isPost:YES];
}

#pragma mark - 搜音乐

- (void)searchMusic
{
    NSString *requestUrl = [CommonUrl(@"music") stringByAppendingPathComponent:SearchUrl];
    
    [self requestDataWith:@{@"q":self.textField.text,@"start":@"0",@"count":@"10"} and:requestUrl isPost:YES];
}

#pragma mark - 请求成功处理数据

- (void)requestSuccessWith:(id)responsData
{
    NSDictionary *dict = (NSDictionary *)responsData;
    
    [self showAlert:[NSString stringWithFormat:@"搜索到%@条相关内容",dict[@"count"]]];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
