//
//  HYWeiboCell.m
//  YangWeibo
//
//  Created by He yang on 16/5/20.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYWeiboCell.h"
#import "HYCardHeaderView.h"
@interface HYWeiboCell()

@property (nonatomic,strong)HYCardHeaderView *headerView;




@end

@implementation HYWeiboCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self addHeaderView];
    }
    
    return self;
}

- (void)addHeaderView{
    
    HYCardHeaderView *headerView = [[HYCardHeaderView alloc] init];
    _headerView = headerView;
    [self.contentView addSubview:headerView];
    
    
}


-(void)setModel:(HYWeiboModel *)model{
    _headerView.model = model;
    
}



@end
