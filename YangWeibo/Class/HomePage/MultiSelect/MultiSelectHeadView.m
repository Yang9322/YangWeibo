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
#import "MultiSelectCell.h"
@interface MultiSelectHeadView ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray *searchResults;

@property (nonatomic,strong)NSMutableArray *modelsArray;

@property (nonatomic,strong)UITableView *tableView;

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
        _searchBar.delegate = self;
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
        [self removeButton:button];
    }
    
}


- (void)removeButton:(UIButton *)sender{
    
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
    _scrollView.contentSize = CGSizeMake(_modelsArray.count * (buttonWidth +ButtonPadding), 0);
    
    
    NSLog(@"begin---%@-/n%@--end",[NSValue valueWithCGSize:_scrollView.contentSize],[NSValue valueWithCGPoint:_scrollView.contentOffset]);
    if (_modelsArray.count < 5) {
        _searchBar.placeholder = @"搜索客户";
        _searchBar.searchTextPositionAdjustment = UIOffsetMake(0, 0);
        [_searchBar setImage:_searchIcon forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        
        _scrollView.frame = CGRectMake(0, SearchBarPadding, (_modelsArray.count ) * (buttonWidth + ButtonPadding), buttonWidth);
        
        
        _lastRect = _scrollView.frame;
        
        _searchBar.frame = CGRectMake(_modelsArray.count * (buttonWidth + ButtonPadding) + SearchBarPadding, SearchBarPadding, ScreeW - 2 * SearchBarPadding - _modelsArray.count * (buttonWidth + ButtonPadding) , self.height - 2 * SearchBarPadding);
    }
//    else{
//        CGFloat width = _scrollView.contentSize.width;
//        CGPoint offset = self.scrollView.contentOffset;
//        if (width> self.scrollView.frame.size.width) {
//            int offsetX = width - self.scrollView.frame.size.width;
//            offset.x = offsetX;
//        }
//        [_scrollView setContentOffset:originContentOffset animated:YES];
//    }
    
    sender = nil;
    
    
}

- (void)buttonClicked :(UIButton *)sender{
    MultiSelectModel *model = _modelsArray[sender.tag -  1];
    if (_headViewDelegate && [_headViewDelegate respondsToSelector:@selector(didClickedWithModel:)]) {
        [_headViewDelegate didClickedWithModel:model];
    }
    
    [self removeButton:sender];

}


- (void)addSubViewsWithModel:(MultiSelectModel *)model{
    CGFloat buttonWidth = self.height - 2 *SearchBarPadding;
    NSInteger index = [_modelsArray indexOfObject:model];
    UIButton *button = [[UIButton alloc] init];
    button.tag = index + 1;
    [button setBackgroundImage:model.image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(ButtonPadding + index * (buttonWidth +ButtonPadding), 0, buttonWidth, buttonWidth);
    if (_shouldCornerRadius) {
        button.layer.cornerRadius = buttonWidth / 2;
        button.layer.masksToBounds = YES;
    }
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
    


}


-(void)setShouldCornerRadius:(BOOL)shouldCornerRadius{
    _shouldCornerRadius = shouldCornerRadius;
    
}

#pragma mark - SearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        _tableView.alpha = 0;
        return;

    }
    NSString *searchString  = searchBar.text;
    
    self.searchResults = [self.dataArray mutableCopy];
    
    // strip out all the leading and trailing spaces
    NSString *strippedStr = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedStr.length > 0)
    {
        searchItems = [strippedStr componentsSeparatedByString:@" "];
    }
    
    // build all the "AND" expressions for each value in the searchString
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    
    for (NSString *searchString in searchItems)
    {
        // each searchString creates an OR predicate for: name, global_key
        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
        
        // name field matching
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"name"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs
                                       rightExpression:rhs
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        //        pinyinName field matching
        lhs = [NSExpression expressionForKeyPath:@"pinyinName"];
        rhs = [NSExpression expressionForConstantValue:searchString];
        finalPredicate = [NSComparisonPredicate
                          predicateWithLeftExpression:lhs
                          rightExpression:rhs
                          modifier:NSDirectPredicateModifier
                          type:NSContainsPredicateOperatorType
                          options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        //        global_key field matching
        lhs = [NSExpression expressionForKeyPath:@"abbreviationName"];
        rhs = [NSExpression expressionForConstantValue:searchString];
        finalPredicate = [NSComparisonPredicate
                          predicateWithLeftExpression:lhs
                          rightExpression:rhs
                          modifier:NSDirectPredicateModifier
                          type:NSContainsPredicateOperatorType
                          options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        // at this OR predicate to ourr master AND predicate
        NSCompoundPredicate *orMatchPredicates = (NSCompoundPredicate *)[NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
        [andMatchPredicates addObject:orMatchPredicates];
    }
    
    NSCompoundPredicate *finalCompoundPredicate = (NSCompoundPredicate *)[NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    
    self.searchResults = [[self.searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
   
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bottom, ScreeW, ScreeH - self.bottom) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.superview addSubview:_tableView];
        
    }
    _tableView.alpha = 1;
    [_tableView reloadData];
}

#pragma mark  TableViewDelegate&Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResults.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"MultiSelectCell";
    MultiSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MultiSelectCell" owner:nil options:nil] lastObject];
    }
    MultiSelectModel *model = self.searchResults[indexPath.row];
    cell.model = model;
    cell.shouldCornerRadius = _shouldCornerRadius;
    cell.stateButton.selected = model.selectedState;
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.alpha = 0;
    MultiSelectModel *model = self.searchResults[indexPath.row];
    if (!model.selectedState) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidChooseSearchResult" object:model];
    }

}


@end
