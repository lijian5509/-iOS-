//
//  LJFHttpRequest.m
//  豆瓣搜索
//
//  Created by mini on 15/10/12.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "LJFHttpRequest.h"

@implementation LJFHttpRequest

+ (NSInteger)netWorkStatus
{
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接状态及回调
    
    __block NSInteger state;
    
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                state = -1;
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                state = 0;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                state = 1;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                state = 2;
            }
                break;
                
            default:
                break;
        }
        
    }];
    
    return state;
}

+ (void)post:(NSString *)urlPath parameters:(NSDictionary *)parameters success:(void (^)(id))success fail:(void (^)())fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
        
        if (fail) {
            
            fail();
            
        }
        
    }];
}

+ (void)get:(NSString *)urlPath parameters:(NSDictionary *)parameters success:(void (^)(id))success fail:(void (^)())fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
        
        if (fail) {
            
            fail();
            
        }
        
    }];
}

+ (void)postJson:(NSString *)urlPath parameters:(NSDictionary *)parameters success:(void (^)(id))success fail:(void (^)())fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 设置请求格式
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 设置返回格式
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
        
        if (fail) {
            
            fail();
            
        }
        
    }];
}

+ (void)postUploadWithUrl:(NSString *)urlPath fileUrl:(NSURL *)fileURL success:(void (^)(id))success fail:(void (^)())fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //上传图片的本地路径和上传图片的文件名
        [formData appendPartWithFileURL:fileURL name:@"uploadFile"  error:nil];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (fail) {
            
            fail();
            
        }
    }];
}

+ (void)postUploadWithUrl:(NSString *)urlPath fileUrl:(NSURL *)fileURL fileName:(NSString *)fileName fileType:(NSString *)fileTye success:(void (^)(id))success fail:(void (^)())fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //上传图片的本地路径和上传图片的文件名
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" fileName:fileName mimeType:fileTye error:nil];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (fail) {
            
            fail();
            
        }
    }];
}

+ (void)stopRequest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.operationQueue cancelAllOperations];

}

@end
