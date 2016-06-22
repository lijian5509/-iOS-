//
//  CustomWebViewController.m
//  Web浏览
//
//  Created by mini on 15/9/16.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "CustomWebViewController.h"

@interface CustomWebViewController ()

@end

@implementation CustomWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:web];
    web.dataDetectorTypes = UIDataDetectorTypeAll;
    
    NSURL *url = [NSURL URLWithString:_uslString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
