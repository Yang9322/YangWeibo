//
//  HomePageController.m
//  YangWeibo
//
//  Created by He yang on 16/5/13.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HomePageController.h"
//#import "WeiboSDK.h"
#import "HYTitleView.h"
#import "FriendCircleView.h"
#import "HYHomePageTableView.h"
#import "HYCoverView.h"
#import "MJRefresh.h"
#import "HYWeiboModel.h"
#import "HYWeiboViewModelCoordinator.h"
#import "HYFPSLabel.h"
#import "HYWeiboCell.h"
#import "MultiSelectController.h"
@interface HomePageController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet HYHomePageTableView *tableView;

@property (nonatomic,weak)FriendCircleView *friendCircleView;

@property (nonatomic,weak)HYTitleView *titleView;

@property (nonatomic,weak)HYCoverView *coverView;

@property (nonatomic,strong)UIView *headerView;

@property (nonatomic,strong)HYWeiboViewModelCoordinator *viewModelCordinator;
@end

@implementation HomePageController


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarButtonItems];
    [self setupNavigationTitleView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData:)];
//    [self.tableView.mj_header beginRefreshing];

     self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshData:)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFriendRelationClicked) name:DIDSelectFriendRelationCellNotification object:nil];
    
    [self.viewModelCordinator addObserver:self forKeyPath:@"modelArray" options:NSKeyValueObservingOptionNew context:nil];
    
    //FPSLabel
    HYFPSLabel *label = [[HYFPSLabel alloc] init];
    label.bounds = CGRectMake(0, 0, 80, 40);
    label.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 64);
    [kKeyWindow addSubview:label];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.viewModelCordinator removeObserver:self forKeyPath:@"modelArray"];

}


#pragma mark - View Initial

- (void)setupBarButtonItems{
    UIImage *image = [[UIImage imageNamed:@"navigationbar_friendattention"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[[UIImage imageNamed:@"navigationbar_icon_radar@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:@"navigationbar_icon_radar_highlighted@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    

    
}


- (void)setupNavigationTitleView{
    
    
    HYTitleView *titleView = [[HYTitleView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    HYCoverView *coverView = [[HYCoverView alloc] initWithFrame:CGRectMake(0, 0, ScreeW, ScreeH)];
    _coverView = coverView;
    _coverView.alpha = 0;
    [kKeyWindow addSubview:_coverView];
  
    _titleView = titleView;
    titleView.tappedBlock = ^(BOOL selected){
       
        if (selected) {
            
            [self appearFriendView];
        }else{
            
            [self dismissFriendView];
            
        }
        
    };
    self.navigationItem.titleView = titleView;
}


#pragma mark - Lazy Load

-(HYWeiboViewModelCoordinator *)viewModelCordinator{
    if (!_viewModelCordinator) {
        _viewModelCordinator = [[HYWeiboViewModelCoordinator alloc] init];
    }
    return _viewModelCordinator;
}
#define SearchPadding 3
#define SearchBarPadding 10
#define SearchBarHeight 40
#define SearchBarTopPadding 5
-(UIView *)headerView{
    if (!_headerView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreeW, SearchBarHeight)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        
        UIView *searchView = [[UIView alloc] init];
        searchView.size = CGSizeMake(ScreeW - SearchBarPadding,SearchBarHeight- 2 *SearchBarTopPadding);
        searchView.centerY = view.height / 2;
        searchView.centerX = ScreeW / 2;
        searchView.backgroundColor = [UIColor whiteColor];
        searchView.layer.cornerRadius = 5;
        searchView.layer.masksToBounds = YES;
        [view addSubview:searchView];
        
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:@"searchbar_searchlist_search_icon"];
        iconView.size = CGSizeMake(searchView.height - 2 *SearchPadding, searchView.height - 2 *SearchPadding);
        iconView.centerY = searchView.height / 2;
        iconView.centerX = SearchPadding + iconView.width / 2;
        [searchView addSubview:iconView];
        
        
        UILabel *label = [UILabel new];
        label.text = @"搜索";
        label.textColor = HYColor(182, 182, 182);
        label.font = [UIFont systemFontOfSize:13];
        [label sizeToFit];
        label.centerY = iconView.centerY;
        label.centerX = iconView.right + SearchPadding + label.width / 2;
        [searchView addSubview:label];
        
        _headerView = view;
        
    }
    return _headerView;
}



-(FriendCircleView *)friendCircleView{
    if (!_friendCircleView) {
        
        FriendCircleView *localView = [[FriendCircleView alloc] initWithFrame:CGRectMake((ScreeW - 200) / 2 , 54, 200, 300)];
        [kKeyWindow addSubview:localView];
        _friendCircleView = localView;
    }
    return _friendCircleView;
}


#pragma mark - Private Method

- (void)receiveFriendRelationClicked{
    
    [_titleView tapped];
}


- (void)appearFriendView{
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.friendCircleView.alpha = 0.95;
        _coverView.alpha = 0.02;
    }];
    
}

- (void) dismissFriendView{
    [UIView animateWithDuration:0.25 animations:^{
        self.friendCircleView.alpha = 0.0;
        _coverView.alpha = 0;
    }];
}



- (void)refreshData:(UIButton *)sender{
    MultiSelectController *vc = [[MultiSelectController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.shouldCornerRadius = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)login{
   
//    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    request.redirectURI = redirectURL;
//    request.scope = @"all";
//    request.shouldShowWebViewForAuthIfCannotSSO = YES;
//    [WeiboSDK sendRequest:request];

}



- (void)updateTableViewWithModels:(NSArray *)addIndexs{
 
    NSMutableArray *addIndexPathes = [NSMutableArray array];
    
    if (self.viewModelCordinator.modelArray.count - addIndexs.count == 0) {
        [self.tableView reloadData];
        return;
    }

    for ( int i = 0 ;  i < addIndexs.count; i++) {
        [addIndexPathes addObject:[NSIndexPath indexPathForRow:(self.viewModelCordinator.modelArray.count - addIndexs.count + i ) inSection:0]];
        
    
    }
    
    [_tableView beginUpdates];
    [_tableView insertRowsAtIndexPaths:addIndexPathes withRowAnimation:UITableViewRowAnimationNone];
    [_tableView endUpdates];
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
        if ([keyPath isEqualToString:@"modelArray"]) {
            if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
                [self.tableView.mj_header endRefreshing];

            }
            if (self.tableView.mj_footer.state == MJRefreshStateRefreshing ) {
                [self.tableView.mj_footer endRefreshing];   
            }
        
            NSArray  *indexs = change[@"new"];
            
            [self updateTableViewWithModels:indexs];

            
  
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }

}

#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModelCordinator.modelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYWeiboModel *model = self.viewModelCordinator.modelArray[indexPath.row];
 
    return model.layout.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"HYWeiboCell";
    HYWeiboModel *model = self.viewModelCordinator.modelArray[indexPath.row];

    HYWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HYWeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = model;
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
