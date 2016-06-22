//
//  KeyboardViewController.m
//  CustomKeyBoard
//
//  Created by mini on 15/9/28.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

/**
 UITextDocumentProxy协议内容如下：
 (void)dismissKeyboard;
 
 收键盘的方法
 
 - (void)advanceToNextInputMode;
 
 切换到下一输入法的方法
 
 *  //输入的上一个字符
 @property (nonatomic, readonly) NSString *documentContextBeforeInput;
 //即将输入的一个字符
 @property (nonatomic, readonly) NSString *documentContextAfterInput;
 //将输入的字符移动到某一位置
 - (void)adjustTextPositionByCharacterOffset:(NSInteger)offset;
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Perform custom UI setup here
//    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    
//    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
//    [self.nextKeyboardButton sizeToFit];
//    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:self.nextKeyboardButton];
//    
//    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
//    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
//    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];
    //设置数字键盘的UI
    for (int i = 0; i <10; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(20 + 45*(i%3), 20+45*(i/3), 40, 40);
        btn.backgroundColor = [UIColor purpleColor];
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        btn.tag = 101+i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    //创建切换键盘按钮
    UIButton *change = [UIButton buttonWithType:UIButtonTypeSystem];
    change.frame = CGRectMake(200, 20, 80, 40);
    [change setBackgroundColor:[UIColor blueColor]];
    [change setTitle:@"切换键盘" forState:UIControlStateNormal];
    [change addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:change];
    
    //创建删除按钮
    UIButton *delete = [UIButton buttonWithType:UIButtonTypeSystem];
    delete.frame = CGRectMake(200, 120, 80, 40);
    [delete setBackgroundColor:[UIColor blueColor]];
    [delete setTitle:@"delete" forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:delete];
    
}

- (void)delete
{
    if (self.textDocumentProxy.documentContextBeforeInput) {
        [self.textDocumentProxy deleteBackward];
    }
}

-(void)change
{
    [self advanceToNextInputMode];
}

- (void)btnClicked:(UIButton *)sender
{
    [self.textDocumentProxy insertText:[NSString stringWithFormat:@"%ld",sender.tag - 101]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
