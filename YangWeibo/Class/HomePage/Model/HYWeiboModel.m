//
//  HYWeiboModel.m
//  YangWeibo
//
//  Created by He yang on 16/5/18.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYWeiboModel.h"
#import "MJExtension.h"

@implementation HYGeoModel

@end

@implementation HYUserModel

@end

@implementation HYPicModel

@end

@implementation HYWeiboModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"pic_urls":@"HYPicModel"
             };
    
}


+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"weiboID" : @"id"
             };
}


@end
