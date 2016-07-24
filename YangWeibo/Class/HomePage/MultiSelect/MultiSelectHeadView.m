//
//  MultiSelectHeadView.m
//  YangWeibo
//
//  Created by heyang on 16/7/24.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "MultiSelectHeadView.h"
#import "UIView+YT.h"
#import "UIImage+YYAdd.h"
#import "MultiSelectModel.h"
@interface MultiSelectHeadView ()

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UISearchBar *searchBar;

@property (nonatomic,strong)NSMutableArray *modelsArray;

@end

@implementation MultiSelectHeadView{
    CGRect _lastRect;
}
#define SearchBarColor [UIColor lightGrayColor]
#define SearchBarPadding 10
#define ButtonPadding 5
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _modelsArray = [NSMutableArray new];
        self.backgroundColor = [UIColor whiteColor];
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:SearchBarColor] forState:UIControlStateNormal];
        _searchBar.placeholder = @"搜索客户";
        _searchBar.backgroundImage = [UIImage imageWithColor:SearchBarColor];
        _searchBar.layer.cornerRadius = 5;
        _searchBar.layer.masksToBounds = YES;
        [self addSubview:_searchBar];
        _searchBar.frame = CGRectMake(SearchBarPadding, SearchBarPadding, ScreeW - 2 *SearchBarPadding, self.height - 2 *SearchBarPadding);
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_scrollView];
        
    }
    return self;
}


- (void)refreshSubviews{
    
    
    MultiSelectModel *model = [[MultiSelectModel alloc] init];
    model.name = @"yang";
    model.image = [UIImage imageNamed:@"tabbar_profile_highlighted@2x"];
    [_modelsArray addObject:model];
    
    
    [self addSubViewsWithModel:model];
    
    
    
}


- (void)buttonClicked :(UIButton *)sender{
    
}


- (void)addSubViewsWithModel:(MultiSelectModel *)model{
    CGFloat buttonWidth = self.height - 2 *SearchBarPadding;
    NSInteger index = [_modelsArray indexOfObject:model];
    UIButton *button = [[UIButton alloc] init];
    button.tag = index;
    [button setBackgroundImage:model.image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    button.frame = CGRectMake(ButtonPadding + index * (buttonWidth +ButtonPadding), 0, buttonWidth, buttonWidth);
    [_scrollView addSubview:button];
     _scrollView.contentSize = CGSizeMake((index + 1) * buttonWidth, 0);

    if (button.origin.x > ScreeW / 2) {
        _searchBar.placeholder = @"";

    }else{
    _scrollView.frame = CGRectMake(0, SearchBarPadding, (index + 1) * (buttonWidth + ButtonPadding), buttonWidth);
    _lastRect = _scrollView.frame;
    
    _searchBar.frame = CGRectMake((index + 1) * (buttonWidth + ButtonPadding), SearchBarPadding, ScreeW - 2*SearchBarPadding - (index + 1) * (buttonWidth + ButtonPadding) + SearchBarPadding , self.height - 2 *SearchBarPadding);
    }

}





@end
