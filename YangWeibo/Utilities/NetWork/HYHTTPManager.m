//
//  HYHTTPManager.m
//  YangWeibo
//
//  Created by He yang on 16/5/11.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYHTTPManager.h"

@interface HYHTTPManager ()



@end

@implementation HYHTTPManager


+ (instancetype)sharedManager{
    
    static HYHTTPManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HYHTTPManager alloc] init];
        manager.afManager = [AFHTTPSessionManager manager];
        manager.afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
        
    });
    
    return manager;
}

-(void)GetRequestWithURLString:(NSString *)URLString Parameter:(NSDictionary *)parameter success:(void (^)( id))success failure:(void (^)( NSError *))failure{
    
    [self.afManager GET:URLString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

-(void)PostRequestWithURLString:(NSString *)URLString Parameter:(NSDictionary *)parameter success:(void (^)( id))success failure:(void (^)( NSError *))failure{
    
    [self.afManager POST:URLString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}




@end
