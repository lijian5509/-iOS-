//
//  PhotoLayout.m
//  获取相册
//
//  Created by mini on 15/7/2.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "PhotoLayout.h"
#import "PhotoModel.h"

@implementation PhotoLayout

//用来返回整个collectionView的大小

- (CGSize)collectionViewContentSize{
    if (self.images.count % 3 != 0){
       return CGSizeMake(320, (self.images.count/3+1)*105+5);
    }
    return CGSizeMake(320, self.images.count/3*105+5);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    for (int i = 0; i<indexPath.row+1; i++) {
        int j = i % 3;
        attr.center = CGPointMake(105*(j+1)-50, i/3*105+55);
    }
    attr.size = CGSizeMake(100, 100);
    return attr;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        [array addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
        
    }
    return array;
}

@end
