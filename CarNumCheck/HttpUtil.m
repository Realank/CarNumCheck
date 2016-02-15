//
//  HttpUtil.m
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "HttpUtil.h"


@implementation HttpUtil

+ (AFHTTPRequestOperation *)send_request:(NSString *)request post:(BOOL)post params:(id)params
                               completed:(KKSucceedBlock)succeed failed:(KKFailedBlock)failed {
    
    if ( [params isKindOfClass:NSDictionary.class] ) {
        NSMutableString *param = [NSMutableString stringWithCapacity:1];
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [param appendFormat:@"%@=%@", key, obj];
            [param appendString:@"&"];
        }];
        NSLog(@"Request URL & params : \n\n%@?%@", request, param);
    }
    else {
        NSLog(@"Request URL : \n\n%@", request);
    }
    
    // 创建request请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置连接请求超时时间
    manager.requestSerializer.timeoutInterval = 10.0f;
    // 申明返回的结果是json类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 解析加密的HTTPS网络请求数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html", nil];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=gb18030" forHTTPHeaderField:@"Content-Type"];
    
    [manager.requestSerializer setValue:@"http://www.tjits.cn/wfcx/vehiclelist____aacccccccccc.asp" forHTTPHeaderField:@"Referer"];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    AFHTTPRequestOperation *operation = nil;
    // post请求
    if ( post ) {
        
        operation = [manager POST:request parameters:params
                          success:^( AFHTTPRequestOperation *operation, id responseObject ) {
                              if ( succeed ) {
                                  succeed(responseObject, operation.responseData, operation.responseString);
                              }
                          }
                          failure:^( AFHTTPRequestOperation *operation, NSError *error ) {
                              if ( failed ) {
                                  failed( error, nil );
                              }
                          }];
    }
    else {
        
        operation = [manager GET:request parameters:params
                         success:^( AFHTTPRequestOperation *operation, id responseObject ) {
                             if ( succeed ) {
                                 succeed(responseObject, operation.responseData, operation.responseString);
                             }
                         }
                         failure:^( AFHTTPRequestOperation *operation, NSError *error ) {
                             if ( failed ) {
                                 failed( error, nil );
                             }
                         }];
    }
    
    //DLog(@"HTTP HEADER : ", manager.requestSerializer.allHTTPHeaderFields);
    
    //设置返回数据的解析方式
    //operation.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:kNilOptions];
    return operation;
}


@end
