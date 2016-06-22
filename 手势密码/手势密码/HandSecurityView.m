//
//  HandSecurityView.m
//  手势密码
//
//  Created by Lone on 16/5/25.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "HandSecurityView.h"
/**
 const 定义只读的变量名，在其他类中不能声明同样的变量名
 */

CGFloat const btnH = 74.0;      /** <按钮高> */
CGFloat const btnW = 74.0;      /** <按钮宽> */
int const columnCount = 3;      /** <每行按钮数量> */
int const btnCount = 9;         /** <全部按钮数量> */
//CGFloat const viewY = 200;      /** <视图的Y坐标> */
#define Screen_With [[UIScreen mainScreen]bounds].size.width
#define Screen_Height [[UIScreen mainScreen]bounds].size.height

@interface HandSecurityView ()
{
    CGPoint _currentPoint;
}
@property (nonatomic, strong) NSMutableArray *selectButtons;

@end

@implementation HandSecurityView

- (NSMutableArray *)selectButtons{
    if (!_selectButtons) {
        _selectButtons = [NSMutableArray new];
    }
    return _selectButtons;
}

#pragma mark - frame 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addButtons];
    }
    return self;
}

#pragma mark - xib 初始化方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addButtons];
    }
    return self;
}

#pragma mark - 布局
- (void)addButtons
{
    CGFloat centerY = self.center.y;
    //行间距
    CGFloat lineSpace = (Screen_With - btnW * columnCount) / 4;
    for (int i = 0; i < btnCount; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnX = lineSpace + i%3 * (btnW + lineSpace);
        CGFloat btnY = centerY - 1.5 * btnH + i/3 * (btnH + lineSpace);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"]
                       forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"]
                       forState:UIControlStateSelected];
        btn.userInteractionEnabled = NO;
        /**
         *  设置tag值 手势密码其实就是一串数字校验
         */
        btn.tag = i;
        [self addSubview:btn];
    }
    self.frame = CGRectMake(0, 0, Screen_With, Screen_Height);
    
}

#pragma mark - 拿到触摸点
- (CGPoint)pointWithTouch:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

- (UIButton *)buttonWithPoint:(CGPoint)point
{
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}

#pragma mark - 绘制结束
- (void)drawEnd
{
    if ([self.delegate respondsToSelector:@selector(drawHandSecurityEndWithSecurity:)]) {
        NSMutableString *string = [NSMutableString new];
        for (int i = 0; i < self.selectButtons.count; i ++ ) {
            UIButton *btn = self.selectButtons[i];
            [string appendFormat:@"%ld",btn.tag];
        }
        [self.delegate drawHandSecurityEndWithSecurity:string];
    }
}

#pragma mark - 触摸回调方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point  = [self pointWithTouch:touches];
    UIButton *btn = [self buttonWithPoint:point];
    if (btn && btn.isSelected == NO) {
        btn.selected = YES;
        [self.selectButtons addObject:btn];
    }
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point  = [self pointWithTouch:touches];
    UIButton *btn = [self buttonWithPoint:point];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectButtons addObject:btn];
    }
    _currentPoint = point;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.selectButtons makeObjectsPerformSelector:@selector(setSelected:)
                                        withObject:0];
    [self drawEnd];
    [self.selectButtons removeAllObjects];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)drawRect:(CGRect)rect{
    // Drawing code
    if (self.selectButtons.count == 0) {
        return;
    }
    //创建画笔
    UIBezierPath *path = [UIBezierPath bezierPath];
    //线宽
    path.lineWidth = 8;
    //线的样式
    path.lineJoinStyle = kCGLineJoinRound;
    //颜色
    [[UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5] set];
    
    //遍历按钮
    for (int i = 0; i <self.selectButtons.count ; i++) {
        UIButton *btn = self.selectButtons[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        }else{
            [path addLineToPoint:btn.center];
        }
    }
    [path addLineToPoint:_currentPoint];
    [path stroke];
}

@end
