//
//  HYTitleView.h
//  YangWeibo
//
//  Created by He yang on 16/5/15.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^TappedBlock)(BOOL selected);

@interface HYTitleView : UIControl


@property (nonatomic,copy)TappedBlock tappedBlock;


- (void)tapped;


@end
