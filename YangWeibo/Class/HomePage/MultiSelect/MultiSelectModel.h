//
//  MultiSelectModel.h
//  YangWeibo
//
//  Created by heyang on 16/7/24.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultiSelectModel : NSObject


@property (nonatomic,copy)NSString *name;

@property (nonatomic,strong)UIImage *image;

@property (nonatomic,strong)NSIndexPath *cellIndexPath; //记录model所对应的cell

@property (nonatomic,assign)BOOL selectedState;
@end
