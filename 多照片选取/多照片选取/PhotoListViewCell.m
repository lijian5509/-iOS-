//
//  PhotoListViewCell.m
//  多照片选取
//
//  Created by mini on 15/10/22.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "PhotoListViewCell.h"

@implementation PhotoListViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoImageView];
        [self.contentView addSubview:self.selectBtn];
    }
    return self;
}

- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(70, 0, 20, 20);
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"select_s"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"select_n"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _selectBtn;
}

- (UIImageView *)photoImageView
{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc]initWithFrame:self.contentView.frame];
    }
    return _photoImageView;
}

- (void)btnClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.delegate cellSeletionStateChangeWithSource:self.asset andState:YES];
    }else{
        [self.delegate cellSeletionStateChangeWithSource:self.asset andState:NO];
    }
}

- (void)setAsset:(ALAsset *)asset
{
    _asset = asset;
    self.photoImageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
}

@end
