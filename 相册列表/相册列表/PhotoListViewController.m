//
//  PhotoListViewController.m
//  相册列表
//
//  Created by mini on 15/9/14.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "PhotoListViewController.h"

#import "PhotoModel.h"
#import "PhotoLayout.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

{
    NSMutableArray *_albums;
    ALAssetsLibrary *_assetLibrary;
    UICollectionView *_collectionView;
}


@end

@implementation PhotoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _albums = [NSMutableArray new];
    [self uiconFig];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.title.length == 0) {
        [self getAlbum];
    }else{
        [self getPhotoes];
    }
}
#pragma mark - 获取所有相片
- (void)getAlbum{
    [_albums removeAllObjects];
    _assetLibrary = [[ALAssetsLibrary alloc] init];
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        // 遍历所有相册
        [_assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                     usingBlock:^(ALAssetsGroup *group, BOOL*stop) {
                                         if ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupLibrary) {
                                             // 遍历每个相册中的项ALAsset
                                             self.navigationItem.title = [group valueForProperty:ALAssetsGroupPropertyName];
                                             NSLog(@"%@",self.navigationItem.title);
                                             [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index,BOOL *stop) {
                                                 // ALAsset的类型
                                                 NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                                                 if ([assetType isEqualToString:ALAssetTypePhoto]){
                                                     [_albums addObject:result];
                                                 }
                                             }];
                                             *stop = YES;
                                             dispatch_async(dispatch_get_main_queue(), ^(void){
                                                 [_collectionView reloadData];
                                             });
                                         }
                                     }
                                   failureBlock:^(NSError *error) {
                                       NSLog(@"Failed to enumerate the asset groups.");
                                   }];
        
    });
    
}

- (void)getPhotoes{
    [_albums removeAllObjects];
    _assetLibrary = [[ALAssetsLibrary alloc] init];
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        [_assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            __block BOOL isStop = NO;
            if ([self.title compare:[group valueForProperty:ALAssetsGroupPropertyName]] == NSOrderedSame) {
                isStop = YES;
                [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    if (result) {
                        NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                        if ([assetType isEqualToString:ALAssetTypePhoto]){
                            
                            [_albums addObject:result];
                        }
                    }
                }];
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [_collectionView reloadData];
                });
            }
            if (isStop) {
                *stop = YES;
            }
        } failureBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    });
    
}

- (void)uiconFig{
    PhotoLayout *layout = [PhotoLayout new];
    layout.images = _albums;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor redColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _albums.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    ALAsset *asset = _albums[indexPath.row];
    CGImageRef thum = [asset thumbnail];
    UIImage *image = [UIImage imageWithCGImage:thum];
    imageView.image = image;
    [cell.contentView addSubview:imageView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
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
