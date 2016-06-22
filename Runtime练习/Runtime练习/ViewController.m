//
//  ViewController.m
//  Runtime练习
//
//  Created by mini on 15/9/8.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Father.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self controlMember];
    [self controlMethod];
    [self tryMethodExchange];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 1.获取当前应用的所有成员变量

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    //状态栏是由当前的APP控制的，首先获取当前的APP
//    UIApplication *app = [UIApplication sharedApplication];
//    
//    //遍历当前的APP的所有属性，找到关于状态栏的
//    unsigned int outCount = 0;
//    
//    Ivar *ivars = class_copyIvarList(app.class, &outCount);
//    
//    for (int i = 0; i <outCount; i++) {
//        Ivar ivar = ivars[i];
//        printf("\n%s",ivar_getName(ivar));
//    }
//}

#pragma mark - 2.获取状态栏的所有成员变量 通过kvc(键值编码)
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    //状态栏是由当前的APP控制的，首先获取当前的APP
//    UIApplication *app = [UIApplication sharedApplication];
//
//    id statusBar = [app valueForKeyPath:@"statusBar"];
//    
//    //遍历当前的APP的所有属性，找到关于状态栏的
//    unsigned int outCount = 0;
//
//    Ivar *ivars = class_copyIvarList([statusBar class], &outCount);
//
//    for (int i = 0; i <outCount; i++) {
//        Ivar ivar = ivars[i];
//        printf("\n%s",ivar_getName(ivar));
//    }
//}

#pragma mark - 3.获取状态栏的foregroundview成员，表示当前显示的视图 通过kvc(键值编码)取出里面的所有子视图

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    //状态栏是由当前的APP控制的，首先获取当前的APP
//    UIApplication *app = [UIApplication sharedApplication];
//
//    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
//    
//    for (id child in children) {
//        NSLog(@"--%@",[child class]);
//    }
//    
//}

#pragma mark - 4.遍历数组，取出用于显示网络状态的视图，并遍历其内部的所有成员变量

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    //状态栏是由当前的APP控制的，首先获取当前的APP
//    UIApplication *app = [UIApplication sharedApplication];
//    
//    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
//    
//    for (id child in children) {
//        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
//            // 遍历
//            unsigned int outCount = 0;
//            Ivar *ivars = class_copyIvarList([child class], &outCount);
//            for (int i = 0 ; i < outCount ; i ++) {
//                Ivar ivar = ivars[i];
//                printf("\n%s",ivar_getName(ivar));
//            }
//        }
//    }
//    
//}


#pragma mark - 5.通过kvc，取出dataNetWorkType
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    //状态栏是由当前的APP控制的，首先获取当前的APP
//    UIApplication *app = [UIApplication sharedApplication];
//    
//    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
//    
//    for (id child in children) {
//        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
//            // 遍历
//            id type = [child valueForKeyPath:@"dataNetworkType"];
//            NSLog(@"_dataNetworkType class is %@,value is %@",[type class],type);
//           
//        }
//    }
//    
//}

#pragma mark - 6.dataNetWorkType(获取当前网络状态) 0-无网络 1-2g 2-3g 3-4g 5-wifi


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //状态栏是由当前的APP控制的，首先获取当前的APP
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    
    int type = 0;
    
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            // 遍历
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            
        }
    }
    
    NSLog(@"当前网络状态 ---- %d",type);
    
}


#pragma mark - 控制变量

- (void)controlMember
{
    
    /**
     class_copyIvarList：获取类的所有属性变量，count记录变量的数量IVar是runtime声明的一个宏，是实例变量的意思,instance variable，在runtime中定义为 typedef struct objc_ivar *Ivari
     
     var_getName：将IVar变量转化为字符串
     
     ivar_getTypeEncoding：获取IVar的类型
     */
    Father *father = [[Father alloc]init];
    NSLog(@"before runtime:%@",[father description]);
    
    unsigned int count = 0;
    Ivar *members = class_copyIvarList(father.class, &count);
    for (int i = 0; i <count; i++) {
        Ivar var = members[i];
        const char *memberName = ivar_getName(var);
        const char *memberType = ivar_getTypeEncoding(var);
        NSLog(@"%s----------%s",memberName,memberType);
    }
    
    Ivar m_name = members[0];
    object_setIvar(father, m_name, @"王帅");
    NSLog(@"after runtime:%@",[father description]);
    
}

#pragma mark - 控制方法

- (void)controlMethod
{
    /**
     *   Method：runtime声明的一个宏，表示一个方法，typedef struct objc_method *Method;
     
     class_copyMethodList：获取所有方法
     
     method_getName：读取一个Method类型的变量，输出我们在上层中很熟悉的SEL
     */
    [self tryAddingFunction];
    unsigned int count = 0;
    Method *memberFuncs = class_copyMethodList([Father class], &count);
    for (int i = 0; i <count; i ++) {
        SEL name = method_getName(memberFuncs[i]);
        NSString *methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"member method:%@",methodName);
    }
    Father *father = [[Father alloc]init];
//    [father method:10 :@"ljf"];
    [father performSelector:@selector(method::) withObject:@10 withObject:@"lijianfan"];
}

- (void)tryAddingFunction
{
//    "i@:i@" (@:前返回值类型 整形 @: 后参数)
    class_addMethod([Father class], @selector(method::), (IMP)myAddingFunction, "i@:i@");
}

//具体的实现，即IMP 所指向的方法
int myAddingFunction(id self, SEL _cmd, NSNumber *num, NSString *str)
{
    NSLog(@"%d",num.intValue);
    NSLog(@"i am added function");
    return 10;
}

#pragma mark - 方法交换
- (void)tryMethodExchange
{
    Method method1 = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method method2 = class_getInstanceMethod([NSString class], @selector(uppercaseString));
    
    method_exchangeImplementations(method1, method2);
    NSLog(@"lowcase of LI jianfan: %@",[@"LI jianfan" lowercaseString]);
    NSLog(@"uppercase of LI jianfan: %@",[@"LI jianfan" uppercaseString]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
