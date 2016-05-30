//
//  HYWeiboLayout.h
//  YangWeibo
//
//  Created by He yang on 16/5/21.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYWeiboModel.h"

@interface HYWeiboLayout : NSObject


@property (nonatomic,weak)HYWeiboModel *model;

//header
@property (nonatomic,assign)CGRect avatarRect;

@property (nonatomic,assign)CGRect vRect;

@property (nonatomic,assign)CGRect nickNameRect;

@property (nonatomic,assign)CGRect timeRect;

@property (nonatomic,assign)CGRect sourceRect;

//cardContend
@property (nonatomic,assign) CGRect contentRect;

@property (nonatomic,assign)CGFloat headerHeight;

@property (nonatomic,assign)CGFloat contendHeight;

@property (nonatomic,assign)CGFloat height;



- (instancetype)initWithModel:(HYWeiboModel *)model;
@end
