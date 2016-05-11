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


+ (instancetype)sharedManager;


- (void)GetRequestWithURLString: (NSString *)URLString Parameter:(NSDictionary *)parameter success:(void (^)(NSURLSessionDataTask *task, id  responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError * error))failure;

- (void)PostRequestWithURLString: (NSString *)URLString Parameter:(NSDictionary *)parameter success:(void (^)(NSURLSessionDataTask *task, id  responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError * error))failure;

@end
