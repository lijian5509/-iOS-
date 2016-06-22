//
//  TableViewController.m
//  获取相册
//
//  Created by mini on 15/7/2.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "TableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoListViewController.h"

@interface TableViewController ()
{
    NSMutableArray *_albums;
    ALAssetsLibrary *_assetLibrary;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _albums = [NSMutableArray new];
    [self getPhotos];
}

- (void)getPhotos{
    _assetLibrary = [[ALAssetsLibrary alloc]init];
    [_assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                 usingBlock:^(ALAssetsGroup *group, BOOL*stop) {
                                     NSLog(@"%@ %@",[group valueForProperty:ALAssetsGroupPropertyType],[group valueForProperty:ALAssetsGroupPropertyName]);
                                     // 遍历每个相册中的项ALAsset
                                     [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index,BOOL *stop) {
                                         // ALAsset的类型
                                         
                                         NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                                         NSLog(@"%@",assetType);
                                         if ([assetType isEqualToString:ALAssetTypePhoto]){
                                             //                                             [_albums addObject:result];
                                             CGImageRef poster = [group posterImage];
                                             // 对找到的图片进行操作
                                             UIImage *image =[UIImage imageWithCGImage:poster];
                                             if (image != nil){
                                                 NSDictionary *dic = @{[group valueForProperty:ALAssetsGroupPropertyName]:image};
                                                 [_albums insertObject:dic atIndex:0];
                                             } else {
                                                 NSLog(@"Failed to create the image.");
                                             }
                                             
                                             *stop = YES;
                                         }
                                     }];
                                     if (!group) {
                                         *stop = YES;
                                         dispatch_async(dispatch_get_main_queue(), ^(void){
                                             [self.tableView reloadData];
                                         });
                                     }
                                 }
                               failureBlock:^(NSError *error) {
                                   NSLog(@"Failed to enumerate the asset groups.");
                               }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    ALAsset *asset = _albums[indexPath.row];
//    CGImageRef thum = [asset thumbnail];
//    UIImage *image = [UIImage imageWithCGImage:thum];
    NSDictionary *dic = _albums[indexPath.row];
    cell.textLabel.text = [[dic allKeys] firstObject];
    UIImage *image = [[dic allValues] firstObject];
    NSLog(@"%@",[dic allValues]);
    if (image) {
        cell.imageView.image = image;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"morenxiangce"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoListViewController *VC = [PhotoListViewController new];
    NSDictionary *dic = _albums[indexPath.row];
    VC.title = [[dic allKeys] firstObject];
    [self.navigationController pushViewController:VC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

@end
