//
//  UINavigationBar+LJFNaviFix.h
//  LJFNavigationCV
//
//  Created by mini on 15/12/23.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (LJFNaviFix)


- (void)ljf_setBackGroundColor:(UIColor *)backgroundColor;

//设置透明度
- (void)ljf_setElementsAlpha:(CGFloat)alpha;

//设置导航栏纵坐标
- (void)ljf_setTranslationOffsetY:(CGFloat)transLationY;

//回复默认设置
- (void)ljf_reset;

@end
