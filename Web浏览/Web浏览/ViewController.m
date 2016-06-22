//
//  ViewController.m
//  Web浏览
//
//  Created by mini on 15/9/15.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "ViewController.h"
#import "CustomWebViewController.h"
#import <SafariServices/SafariServices.h>

@interface ViewController ()

@property (nonatomic, copy)NSString *urlStr;

@end

@implementation ViewController

/**
 *  在iOS 9中，开发者有三种方法来显示Web内容：
 
 WKWebView 使用
 http://www.cocoachina.com/ios/20150911/13301.html
 
 Safari：使用openURL(_:)在Safari中展示页面，会不得不让用户离开你的应用。
 
 自定义浏览体验：你可以利用WKWebView或UIWebView从头开始创建浏览体验。
 
 SFSafariViewController ：通过SFSafariViewController，你几乎可以使用所有Safari的一些便利特性，而无需让用户离开你的应用。
 
 在iOS上，查看web内容主要有两种情况。
 
 自定义Web内容：这些内容不是用于浏览的。这可能是一个报告或是从API或服务器生成的类似的东西。这里，用户查看的是一块儿内容，而不是做别的。
 
 浏览网站：这是最常见的场景。用户需要随时浏览网页来登录到服务或浏览网站。
 
 使用WKWebView 。它是UIWebView的继任者，并包括几个增强功能，如使用 Nitro Javascript engine。这种方法可以让你从头开始构建整个用户界面。还有其他的功能，如安全加载文件和使用WKWebsiteDataStore查询cookies。
 */
//http://www.cocoachina.com/ios/20150826/13157.html
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _urlStr = @"https://google.com";
    
    [self.safariBtn addTarget:self action:@selector(openWebWithSafari) forControlEvents:UIControlEventTouchUpInside];
    [self.webBtn addTarget:self action:@selector(prepareForSegue:sender:) forControlEvents:UIControlEventTouchUpInside];
    [self.SFCBtn addTarget:self action:@selector(openWebWithSFSafiViewC) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark 用Safari打开网页
- (void)openWebWithSafari
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:_urlStr]];
    
}
#pragma mark 用web加载网页
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:segue.destinationViewController];
    CustomWebViewController *cus = [CustomWebViewController new];
    
}
#pragma mark 用SFSafariViewController 加载
- (void)openWebWithSFSafiViewC
{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
