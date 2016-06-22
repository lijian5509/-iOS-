//
//  TodayViewController.m
//  TodayClipsWidget
//
//  Created by mini on 15/9/11.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>


@end

//http://blog.csdn.net/yongyinmg/article/details/40982791     参考链接
//http://www.cocoachina.com/ios/20140904/9527.html
//http://blog.csdn.net/ralbatr/article/details/44194389
//http://www.jianshu.com/p/ab268a1ae000
/**（NSExtension）
 *  系统默认是storyboard 约束布局 ，如果想代码实现在today 的plist文件中删掉NSExtensionMainStoryboard
    使用自定义视图控制器 在plist文件中添加key :NSExtensionPrincipalClass  value:对应的视图控制器名称
    修改Widget显示的名称  在plist文件中修改CFBundleDisplayName即可
 
    主程序target 和today数据传递：选取主程序target - Capabilities - 打开APPgroup - 创建新的group
    today ：选取主程序target - Capabilities - 打开APPgroup - 添加会创建与主程序相同名的group
 */
@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //调整widget的高频度
//    View高度问题：有的时候运行程序，view显示不出来，这个时候你可能需要[self setPreferredContentSize:(CGSize)];
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, 200);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 120, 20)];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"你好today！";
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    NSUserDefaults* userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.lijianfan"];
    NSString* nickName = [userDefault objectForKey:@"group.lijianfan.nickname"];
    if (nickName) {
        label.text = nickName;
    }
    
    // 跳转应用 在主应用添加 URL ：iOSWidgetApp:// 后可以增加扩展信息 比如 action = mine 然后可在 主应用的APP delegate - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 判别消息与操作
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(140, 10, 80, 40);
    [btn setTitle:@"进入APP" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openApp) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:btn];
    
}

#pragma mark - 在扩展中打开APP

- (void)openApp{
    
    [self.extensionContext openURL:[NSURL URLWithString:@"iOSWidgetApp://"] completionHandler:^(BOOL success) {
        NSLog(@"open url result:%d",success);
    }];
}

#pragma mark - 设置widget视图view的边界约束

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
//    {0, 47, 39, 0} 系统默认
    
    // 一般默认的View是从图标的右边开始的...如果你想变换,就要实现这个方法
//    return UIEdgeInsetsZero;
    return UIEdgeInsetsMake(0.0, 16.0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
