//
//  WeatherManager.m
//  YangWeibo
//
//  Created by heyang on 16/9/30.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "WeatherManager.h"
#import "HYHTTPManager.h"

@implementation WeatherManager


-(void)fetchDataWithBlock: (FetchDataBlock)block{
    
    NSString *url = @"http://op.juhe.cn/onebox/weather/query";
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"cityname"] = @"杭州";
    parameter[@"key"] = @"cd6c6b4e3211bf91016fb438e247ea0f";
    [[HYHTTPManager sharedManager] GetRequestWithURLString:url Parameter:parameter success:^(id responseObject) {
        if (block) {
            block(responseObject);
        }
        
    } failure:^(NSError *error) {
         NSLog(@"begin---%@---end",error);
    }];
    
    
    
    
    
}

@end
