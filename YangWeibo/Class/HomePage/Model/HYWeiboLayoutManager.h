//
//  HYWeiboLayoutManager.h
//  YangWeibo
//
//  Created by He yang on 16/5/20.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYWeiboModel.h"

@interface HYWeiboLayoutManager : NSObject



//headerView

@property (nonatomic,assign)CGRect avatarRect;

@property (nonatomic,assign)CGRect nickNameRect;
- (instancetype)initWithModel:(HYWeiboModel *)model;



@end
