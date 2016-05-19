//
//  ViewController.m
//  YangWeibo
//
//  Created by He yang on 16/5/11.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "BaseViewController.h"
#import "HYAOuthManager.h"
@interface BaseViewController ()
@property (nonatomic,strong)UIButton *button;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] init];
    button.center = self.view.center;
    button.width = 100;
    button.height = 100;
    [button setTitle:@"123" forState:UIControlStateNormal];
    _button = button;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)buttonClicked:(id)sender {
    
    [[HYAOuthManager manager] login];
    
}

@end
