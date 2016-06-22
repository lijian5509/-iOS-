//
//  AlbumListViewController.m
//  多照片选取
//
//  Created by mini on 15/10/22.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "AlbumListViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoListViewController.h"
#import "UIView+ChangeAnimation.h"

#import "GetAssets.h"

@interface AlbumListViewController ()<GetAssetsDelegate>

@end

@implementation AlbumListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//- (NSMutableArray *)dataArray
//{
//    _dataArray = [NSMutableArray new];
//    return _dataArray;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"album"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"album"];
        cell.accessoryType = 1;
    }
    
    ALAssetsGroup *group = self.dataArray[indexPath.row];
    
    cell.imageView.image = [UIImage imageWithCGImage:group.posterImage];
    
    cell.textLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld 张照片", (long)[group numberOfAssets]];
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALAssetsGroup *group = self.dataArray[indexPath.row];
    GetAssets *get = [GetAssets shareInstance];
    get.assetsDelegate = self;
    [get getPhotos:group with:nil];
}

- (void)getAssetsSuccess:(NSMutableArray *)assets
{
    PhotoListViewController *photo = [PhotoListViewController new];
    
    [self.view transitionWithType:@"pageCurl" WithSubtype:nil ForView:self.navigationController.view];
    photo.dataArray = assets;
    photo.delegate = self.target;
    [self.navigationController pushViewController:photo animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
