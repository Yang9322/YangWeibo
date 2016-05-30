//
//  HYWeiboCell.m
//  YangWeibo
//
//  Created by He yang on 16/5/20.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYWeiboCell.h"
#import "HYCardHeaderView.h"
#import "HYCardContentView.h"
@interface HYWeiboCell()

@property (nonatomic,strong)HYCardHeaderView *headerView;

@property (nonatomic,strong)HYCardContentView *cardContentView;


@end

@implementation HYWeiboCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.backgroundColor = [UIColor clearColor];
        [self configureSubViews];
    }
    
    return self;
}

- (void)configureSubViews{
    
    HYCardHeaderView *headerView = [[HYCardHeaderView alloc] init];
    _headerView = headerView;
    [self.contentView addSubview:headerView];
    
    HYCardContentView *cardContentView = [[HYCardContentView alloc] init];
    _cardContentView = cardContentView;
    [self.contentView addSubview:cardContentView];
}


-(void)setModel:(HYWeiboModel *)model{
    _headerView.model = model;
    _cardContentView.model = model;
}



@end
