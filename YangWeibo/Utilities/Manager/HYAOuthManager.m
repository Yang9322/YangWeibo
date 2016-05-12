//
//  HYAOuthManager.m
//  YangWeibo
//
//  Created by He yang on 16/5/12.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYAOuthManager.h"
#import "HYHTTPManager.h"

const static  NSString *appSecret = @"dc5cfbe72a597e0ed50bf643d828aa26";

const static  NSString *appKey = @"268432808";

static NSString *URL = @"https://api.weibo.com/oauth2/authorize";

@implementation HYAOuthManager


+(instancetype)manager{
    
    
    return [[self alloc] init];
    
}

-(void)login{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"client_id"] = appKey;
    parameter[@"redirect_uri"] = @"http://baidu.com";
    [HYHTTPManager sharedManager].afManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [[HYHTTPManager sharedManager] GetRequestWithURLString:URL Parameter:parameter success:^( id responseObject) {
       
        HYDBAnyVar(responseObject);
        
    } failure:^(NSError *error) {
        HYDBAnyVar(error);
    }];
}

@end
