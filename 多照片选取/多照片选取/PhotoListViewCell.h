//
//  PhotoListViewCell.h
//  多照片选取
//
//  Created by mini on 15/10/22.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol PhotoListViewCellDelegate <NSObject>

- (void)cellSeletionStateChangeWithSource:(ALAsset *)asset andState:(BOOL)state;

@end

@interface PhotoListViewCell : UICollectionViewCell

@property (nonatomic, strong)UIButton *selectBtn;

@property (nonatomic, strong)UIImageView *photoImageView;

@property (nonatomic, weak) id<PhotoListViewCellDelegate> delegate;

@property (nonatomic, strong) ALAsset *asset;

@end
