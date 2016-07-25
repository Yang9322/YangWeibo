//
//  MultiSelectCell.h
//  YangWeibo
//
//  Created by heyang on 16/7/25.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiSelectModel.h"
@class MultiSelectCell;
@protocol  MultiSelectCellProtocol <NSObject>

- (void)didClickCell:(MultiSelectCell *)cell state:(BOOL)state;

@end

@interface MultiSelectCell : UITableViewCell

@property (nonatomic,weak)id <MultiSelectCellProtocol> cellDelegate;

@property (weak, nonatomic) IBOutlet UIButton *stateButton;

@property (nonatomic,assign)BOOL shouldCornerRadius;

@property (nonatomic,strong)MultiSelectModel *model;

@end
