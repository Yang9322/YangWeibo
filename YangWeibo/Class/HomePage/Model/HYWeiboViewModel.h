//
//  HYWeiboViewModel.h
//  YangWeibo
//
//  Created by He yang on 16/5/18.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYWeiboModel.h"
@interface HYWeiboViewModel : NSObject




@property (nonatomic,strong)NSMutableArray *modelArray;

- (instancetype)init;

- (void)fetchData;


@end
