//
//  LJFPageControl.m
//  广告栏
//
//  Created by mini on 15/11/9.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "LJFPageControl.h"

@implementation LJFPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    
    _activeColor = [UIColor whiteColor];
    
    _unActiveColor = [UIColor clearColor];
    
    return self;
}

- (void)setActiveColor:(UIColor *)activeColor
{
    _activeColor = activeColor;
}

- (void)setUnActiveColor:(UIColor *)unActiveColor
{
    _unActiveColor = unActiveColor;
}

//此方法设置当前页的小点点的颜色

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self updateDots];
}

- (void)updateDots
{
    for (int i = 0; i <[self.subviews count]; i++) {
        
        UIImageView *dot = [self.subviews objectAtIndex:i];
        
//        CGSize size = dot.frame.size;
        
        if (i == self.currentPage) {
            
            [dot setBackgroundColor:_activeColor];
            
        }else{
            
            [dot setBackgroundColor:_unActiveColor];
            
            dot.layer.borderWidth = 0.5;
            
            dot.layer.borderColor = _activeColor.CGColor;
            
        }
    }
}


@end
