//
//  WeatherMainController.m
//  YangWeibo
//
//  Created by heyang on 16/9/30.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "WeatherMainController.h"
#import "WeatherManager.h"
@interface WeatherMainController ()

@property (nonatomic,strong)WeatherManager *weatherManager;

@end

@implementation WeatherMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"天气";
    [self.navigationController.navigationBar setHidden:YES];
    
    [self fetchData];
    // Do any additional setup after loading the view from its nib.
}


- (void)fetchData{
    
    if (!_weatherManager) {
        WeatherManager *weatherManager = [[WeatherManager alloc] init];
        _weatherManager = weatherManager;
    }
    [_weatherManager fetchDataWithBlock:^(id data) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
