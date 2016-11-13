//
//  BaseTabBarController.m
//  YangWeibo
//
//  Created by He yang on 16/5/14.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "BaseTabBarController.h"
#import "DiscoveryController.h"
#import "HomePageController.h"
#import "MessageController.h"
#import "MineController.h"
#import "BaseNavigationController.h"
#import "WeatherMainController.h"
@interface BaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTabBarItemsAttributesForController:self];
    [self setupChildViewController];
    [self customizeTabBarAppearance:self];


    // Do any additional setup after loading the view.
}


- (void)setUpTabBarItemsAttributesForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"tabbar_home@2x",
                            CYLTabBarItemSelectedImage : @"tabbar_home_selected@2x",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"消息",
                            CYLTabBarItemImage : @"tabbar_message_center@2x",
                            CYLTabBarItemSelectedImage : @"tabbar_message_center_selected@2x",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"发现",
                            CYLTabBarItemImage : @"tabbar_discover@2x",
                            CYLTabBarItemSelectedImage : @"tabbar_discover_selected@2x",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我",
                            CYLTabBarItemImage : @"tabbar_profile@2x",
                            CYLTabBarItemSelectedImage : @"tabbar_profile_highlighted@2x"
                            };
    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3,
                                       dict4
                                       ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}


- (void)setupChildViewController{
    HomePageController *firstViewController = [[HomePageController alloc] init];
    BaseNavigationController *firstNavController = [[BaseNavigationController alloc] initWithRootViewController:firstViewController];
    
    
    MessageController *secondViewController = [[MessageController alloc] init];
    BaseNavigationController *secondNavController = [[BaseNavigationController alloc] initWithRootViewController:secondViewController];
    
    
    DiscoveryController *thirdViewController = [[DiscoveryController alloc] init];
    BaseNavigationController *thirdNavController = [[BaseNavigationController alloc] initWithRootViewController:thirdViewController];
    
    MineController *fourthViewController = [[MineController alloc] init];
    BaseNavigationController *fourthNavController = [[BaseNavigationController alloc] initWithRootViewController:fourthViewController];
    
    [self setViewControllers:@[
                               firstNavController,
                               secondNavController,
                               thirdNavController,
                               fourthNavController
                               ]];
    
}


- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    

    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = HYColor(255, 130, 0);
    
 
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
}



-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    

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
