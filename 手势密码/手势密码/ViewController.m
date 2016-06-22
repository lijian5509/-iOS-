//
//  ViewController.m
//  手势密码
//
//  Created by Lone on 16/5/25.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "HandSecurityView.h"

@interface ViewController ()<HandSecurityViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)drawHandSecurityEndWithSecurity:(NSString *)security
{
    NSString *message;
    if ([security isEqualToString:@"12345678"]) {
        message = @"密码正确";
    }else{
        message = @"密码错误";
    }
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示"
                                                                          message:message
                                                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action_cancel    = [UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    UIAlertAction *action_sure      = [UIAlertAction actionWithTitle:@"确定"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertControl addAction:action_sure];
    [alertControl addAction:action_cancel];
    [self presentViewController:alertControl animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
