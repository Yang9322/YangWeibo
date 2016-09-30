//
//  WeatherManager.h
//  YangWeibo
//
//  Created by heyang on 16/9/30.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void  (^FetchDataBlock)(id data);


@interface WeatherManager : NSObject

@property(nonatomic,copy) FetchDataBlock fetchDataBlock;

- (void)fetchDataWithBlock:(FetchDataBlock)block;

@end
