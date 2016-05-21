//
//  HYWeiboViewModel.h
//  YangWeibo
//
//  Created by He yang on 16/5/18.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYWeiboModel.h"
#import "HYWeiboLayoutManager.h"
#import "HYWeiboLayout.h"
@interface HYWeiboViewModelCoordinator : NSObject

@property (nonatomic,strong)NSMutableArray *modelArray;

- (instancetype)init;

- (void)fetchData;



@end


@interface HYWeiboViewModel : NSObject

@property (nonatomic,strong)HYWeiboLayoutManager *layoutManager;

@property (nonatomic,strong)HYWeiboModel *model;

-(instancetype)initWithModel:(HYWeiboModel *)model;

@end
