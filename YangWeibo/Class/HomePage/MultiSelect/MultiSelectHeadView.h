//
//  MultiSelectHeadView.h
//  YangWeibo
//
//  Created by heyang on 16/7/24.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiSelectModel.h"

@interface MultiSelectHeadView : UIView

- (void)refreshSubviewsWithState:(BOOL)state model:(MultiSelectModel *)model;

@end
