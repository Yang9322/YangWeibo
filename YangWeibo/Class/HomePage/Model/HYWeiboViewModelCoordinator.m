//
//  HYWeiboViewModel.m
//  YangWeibo
//
//  Created by He yang on 16/5/18.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYWeiboViewModelCoordinator.h"
#import "NSObject+YYModel.h"
#import "MJExtension.h"

#define kAccessToken @"2.00T_vQ8D07d_KS3f1edf79cdW_mEXC"
static NSString *redirectURL = @"http://baidu.com";

@interface HYWeiboViewModelCoordinator()

@property (nonatomic,strong)dispatch_queue_t handleKVOQueue;

@end
@implementation HYWeiboViewModelCoordinator


-(instancetype)init{
    if (self = [super init]) {
        
        _modelArray = [NSMutableArray array];
        NSString *queueName = [NSString stringWithFormat:@"com.heyang.%@",[NSUUID UUID].UUIDString];
        _handleKVOQueue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)fetchData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"] = kAccessToken;
    
    [[HYHTTPManager sharedManager] GetRequestWithURLString:@"https://api.weibo.com/2/statuses/public_timeline.json" Parameter:params success:^(id responseObject) {
        NSAssert(responseObject[@"statuses"], @"Must have useful data!");

        dispatch_async(_handleKVOQueue, ^{
  
            [self handleResponseData:responseObject[@"statuses"]];
      
        });
       
 
        
    } failure:^(NSError *error) {
        
        
    }];
}




- (NSMutableArray *)middleArray {
    return [self mutableArrayValueForKey:NSStringFromSelector(@selector(modelArray))];
}


- (void)handleResponseData:(id)response{
    NSArray *modelArray = [HYWeiboModel mj_objectArrayWithKeyValuesArray:response];
    //进行去重
    
    HYWeiboModel *lastWeibo = [[self middleArray] firstObject];
    NSUInteger index =  [modelArray indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HYWeiboModel *model = obj;
        return model.weiboID == lastWeibo.weiboID;
    }];
    NSRange range;
    if (index != NSNotFound) {
        range = NSMakeRange(0, index);
    }else{
        range = NSMakeRange(0, modelArray.count);
    }
    NSArray *tmpArray = [modelArray subarrayWithRange:range];
 
    for (HYWeiboModel *model in tmpArray) {
        
        model.layout = [[HYWeiboLayout alloc] initWithModel:model];
    }
    
    //防止多次调用KVO
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self modelArrayCount], [tmpArray count])];
    
    //保证KVO的线程安全
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self middleArray] insertObjects:tmpArray atIndexes:indexSet];
    });
    
}

- (NSUInteger) modelArrayCount{
    return [self.modelArray count];
}







@end
