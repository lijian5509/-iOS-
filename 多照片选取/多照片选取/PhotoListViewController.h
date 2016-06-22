//
//  PhotoListViewController.h
//  多照片选取
//
//  Created by mini on 15/10/22.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoSelectedDelegate <NSObject>

- (void)photoListDidSelectedPhotos:(NSMutableArray *)photosArray;

@end

@interface PhotoListViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, weak) id<PhotoSelectedDelegate>delegate;

@end
