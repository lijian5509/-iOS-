//
//  HandSecurityView.h
//  手势密码
//
//  Created by Lone on 16/5/25.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HandSecurityViewDelegate <NSObject>

- (void)drawHandSecurityEndWithSecurity:(NSString *)security;

@end

@interface HandSecurityView : UIView

@property (nonatomic, weak) IBOutlet id <HandSecurityViewDelegate> delegate;


@end
