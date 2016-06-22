//
//  ViewController.h
//  代码布局等比适配
//
//  Created by mini on 15/9/10.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>
//
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTopMar;
- (IBAction)btnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLeftMar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelRightMar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHeightMar;

@end

