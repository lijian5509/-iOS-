//
//  MianViewController.h
//  豆瓣搜索
//
//  Created by mini on 15/10/12.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MianViewController : UIViewController

/**
 *  活动指示器
 */
@property (nonatomic,strong)AMTumblrHud *amTumblrHud;

@property (nonatomic,strong) NSMutableArray *dataArray;

/**
 *  创建导航栏标题视图
 */
- (void)addTitleViewWithTitle:(NSString *)title;

/**
 *  创建导航栏左右按钮
 *
 *  @param title     名称
 *  @param imageName 图片名
 *  @param target    目标对象
 *  @param action    目标行为
 *  @param isLeft    yes 左按钮 no 右按钮
 */
- (void)addBarButtonItemWithTitle:(NSString *)title
                        imageName:(NSString *)imageName
                           target:(id)target
                           action:(SEL)action
                           isLeft:(BOOL)isLeft;

/**
 *  数据请求
 *
 *  @param parameter 请求参数
 *  @param urlPath   请求路径
 */
- (void)requestDataWith:(NSDictionary *)parameter
                    and:(NSString *)urlPath
                 isPost:(BOOL)isPost;

/**
 *  请求成功,处理数据
 *
 *  @param responsData 返回的数据
 */
- (void)requestSuccessWith:(id)responsData;

/**
 *  请求失败
 */
- (void)requestFailed;


@end
