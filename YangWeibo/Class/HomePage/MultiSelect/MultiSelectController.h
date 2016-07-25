//
//  MultiSelectController.h
//  YangWeibo
//
//  Created by heyang on 16/7/24.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MultiSelectModel;
@interface MultiSelectController : UIViewController


@property (nonatomic,assign)BOOL shouldCornerRadius; //是否圆角

@property (nonatomic,strong)NSMutableArray *dataSource; //展示数据源



@end
