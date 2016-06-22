//
//  ViewController.m
//  HTTP参数请求
//
//  Created by mini on 15/12/4.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *reqData = @"Data=";
    NSData *postDatas = nil;
    NSString *urlPath = @"url";
    
    //组json字符串数据
    NSDictionary *mulDic = @{
                                @"goods_list":@[@{
                                                    @"goods_id":@"589",
                                                    @"id":@"107",
                                                    @"amount":@"1",
                                                    }],
                                @"user_id":@"91",
                                };
    
    //NSJSONSerialization 组json字符串
    if ([NSJSONSerialization isValidJSONObject:mulDic]) {
        
        postDatas = [NSJSONSerialization dataWithJSONObject:mulDic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:postDatas encoding:NSUTF8StringEncoding];
        reqData = [reqData stringByAppendingString:str];
        NSLog(@"reqData:%@",reqData);
        
        //NSData *postData = [reqData dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        postDatas = [NSData dataWithBytes:[reqData UTF8String] length:[reqData length]];
        
    }
    
    NSString *len = [NSString stringWithFormat:@"%d",(int)[postDatas length]];
    NSURL *url = [NSURL URLWithString:@"http://121.41.106.33:8080/javaInterface/services/orderCar?act=item_add&version=V2"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
//    [request setValue:@"*/*" forKey:@"accept"];
//    [request setValue:@"Keep-Alive" forKey:@"connection"];
//    [request setValue:@"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" forKey:@"user-agent"];
//    [request setValue:len forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postDatas];
    
    NSData *retData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *ret = [[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",ret);   //解析返回的数据JSON格式字符串
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:retData options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",dic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
