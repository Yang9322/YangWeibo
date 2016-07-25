//
//  MultiSelectHeadView.h
//  YangWeibo
//
//  Created by heyang on 16/7/24.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiSelectModel.h"

@protocol MultiSelectHeadViewProtocol <NSObject>

- (void)didClickedWithModel:(MultiSelectModel *)model;

@end

@interface MultiSelectHeadView : UIView

@property (nonatomic,weak)id <MultiSelectHeadViewProtocol>headViewDelegate;

- (void)refreshSubviewsWithState:(BOOL)state model:(MultiSelectModel *)model;

@end
