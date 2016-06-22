//
//  UIViewController+HUD.h
//  豆瓣搜索
//
//  Created by mini on 15/10/12.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)


/**
 *  消息提示
 *
 *  @param title 消息内容
 */

- (void)showAlert:(NSString *)title;

/**
 *  消息提示 + 纵坐标偏移
 *
 *  @param title  消息内容
 *  @param offset 偏移坐标  上负 下正
 */

- (void)showAlert:(NSString *)title
          yOffset:(CGFloat)offset;

/**
 *  消息提示 文字颜色 + 背景颜色- (void)showAlert:(NSString *)title
 textColor:(UIColor)textColor
 backColor:(UIColor)backColor;
 *
 *  @param title     消息内容
 *  @param textColor 文字颜色
 *  @param backColor 背景颜色
 */

- (void)showAlert:(NSString *)title
        textColor:(UIColor *)textColor
        backColor:(UIColor *)backColor;


/**
 *  隐藏提示
 */
- (void)hideAlert:(id)object;

@end
