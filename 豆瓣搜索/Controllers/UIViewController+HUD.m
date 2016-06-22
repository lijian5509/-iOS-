//
//  UIViewController+HUD.m
//  豆瓣搜索
//
//  Created by mini on 15/10/12.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "UIViewController+HUD.h"

#define AlerBackColor [UIColor blackColor];   //默认背景色

#define AlerViewHeight 50.0

@implementation UIViewController (HUD)

- (void)showAlert:(NSString *)title
{
    
    UILabel *label = [self getAlertLabel:title];
    
    label.center = CGPointMake(Screen_Width / 2, (Screen_Height - 40) - AlerViewHeight/2);
    
    [self.view addSubview:label];
    
    [self performSelector:@selector(hideAlert:) withObject:label afterDelay:2.0];
    
}

- (void)showAlert:(NSString *)title yOffset:(CGFloat)offset
{
    UILabel *label = [self getAlertLabel:title];
    
    label.center = CGPointMake(Screen_Width / 2, Screen_Height - 40 - AlerViewHeight/2 + offset);
    
    [self.view addSubview:label];
    
    [self performSelector:@selector(hideAlert:) withObject:label afterDelay:2.0];
}

- (void)showAlert:(NSString *)title textColor:(UIColor *)textColor backColor:(UIColor *)backColor
{
    UILabel *label = [self getAlertLabel:title];
    
    label.center = CGPointMake(Screen_Width / 2, Screen_Height - 40 - AlerViewHeight/2 );
    
    label.textColor = textColor;
    
    label.backgroundColor = backColor;
    
    [self.view addSubview:label];
    
    [self performSelector:@selector(hideAlert:) withObject:label afterDelay:2.0];
}

- (void)hideAlert:(id)object
{
    if ([object isKindOfClass:[UILabel class]]) {
        
        UILabel *label = (UILabel *)object;
        
        [label removeFromSuperview];
        
        label = nil;
    }
}

- (UILabel *)getAlertLabel:(NSString *)title
{
    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, AlerViewHeight)];
    
    if (titleSize.width > 280) {
        titleSize.width = 280;
    }
    
    if (titleSize.width < 80) {
        titleSize.width = 80;
    }
    
    UILabel *label = [MyControl creatLabelWithFrame:CGRectMake(10, 0, titleSize.width, AlerViewHeight) text:title];
    
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    label.textColor = [UIColor whiteColor];
    
    UILabel *backLabel = [MyControl creatLabelWithFrame:CGRectMake(0, 0, titleSize.width+20, AlerViewHeight) text:nil];
    
    backLabel.backgroundColor = AlerBackColor;
    
    backLabel.textAlignment = NSTextAlignmentCenter;
    
    backLabel.layer.cornerRadius = AlerViewHeight/2;
    
    backLabel.layer.masksToBounds = YES;
    
    [backLabel addSubview:label];
    
    return backLabel;
}


@end
