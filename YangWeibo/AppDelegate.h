//
//  AppDelegate.h
//  YangWeibo
//
//  Created by He yang on 16/5/11.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy, nonatomic) NSString *wbtoken;
@property (copy, nonatomic) NSString *wbRefreshToken;
@property (copy, nonatomic) NSString *wbCurrentUserID;

@end

