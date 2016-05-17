//
//  HYCoverView.m
//  YangWeibo
//
//  Created by He yang on 16/5/16.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYCoverView.h"

@implementation HYCoverView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
      [[NSNotificationCenter defaultCenter] postNotificationName:DIDSelectFriendRelationCellNotification object:nil];
}

@end
