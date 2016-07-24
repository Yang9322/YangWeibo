//
//  MultiSelectController.m
//  YangWeibo
//
//  Created by heyang on 16/7/24.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "MultiSelectController.h"
#import "UIView+YT.h"
#import "MultiSelectHeadView.h"
@interface MultiSelectController ()
@property (nonatomic,strong)MultiSelectHeadView *headView;
@end

@implementation MultiSelectController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self configureHeadView];
    
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[[UIImage imageNamed:@"navigationbar_icon_radar@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:@"navigationbar_icon_radar_highlighted@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)configureHeadView{
    MultiSelectHeadView *headView = [[MultiSelectHeadView alloc] initWithFrame:CGRectMake(0, 64, ScreeW, 60)];
//    headView.clipsToBounds = YES;
    [self.view addSubview:headView];
    _headView = headView;
    
    
    
}

- (void)refreshData{
    [_headView refreshSubviews];
}

@end
