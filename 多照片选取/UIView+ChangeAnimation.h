//
//  UIViewController+ChangeAnimation.h
//  多照片选取
//
//  Created by mini on 15/10/22.
//  Copyright © 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ChangeAnimation)


#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view;


#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition;


@end
