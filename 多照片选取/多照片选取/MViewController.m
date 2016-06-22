//
//  ViewController.m
//  多照片选取
//
//  Created by mini on 15/10/21.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "MViewController.h"
#import "getAssets.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "AlbumListViewController.h"
#import "UIView+ChangeAnimation.h"
#import "PhotoListViewController.h"

@interface MViewController ()<GetAssetsDelegate,PhotoSelectedDelegate>

@property (nonatomic, strong)NSMutableArray *albumArray;

@end

@implementation MViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)getAssetGroupsSuccess:(NSMutableArray *)AssetGroups
{
    NSLog(@"获取到%lu个照片集-------",(unsigned long)[AssetGroups count]);
    
    ALAssetsGroup *group = AssetGroups.lastObject;
    NSInteger count = [group numberOfAssets];
    
    NSLog(@"第一个照片集有%ld资源",(long)count);
    
    AlbumListViewController *album = [AlbumListViewController new];
    
    [self.view transitionWithType:kCATransitionReveal WithSubtype:nil ForView:self.navigationController.view];
    
    album.target = self;
    album.dataArray = AssetGroups;
    
    [self.navigationController pushViewController :album animated:YES];
}

- (void)getAssetsSuccess:(NSMutableArray *)assets
{
    NSLog(@"获取到%lu个照片-------",(unsigned long)[assets count]);
}

- (void)getAssetsFailure:(NSError *)error
{
    NSLog(@"error 提取照片信息错误 ------ %@",[error localizedDescription]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClicked:(UIButton *)sender {
    
    GetAssets *assets = [GetAssets shareInstance];
    assets.assetsDelegate = self;
    
    switch (sender.tag) {
        case 101:
        {
            [assets getAllAssets];
        }
            break;
            
        case 102:
        {
            [assets getAllAblumsOfPhotos];
        }
            break;
            
        case 103:
        {
            [assets getAllAblumsOfVideos];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)photoListDidSelectedPhotos:(NSMutableArray *)photosArray
{
    
}

@end
