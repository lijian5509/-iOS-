//
//  UIViewController+ChangeAnimation.m
//  多照片选取
//
//  Created by mini on 15/10/22.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "UIView+ChangeAnimation.h"

#define DURATION 0.5

@implementation UIView (ChangeAnimation)

/*
 CATransition常用的属性如下：
 
 duration:设置动画时间
 
 type:稍后下面会详细的介绍运动类型
 
 subtype:和type匹配使用，指定运动的方向，下面也会详细介绍
 
 timingFunction ：动画的运动轨迹，用于变化起点和终点之间的插值计算,形象点说它决定了动画运行的节奏,比如是
 
 均匀变化(相同时间变化量相同)还是先快后慢,先慢后快还是先慢再快再慢.
 
 *  动画的开始与结束的快慢,有五个预置分别为(下同):
 
 *  kCAMediaTimingFunctionLinear            线性,即匀速
 
 *  kCAMediaTimingFunctionEaseIn            先慢后快
 
 *  kCAMediaTimingFunctionEaseOut           先快后慢
 
 *  kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
 
 *  kCAMediaTimingFunctionDefault           实际效果是动画中间比较快.
 
 typedef enum : NSUInteger {
 Fade = 1,                   //淡入淡出
 Push,                       //推挤
 Reveal,                     //揭开
 MoveIn,                     //覆盖
 Cube,                       //立方体
 SuckEffect,                 //吮吸
 OglFlip,                    //翻转
 RippleEffect,               //波纹
 PageCurl,                   //翻页
 PageUnCurl,                 //反翻页
 CameraIrisHollowOpen,       //开镜头
 CameraIrisHollowClose,      //关镜头
 CurlDown,                   //下翻页
 CurlUp,                     //上翻页
 FlipFromLeft,               //左翻转
 FlipFromRight,              //右翻转
 
 } AnimationType;
 */
#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];

    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}


@end
