//
//  HYCardHeaderView.h
//  YangWeibo
//
//  Created by He yang on 16/5/20.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLabel.h"
#import "HYWeiboViewModelCoordinator.h"




@interface HYCardHeaderView : UIView

@property (nonatomic,strong)HYWeiboViewModelCoordinator *viewModel;

@property (nonatomic,strong)UIImageView *avatarView;

@property (nonatomic,strong)YYLabel *nickNameLabel;

@property (nonatomic,strong)UIImageView *levelView;

@property (nonatomic,strong)YYLabel *timeLabel;

@property (nonatomic,strong)YYLabel *sourceLabel;

@property (nonatomic,strong)UIButton *moreButton;



@end
