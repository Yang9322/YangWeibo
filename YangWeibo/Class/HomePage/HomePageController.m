//
//  HomePageController.m
//  YangWeibo
//
//  Created by He yang on 16/5/13.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HomePageController.h"
#import "WeiboSDK.h"
#import "HYTitleView.h"
#import "FriendCircleView.h"
#import "HYHomePageTableView.h"
#import "HYCoverView.h"
#define kAccessToken @"2.00T_vQ8D07d_KS3f1edf79cdW_mEXC"
static NSString *redirectURL = @"http://baidu.com";

@interface HomePageController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet HYHomePageTableView *tableView;

@property (nonatomic,weak)FriendCircleView *friendCircleView;

@property (nonatomic,weak)HYTitleView *titleView;

@property (nonatomic,weak)HYCoverView *coverView;
@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarButtonItems];
    [self setupNavigationTitleView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFriendRelationClicked) name:DIDSelectFriendRelationCellNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
    [kKeyWindow addSubview:coverView];
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


- (void)receiveFriendRelationClicked{
    
    [_titleView tapped];
}


- (void)appearFriendView{
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.friendCircleView.alpha = 0.95;
    }];
    
}

- (void) dismissFriendView{
    [UIView animateWithDuration:0.25 animations:^{
        self.friendCircleView.alpha = 0.0;
    }];
}

-(FriendCircleView *)friendCircleView{
    if (!_friendCircleView) {
      
        FriendCircleView *localView = [[FriendCircleView alloc] initWithFrame:CGRectMake((ScreeW - 200) / 2 , 54, 200, 300)];
        [kKeyWindow addSubview:localView];
        _friendCircleView = localView;
    }
    return _friendCircleView;
}

- (void)refreshData:(UIButton *)sender{
    

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"access_token"] = kAccessToken;
    
    [[HYHTTPManager sharedManager] GetRequestWithURLString:@"https://api.weibo.com/2/statuses/public_timeline.json" Parameter:params success:^(id responseObject) {
//        HYDBAnyVar(responseObject);
    } failure:^(NSError *error) {
//        HYDBAnyVar(error);
    }];
}

- (void)login{
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = redirectURL;
    request.scope = @"all";
    request.shouldShowWebViewForAuthIfCannotSSO = YES;
    [WeiboSDK sendRequest:request];

}





#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"132"];
    cell.textLabel.text = @"123321231232132133211231231231233";
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
