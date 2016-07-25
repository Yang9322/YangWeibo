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
#import "MultiSelectCell.h"
@interface MultiSelectController ()<UITableViewDelegate,UITableViewDataSource,MultiSelectCellProtocol,MultiSelectHeadViewProtocol>
@property (nonatomic,strong)MultiSelectHeadView *headView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *selectedArray;
@end

@implementation MultiSelectController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self configureHeadView];
    [self configureTableView];
    _selectedArray = [NSMutableArray array];
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[[UIImage imageNamed:@"navigationbar_icon_radar@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:@"navigationbar_icon_radar_highlighted@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(refreshData:model:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
  
}

- (void)configureHeadView{
    MultiSelectHeadView *headView = [[MultiSelectHeadView alloc] initWithFrame:CGRectMake(0, 64, ScreeW, 60)];
//    headView.clipsToBounds = YES;
    headView.headViewDelegate = self;
    [self.view addSubview:headView];
    _headView = headView;
    
}


- (void)configureTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headView.bottom, ScreeW, ScreeH - _headView.bottom) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)refreshData:(BOOL)state model:(MultiSelectModel *)model{
     [_headView refreshSubviewsWithState:state model:model];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"MultiSelectCell";
    MultiSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MultiSelectCell" owner:nil options:nil] lastObject];
        cell.cellDelegate = self;
    }
    cell.model = self.dataSource[indexPath.row];
    cell.tag = indexPath.row + 1;
    cell.model.cellIndex = indexPath.row;
    return cell;
}

-(NSMutableArray<MultiSelectModel *> *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
        for (int i = 0; i < 8; i ++) {
            MultiSelectModel *model = [[MultiSelectModel alloc] init];
            model.name = @"yang";
            model.image = [UIImage imageNamed:@"tabbar_profile@2x"];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

-(void)didClickCell:(MultiSelectCell *)cell state:(BOOL)state{
    if (state) {
        [_selectedArray addObject:cell.model];
    }else{
        [_selectedArray removeObject:cell.model];
    }
    
    [self refreshData:state model:cell.model];
    
}

-(void)didClickedWithModel:(MultiSelectModel *)model{
    MultiSelectCell *cell = [_tableView viewWithTag:model.cellIndex +1];
    cell.stateButton.selected = NO;
    [_selectedArray removeObject:model];

    
    
    
}

@end
