//
//  PhotoDetailViewController.h
//  多照片选取
//
//  Created by MAC on 15/10/24.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoDetailViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@property (nonatomic, strong) ALAsset *asset;

@end
