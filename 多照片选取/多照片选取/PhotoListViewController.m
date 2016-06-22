//
//  PhotoListViewController.m
//  多照片选取
//
//  Created by mini on 15/10/22.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "PhotoListViewController.h"
#import "PhotoListViewCell.h"
#import "PhotoDetailViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface PhotoListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,PhotoListViewCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PhotoListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(savePhotos:)];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)savePhotos:(UIBarButtonItem *)barItem
{
    [self.delegate photoListDidSelectedPhotos:self.sourceArray];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
       
        layout.itemSize = CGSizeMake(90 , 90);
        layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        layout.minimumLineSpacing = 10;//cell行距
        layout.minimumInteritemSpacing = 10;//间距
//        layout.itemSize = CGSizeMake(ScreenWidth / 4, ScreenWidth / 4 + 10);//item的大小
//        
//        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        
//        layout.minimumInteritemSpacing = 0;
//        
//        layout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        
        [_collectionView registerClass:[PhotoListViewCell class] forCellWithReuseIdentifier:@"photo"];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
    }
    return _collectionView;
}

- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray new];
    }
    return _sourceArray;
}

#pragma mark - UICollectionDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    cell.delegate = self;
    
    cell.asset = self.dataArray[indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableView = headerView;
    }
    return reusableView;
}

//返回头headerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={ScreenWidth,0};
    return size;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 90);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoDetailViewController *photoD = [PhotoDetailViewController new];
    
    photoD.asset = self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:photoD animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cellSeletionStateChangeWithSource:(ALAsset *)asset andState:(BOOL)state
{
    if (state) {
        [self.sourceArray addObject:asset];
    }else{
        [self.sourceArray removeObject:asset];
    }
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
