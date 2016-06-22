//
//  ViewController.m
//  12431
//
//  Created by mini on 15/10/26.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "ViewController.h"
#import "LJFGetAssets.h"


@interface ViewController ()<LJFGetAssetsDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LJFGetAssets shareInstance].assetsDelegate = self;
    [[LJFGetAssets shareInstance] getAllAblumsOfPhotos];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)getAssetsSuccess:(NSMutableArray *)assets
{
    NSLog(@"李健凡-获取照片静态库");
}

- (void)getAssetGroupsSuccess:(NSMutableArray *)AssetGroups
{
     NSLog(@"李健凡-获取照片静态库");
}

- (void)getAssetsFailure:(NSError *)error
{
    NSLog(@"失败--------获取照片静态库");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
