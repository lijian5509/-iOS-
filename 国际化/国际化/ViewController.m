//
//  ViewController.m
//  国际化
//
//  Created by mini on 15/11/27.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *title = NSLocalizedStringFromTable(@"play", @"localizable", nil);
    
    
    /**
     *  国际化
     *
     *  1. 创建本地化.string 文件  如果name为：Localizable 用NSLocalizedString(@"play",@""); 用key获取对应的value
     否则用:NSLocalizedStringFromTable(key, 文件名, nil);
     2.选中.string 文件 ，在Utilites中，点击Localizable选项
     3.创建English语言包。
     4.根据需要添加其他多国语言支持。在project 的info 设置中Localizations 选项  然后选择语言后finish
     5.在不同的语言文件内添加内容即可
     */
     NSString *strPlay = NSLocalizedString(@"play",@"");
    
    [self.btn setTitle:strPlay forState:UIControlStateNormal];
    
//    获得当前设备的语言
    
    // 取得用户默认信息
    
    NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults ];
    
    // 取得 iPhone 支持的所有语言设置
    
    NSArray *languages = [defaults objectForKey : @"AppleLanguages" ];
    
    NSLog (@"%@", languages);
    
    
    
    // 获得当前iPhone使用的语言
    
    NSString* currentLanguage = [languages objectAtIndex:0];
    
    NSLog(@"当前使用的语言：%@",currentLanguage);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
