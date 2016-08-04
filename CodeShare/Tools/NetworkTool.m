//
//  NetworkTool.m
//  CodeShare
//
//  Created by 盛雪丽 on 16/8/3.
//  Copyright © 2016年 shengxueli. All rights reserved.
//

#import "NetworkTool.h"
#import <AFNetworking/AFNetworking.h>

#ifdef DEBUG //DEBUG 是程序默认存在的一个宏定义，我们平时运行都是在这种方式下
// 平时我们开发时候，都会用一个单独的测试环境
static NSString *baseUrl = @"http://10.30.152.134/PhalApi/Public/CodeShare/";
// 接口列表地址
// http://10.30.152.134/PhalApi/Public/CodeShare/listAllApis.php

#else

static NSString *baseUrl = @"https://www.1000phone.tk";
// 接口列表地址
// https://www.1000phone.tk/listAllApis.php

#endif


@implementation NetworkTool

// 为了防止我们的应用频繁获取网络数据的时候，创建的 sessionManager 过多，会大量消耗手机资源，我们最好封装为一个单例，获取网络数据只用到这一个对象。
+ (AFHTTPSessionManager *)sharedManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 用 AFNetworking 做网络请求时候，可以有一个小优化，可以缓存我们的地址。
        // 为什么这里算是一个优化?
        // 我们这里用 BaseUrl 生成 sessionManager 就相当于告诉 AFNetworking,以后我们请求数据，都是从这个服务器。那么 AFNetworking 会把这个服务器的地址缓存起来。
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        
        //	设置请求的超时时间
        //	设置请求的参数编码方式
        manager.requestSerializer.timeoutInterval = 30.0;
        //	manager.requestSerializer.
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/html", @"text/xml", @"application/json", nil];
    });
    return manager;
}

+ (void)getDataWithParameters:(NSDictionary *)parameters completeBlock:(void (^)(BOOL, id))complete {
    
    [[self sharedManager] POST:@"" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSNumber *serviceCode = [responseObject objectForKey:@"ret"];
        if ([serviceCode isEqualToNumber:@200]) {
            // 证明没有服务错误
            NSDictionary *retData = [responseObject objectForKey:@"data"];
            
            NSNumber *dataCode = [retData objectForKey:@"code"];
            if ([dataCode isEqualToNumber:@0]) {
                // 证明返回的数据没有错误
                NSDictionary *userInfo = [retData objectForKey:@"data"];
                // 先判断是否有完成请求的处理 block, 如果有，就传回解析到的数据
                if (complete) {
                    complete(YES, userInfo);
                }
            }else {
                NSString *dataMessage = [retData objectForKey:@"msg"];
                NSLog(@"%@", dataMessage);
                if (complete) {
                    complete(NO, dataMessage);
                }
            }
            
        }else {
            NSString *serviceMessage = [responseObject objectForKey:@"msg"];
            NSLog(@"%@", serviceMessage);
            if (complete) {
                complete(NO, serviceMessage);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        if (complete) {
            complete(NO, error.localizedDescription);
        }
    }];
}

@end
