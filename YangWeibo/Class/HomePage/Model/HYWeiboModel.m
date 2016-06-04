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


@implementation WBEmoticon
+ (NSArray *)modelPropertyBlacklist {
    return @[@"group"];
}
@end

@implementation WBEmoticonGroup
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"groupID" : @"id",
             @"nameCN" : @"group_name_cn",
             @"nameEN" : @"group_name_en",
             @"nameTW" : @"group_name_tw",
             @"displayOnly" : @"display_only",
             @"groupType" : @"group_type"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"emoticons" : [WBEmoticon class]};
}
- (void)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [_emoticons enumerateObjectsUsingBlock:^(WBEmoticon *emoticon, NSUInteger idx, BOOL *stop) {
        emoticon.group = self;
    }];
}
@end