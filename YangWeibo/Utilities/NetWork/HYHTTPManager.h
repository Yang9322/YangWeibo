//
//  HYHTTPManager.h
//  YangWeibo
//
//  Created by He yang on 16/5/11.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^success)(NSURLSessionDataTask * task,id responseObject);
typedef void (^failure)(NSURLSessionDataTask * task, NSError *error);
@interface HYHTTPManager : NSObject
@property (nonatomic,strong)AFHTTPSessionManager *afManager;

@property (nonatomic,copy)NSString *cachePath;

@property (nonatomic,assign)NSTimeInterval clearTime;
+ (instancetype)sharedManager;


- (void)GetRequestWithURLString: (NSString *)URLString Parameter:(NSDictionary *)parameter success:(void (^)(id  responseObject))success failure:(void (^)( NSError * error))failure;

- (void)PostRequestWithURLString: (NSString *)URLString Parameter:(NSDictionary *)parameter success:(void (^)( id  responseObject))success failure:(void (^)(NSError * error))failure;

//post缓存
- (void)PostRequestWithURLString: (NSString *)URLString Parameter:(NSDictionary *)parameter isCache:(BOOL)cache success:(void (^)( id  responseObject))success failure:(void (^)(NSError * error))failure;

@end
