//
//  LJFAdertisementView.h
//  广告栏
//
//  Created by mini on 15/11/9.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJFPageControl.h"


@protocol LJFAdertisementDelegate <NSObject>

/**
 *  轮播图片被选中
 *
 *  @param indexSite  选中位置
 *  @param linkStr    相关字段
 *
 */

- (void)LJFAdertisementViewBeSelected:(NSInteger)indexSite with:(NSString *)linkStr;

@end

@interface LJFAdertisementView : UIView<UIScrollViewDelegate>


@property (nonatomic, strong)LJFPageControl *pageControl;

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, weak) id<LJFAdertisementDelegate>delegate;


/**
 *  轮播图片被选中
 *
 *  @param frame  坐标
 *  @param imagesArray    图片数组
 *  @param isUrl  是网络图片还是本地图片
 *  @param linkStrs    每张照片对应的附件信息
 *  @param delegate  代理
 *  @paramtimeInterval 滚动时间间隔
 *  @return 返回一个UIScrollView
 */

- (UIView *)initWithFrame:(CGRect)frame
                 andImagesArray:(NSArray *)imagesArray
                          isUrl:(BOOL)isUrl
                       linkStrs:(NSArray *)linkStrs
                       delegate:(id)delegate
                   TimeInterval:(CGFloat)timeInterval;

@end
