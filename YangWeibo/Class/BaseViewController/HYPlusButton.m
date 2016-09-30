//
//  HYPlusButton.m
//  YangWeibo
//
//  Created by He yang on 16/5/14.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYPlusButton.h"

@implementation HYPlusButton


//+ (void)load {
//    [super registerSubclass];
//}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

+ (instancetype)plusButton {
    UIImage *buttonImage = [UIImage imageNamed:@"tabbar_compose_button"];
    UIImage *highlightImage = [UIImage imageNamed:@"tabbar_compose_button_highlighted"];
    UIImage *iconImage = [UIImage imageNamed:@"tabbar_compose_icon_add"];
    UIImage *highlightIconImage = [UIImage imageNamed:@"tabbar_compose_icon_add_highlighted@2x"];
    
    HYPlusButton *button = [HYPlusButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.size = buttonImage.size;
    [button setImage:iconImage forState:UIControlStateNormal];
    [button setImage:highlightIconImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}




- (void)clickPublish{


}

@end
