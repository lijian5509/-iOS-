//
//  LJFHttpRequest.h
//  豆瓣搜索
//
//  Created by mini on 15/10/12.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJFHttpRequest : NSObject

/**
 *  检测网络状态
 */
+ (NSInteger)netWorkStatus;

/**
 *  post请求
 *
 *  @param urlPath    请求路径
 *  @param parameters 请求参数
 *  @param success    请求成功block
 *  @param fail       请求失败结果
 */
+ (void)post:(NSString *)urlPath
  parameters:(NSDictionary *)parameters
     success:(void (^)(id responseObject))success
        fail:(void (^)())fail;

/**
 *  get请求
 *
 *  @param urlPath    请求路径
 *  @param parameters 请求参数
 *  @param success    请求成功block
 *  @param fail       请求失败结果
 */
+ (void)get:(NSString *)urlPath
  parameters:(NSDictionary *)parameters
     success:(void (^)(id responseObject))success
        fail:(void (^)())fail;

/**
 *  json 方式post提交数据
 *
 *  @param urlPath    请求路径
 *  @param parameters 请求参数
 *  @param success    请求成功block
 *  @param fail       请求失败结果
 */
+ (void)postJson:(NSString *)urlPath
 parameters:(NSDictionary *)parameters
    success:(void (^)(id responseObject))success
       fail:(void (^)())fail;


/**
 *  文件上传
 *
 *  @param urlPath
 *  @param fileURL  需要上传的本地文件的URL
 *  @param fileName 文件在服务器保存的名字
 *  @param fileTye  文件类型
 */
+ (void)postUploadWithUrl:(NSString *)urlPath
                  fileUrl:(NSURL *)fileURL
                 fileName:(NSString *)fileName
                 fileType:(NSString *)fileTye
                  success:(void (^)(id responseObject))success
                     fail:(void (^)())fail;

/**
 *文件上传,文件名由服务器端决定
 *urlStr:    需要上传的服务器url
 *fileURL:   需要上传的本地文件URL
 */

+ (void)postUploadWithUrl:(NSString *)urlPath
                  fileUrl:(NSURL *)fileURL
                  success:(void (^)(id responseObject))success
                     fail:(void (^)())fail;


/**
 *  取消请求
 */
+ (void)stopRequest;

@end
