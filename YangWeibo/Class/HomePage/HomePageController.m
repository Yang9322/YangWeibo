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
#define kAccessToken @"2.00T_vQ8D07d_KS3f1edf79cdW_mEXC"
static NSString *redirectURL = @"http://baidu.com";

@interface HomePageController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,weak)FriendCircleView *friendCircleView;

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarButtonItems];
    [self setupNavigationTitleView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
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
    
    
    titleView.tappedBlock = ^(BOOL selected){
       
        if (selected) {
            
            [UIView animateWithDuration:0.25 animations:^{
                self.friendCircleView.alpha = 0.55;
            }];
            
        }else{
            
            [UIView animateWithDuration:0.25 animations:^{
                self.friendCircleView.alpha = 0.0;
            }];
            
        }
        
    };
    self.navigationItem.titleView = titleView;
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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
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
