//
//  HYHTTPManager.m
//  YangWeibo
//
//  Created by He yang on 16/5/11.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYHTTPManager.h"
#define CACHEPATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
static NSString *const kCacheDirectoryName = @"/YTCache";

@interface HYHTTPManager ()

@property (nonatomic,strong)NSDate *lastRequestDate;

@end

@implementation HYHTTPManager



static inline NSArray * AFQueryStringPairsFromKeyAndValue(NSString *key, id value) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
        for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id nestedValue = dictionary[nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[]", key], nestedValue)];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [mutableQueryStringComponents addObjectsFromArray:AFQueryStringPairsFromKeyAndValue(key, obj)];
        }
    } else {
        [mutableQueryStringComponents addObject:[NSString stringWithFormat:@"%@=%@",key,value]  ];
    }
    
    return mutableQueryStringComponents;
}

+ (instancetype)sharedManager{
    
    static HYHTTPManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HYHTTPManager alloc] init];
        manager.afManager = [AFHTTPSessionManager manager];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
//        responseSerializer.removesKeysWithNullValues = YES;
        manager.afManager.responseSerializer = responseSerializer;
        manager.afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/javascript",nil];
        manager.cachePath = [CACHEPATH stringByAppendingString:kCacheDirectoryName];
        NSError *error;
         NSLog(@"begin---%@---end",manager.cachePath);
        [[NSFileManager defaultManager] createDirectoryAtPath:manager.cachePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(300 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSFileManager defaultManager] removeItemAtPath:manager.cachePath error:nil];
        });
        if (error) NSAssert(0, @"文件初始化失败");
        
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
    
    [self PostRequestWithURLString:URLString Parameter:parameter isCache:NO success:success failure:failure];
    
}


-(void)PostRequestWithURLString:(NSString *)URLString Parameter:(NSDictionary *)parameter isCache:(BOOL)cache success:(void (^)(id))success failure:(void (^)(NSError *))failure{
   //先进行URL和参数拼接并转化成MD5
   
    NSArray *array = AFQueryStringPairsFromKeyAndValue(nil, parameter);
    
    NSString *query = [array componentsJoinedByString:@"&"];
    query = [URLString stringByAppendingString:query];
//    NSString *MD5 = [YTUtility md5HexDigest:query];
    
    NSString *filePath = [self.cachePath stringByAppendingString:@"/12345"];

     NSLog(@"begin---%@---end",filePath);
    //先判断缓存是否存在，存在直接回调successBlock
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    if (fileData.length){
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:fileData];
        success(obj);
        return;
    }
    
    //不存在请求数据
    [self.afManager POST:URLString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (cache) {
              NSData  *fileData = [NSKeyedArchiver archivedDataWithRootObject:responseObject];
              [fileData writeToFile:filePath atomically:NO];
            }
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    
}




@end
