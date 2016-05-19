//
//  HYWeiboModel.h
//  YangWeibo
//
//  Created by He yang on 16/5/18.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>

//地理位置model
@interface HYGeoModel : NSObject

@property(nonatomic,copy)NSString *city_name; //城市名称

@property(nonatomic,copy)NSString *address; //地址

@end

@interface HYUserModel : NSObject

@property(nonatomic,copy)NSString *idstr; //字符串型的用户UID

@property(nonatomic,copy)NSString *screen_name; //用户昵称

@property(nonatomic,copy)NSString *profile_image_url; //用户头像地址

@property(nonatomic,copy)NSString *gender; //性别，m：男、f：女、n：未知

@end

@interface HYPicModel : NSObject

@property (nonatomic,copy)NSString *thumbnail_pic; // 缩略图地址

@end

@interface HYWeiboModel : NSObject

@property (nonatomic,assign)NSInteger weiboID;

@property (nonatomic,copy)NSString *created_at; //微博创建时间

@property (nonatomic,copy)NSString *text; //微博正文

@property (nonatomic,copy)NSString *source; //微博来源

@property (nonatomic,assign)BOOL favorited; //是否收藏

@property (nonatomic,copy)NSString *thumbnail_pic; //缩略图地址

@property (nonatomic,copy)NSString *original_pic;  //原图地址

@property (nonatomic,strong) HYGeoModel *geo; //地理位置

@property (nonatomic,strong) HYUserModel *user;//用户信息

@property (nonatomic,strong) HYWeiboModel *retweeted_status; //被转发的原微博信息字段

@property (nonatomic,assign)NSUInteger reposts_count; //转发数

@property (nonatomic,assign)NSUInteger comments_count; //评论数

@property (nonatomic,assign)NSUInteger attitudes_count; //赞数

@property (nonatomic,copy)NSArray *pic_urls; //图片数组


@end
