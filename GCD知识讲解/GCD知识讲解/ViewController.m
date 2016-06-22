//
//  ViewController.m
//  GCD知识讲解
//
//  Created by mini on 15/9/9.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark - 延时追加任务
    
//    1.定时器
//    2.- (void)performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay;
//    3 void  dispatch_after(dispatch_time_t when, dispatch_queue_t queue,  dispatch_block_t block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"延迟3秒后执行block内容");
    });
    
#pragma mark - 数据存取的线程安全问题
    
    /**
     *  多线程编程是，总会遇到数据的竞争与线程的安全问题。通过程序手动控制难度很大
     *  对数据进行读得时候可以多任务进行，二队任务修改的时候必须只能一个任务在操作
     */
    
    dispatch_queue_t queue = dispatch_queue_create("oneQqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"read1:%d",i);
        }
    });
    dispatch_async(queue, ^{
        
        for (int i = 0; i<5; i++) {
            NSLog(@"read2:%d",i);
        }
        
    });
    
    // 此处进行写操作
    /**
     *  下面这个函数在加入队列时不会执行，会等待已经开始的异步执行全部完成后再执行，并且在执行时，会阻塞当前线程，执行完成后，其他任务重新进行异步操作
     */
    
    dispatch_barrier_async(queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"write:%d",i);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"read4:%d",i);
        }
    });
    dispatch_async(queue, ^{
        
        for (int i = 0; i<5; i++) {
            NSLog(@"read5:%d",i);
        }
        
    });
    
}

#pragma mark - GCD 单例

//一般单例

//+ (instancetype)shared
//{
//    static ViewController *obj;
//    if (obj == nil) {
//        obj = [[self alloc]init];
//    }
//    return obj;
//}


+ (instancetype)shared
{
    static ViewController *obj;
    //dispatch_once_t 保证对象只创建一次
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        obj = [[self alloc]init];
    });
    return obj;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
