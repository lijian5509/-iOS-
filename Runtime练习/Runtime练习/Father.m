//
//  Father.m
//  Runtime练习
//
//  Created by mini on 15/9/8.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "Father.h"
#import <objc/message.h>


@interface Father()
{
    NSString *_name;
}

- (void)sayHello;

@end

@implementation Father

- (id)init
{
    if (self = [super init]) {
        _name = @"李健凡";
        [_name copy];
        self.age = 24;
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"name:%@, age:%d",_name,self.age];
}

- (void)sayHello
{
    NSLog(@"%@ says hello to you!",_name);
}

- (void)syaGoodbye
{
    NSLog(@"%@ says goodbye to you !",_name);
}

//编码
- (void)encodeWithCoder:(NSCoder *)coder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Father class], &count);
    for (int i = 0; i <count; i ++) {
        Ivar ivar = ivars[i];
        
        //查看成员变量
        const char *name = ivar_getName(ivar);
        //归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [coder encodeObject:value forKey:key];
    }
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Father class], &count);
        for (int i = 0; i<count; i++) {
            //取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            
            //查看成员变量
            const char *name = ivar_getName(ivar);
            
            //解档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [coder decodeObjectForKey:key];
            
            //设置到成员变量身上
            [self setValue:value forKey:key];
        }
    }
    return self;
}

@end
