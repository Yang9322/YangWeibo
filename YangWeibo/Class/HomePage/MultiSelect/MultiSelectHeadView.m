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
@interface MultiSelectHeadView ()

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UISearchBar *searchBar;

@property (nonatomic,strong)NSMutableArray *modelsArray;

@end

@implementation MultiSelectHeadView{
    CGRect _lastRect;
    UIImage *_searchIcon;
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
        _searchIcon = [_searchBar imageForSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_scrollView];
        
    }
    return self;
}


- (void)refreshSubviewsWithState:(BOOL)state model:(MultiSelectModel *)model{
    if (state) {
        [_modelsArray addObject:model];
        [self addSubViewsWithModel:model];
    }else{
        
        NSInteger index = [_modelsArray indexOfObject:model];
        UIButton *button = [_scrollView viewWithTag:index + 1];
        [self buttonClicked:button];
    }
 
    
    
    
}


- (void)buttonClicked :(UIButton *)sender{
    CGFloat buttonWidth = self.height - 2 *SearchBarPadding;
    
    [sender removeFromSuperview];
    
    for (NSInteger i = (sender.tag);  i < _modelsArray.count; i ++) {
        UIButton *button = [_scrollView viewWithTag:i + 1];
        button.tag -= 1;
        [UIView animateWithDuration:0.15 animations:^{
            button.left = button.left -(buttonWidth +ButtonPadding);
        }];
    }
    [_modelsArray removeObjectAtIndex:sender.tag - 1];
    
    if (_modelsArray.count < 5) {
        _searchBar.placeholder = @"搜索客户";
        _searchBar.searchTextPositionAdjustment = UIOffsetMake(0, 0);
        [_searchBar setImage:_searchIcon forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        
        _scrollView.frame = CGRectMake(0, SearchBarPadding, (_modelsArray.count ) * (buttonWidth + ButtonPadding), buttonWidth);
        _scrollView.contentSize = CGSizeMake(_modelsArray.count * (buttonWidth +ButtonPadding), 0);

        _lastRect = _scrollView.frame;
        
        _searchBar.frame = CGRectMake(_modelsArray.count * (buttonWidth + ButtonPadding) + SearchBarPadding, SearchBarPadding, ScreeW - 2 * SearchBarPadding - _modelsArray.count * (buttonWidth + ButtonPadding) , self.height - 2 * SearchBarPadding);
    }
    
    sender = nil;
    
     NSLog(@"begin---%ld---end",_scrollView.subviews.count);
}


- (void)addSubViewsWithModel:(MultiSelectModel *)model{
    CGFloat buttonWidth = self.height - 2 *SearchBarPadding;
    NSInteger index = [_modelsArray indexOfObject:model];
    UIButton *button = [[UIButton alloc] init];
    button.tag = index + 1;
    [button setBackgroundImage:model.image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    button.frame = CGRectMake(ButtonPadding + index * (buttonWidth +ButtonPadding), 0, buttonWidth, buttonWidth);
    [_scrollView addSubview:button];
     _scrollView.contentSize = CGSizeMake((index + 1) * (buttonWidth +ButtonPadding), 0);
    CGFloat width = _scrollView.contentSize.width;
    
    if (_modelsArray.count > 5) {
        CGPoint offset = self.scrollView.contentOffset;
        if (width> self.scrollView.frame.size.width) {
            int offsetX = width - self.scrollView.frame.size.width;
                offset.x = offsetX;
            }
       
        _searchBar.placeholder = @"";
        [_searchBar setImage:[UIImage new] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        _searchBar.searchTextPositionAdjustment = UIOffsetMake(-20, 0);
        [_scrollView setContentOffset:offset animated:YES];


    }else{
        _searchBar.placeholder = @"搜索客户";
        _searchBar.searchTextPositionAdjustment = UIOffsetMake(0, 0);
        [_searchBar setImage:_searchIcon forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];

    _scrollView.frame = CGRectMake(0, SearchBarPadding, (index + 1) * (buttonWidth + ButtonPadding), buttonWidth);
    _lastRect = _scrollView.frame;
    
    _searchBar.frame = CGRectMake((index + 1) * (buttonWidth + ButtonPadding), SearchBarPadding, ScreeW - 2 * SearchBarPadding - (index + 1) * (buttonWidth + ButtonPadding) + SearchBarPadding , self.height - 2 * SearchBarPadding);
    }
    
    NSLog(@"begin---%ld---end",_scrollView.subviews.count);


}





@end
