//
//  HYWeiboViewModel.m
//  YangWeibo
//
//  Created by He yang on 16/5/18.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYWeiboViewModel.h"
#define kAccessToken @"2.00T_vQ8D07d_KS3f1edf79cdW_mEXC"
static NSString *redirectURL = @"http://baidu.com";
@implementation HYWeiboViewModel


-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}


- (void)fetchData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"] = kAccessToken;
    
    [[HYHTTPManager sharedManager] GetRequestWithURLString:@"https://api.weibo.com/2/statuses/public_timeline.json" Parameter:params success:^(id responseObject) {
        
       
        
        
    } failure:^(NSError *error) {
        
        
    }];
}

@end
