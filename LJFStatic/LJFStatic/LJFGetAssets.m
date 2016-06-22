//
//  LJFGetAssets.m
//  LJFPhotoFrameWork
//
//  Created by mini on 15/10/26.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "LJFGetAssets.h"

@interface LJFGetAssets()

@property (nonatomic,strong) ALAssetsLibrary *assetLibrary;

@end

@implementation LJFGetAssets

+ (instancetype)shareInstance
{
    static id shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    _assetLibrary = [[ALAssetsLibrary alloc] init];
    if (!self) {
        return nil;
    }
    return self;
}

#pragma mark - 设置代理

- (void)setAssetsDelegate:(id<LJFGetAssetsDelegate>)assetsDelegate
{
    _assetsDelegate = assetsDelegate;
}

#pragma mark - 获取所有的照片资源

- (void)getAllAssets
{
    [self getAlbums:nil];
}

- (void)getAllAblumsOfPhotos
{
    [self getAlbums:[ALAssetsFilter allPhotos]];
}

- (void)getAllAblumsOfVideos
{
    [self getAlbums:[ALAssetsFilter allVideos]];
}

- (void)getPhotos:(ALAssetsGroup *)group with:(NSString *)ALAssetType
{
    NSMutableArray *dataArray = [NSMutableArray new];
    [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            NSString *assetType = [result valueForProperty:ALAssetPropertyType];
            if ([assetType isEqualToString:ALAssetPropertyType] || ALAssetType == nil) {
                [dataArray addObject:result];
            }
        }else {
            *stop = YES;
            [self.assetsDelegate getAssetsSuccess:dataArray];
        }
    }];
    
}

- (void)getAllPhotos
{
    NSMutableArray *dataArray = [NSMutableArray new];
    [_assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        if (group) {
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    [dataArray addObject:result];
                }
            }];
        }else {
            [self.assetsDelegate getAssetsSuccess:dataArray];
            *stop = YES;
        }
    } failureBlock:^(NSError *error) {
        [self.assetsDelegate getAssetsFailure:error];
    }];
}

- (void)getAlbums:(ALAssetsFilter *)alassetFilter
{
    NSMutableArray *dataArray = [NSMutableArray new];
    
    [_assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (alassetFilter != nil) {
            [group setAssetsFilter:alassetFilter];
        }
        if (group) {
            [dataArray addObject:group];
        }else {
            *stop = YES;
            [self.assetsDelegate getAssetGroupsSuccess:dataArray];
        }
    } failureBlock:^(NSError *error) {
        [self.assetsDelegate getAssetsFailure:error];
    }];
}


@end
