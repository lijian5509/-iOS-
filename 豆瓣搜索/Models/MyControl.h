//
//  MyControl.h
//  豆瓣搜索
//
//  Created by mini on 15/10/12.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MyControl : NSObject

//这个类的功能就是创建label 和button
+ (UILabel *)creatLabelWithFrame:(CGRect)frame
                            text:(NSString *)text ;
//创建button
+ (UIButton *)creatButtonWithFrame:(CGRect)frame
                            target:(id)target
                               sel:(SEL)sel
                               tag:(NSInteger)tag
                             image:(NSString *)name
                             title:(NSString *)title;
//创建UIImageView
//选择加载方式
+ (UIImageView *)creatImageViewWithFrame:(CGRect)frame
                               imageName:(NSString *)name
                                 isCache:(BOOL)cache;
//创建UITextField
+ (UITextField *)creatTextFieldWithFrame:(CGRect)frame
                             placeHolder:(NSString *)string
                                delegate:(id <UITextFieldDelegate>)delegate
                                     tag:(NSInteger)tag;

@end
