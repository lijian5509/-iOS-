//
//  ViewController.m
//  相册列表
//
//  Created by mini on 15/9/14.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *groupArray;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.groupArray = [NSMutableArray new];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"进入相册列表" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 160, 40);
    btn.center = self.view.center;
    
    [btn addTarget:self action:@selector(showAlbum) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    //获取相册列表
//    [self getPhotoListFromMobile];
//    [self.view addSubview:self.tableView];
}

- (void)showAlbum
{
    [self.navigationController pushViewController:[TableViewController new] animated:YES];
}

#pragma mark - 创建表格式图
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

#pragma mark - 获取相册列表
- (void)getPhotoListFromMobile
{
    //WKwebview
    //ALAssetsLibrary：代表整个PhotoLibrary，我们可以生成一个它的实例对象，这个实例对象就相当于是照片库的句柄。
    //ALAssetsGroup：照片库的分组，我们可以通过ALAssetsLibrary的实例获取所有的分组的句柄
    
    ALAssetsLibrary *assetsLibrary = [ALAssetsLibrary new];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            //ALAsset：一个ALAsset的实例代表一个资产，也就是一个photo或者video，我们可以通过他的实例获取对应的subnail或者原图等等。
            //判断对象的类型
            NSString *assetType = [result valueForProperty:ALAssetPropertyType];
            if ([assetType isEqualToString:ALAssetTypePhoto]) {
                //                                             [_albums addObject:result];
                CGImageRef poster = [group posterImage];
                // 对找到的图片进行操作
                UIImage *image =[UIImage imageWithCGImage:poster];
                if (image != nil){
                    NSDictionary *dic = @{[group valueForProperty:ALAssetsGroupPropertyName]:image};
                    [_groupArray insertObject:dic atIndex:0];
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

    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
       
    } failureBlock:^(NSError *error) {
        NSLog(@"获取照片列表失败");
    }];
    
   
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groupArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    NSDictionary *dic = _groupArray[indexPath.row];
    cell.textLabel.text = [[dic allKeys] firstObject];
    UIImage *image = [[dic allValues] firstObject];
    NSLog(@"%@",[dic allValues]);
    if (image) {
        cell.imageView.image = image;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"morenxiangce"];
    }
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)barButtonItemClicked:(UIBarButtonItem *)sender {
}
@end
