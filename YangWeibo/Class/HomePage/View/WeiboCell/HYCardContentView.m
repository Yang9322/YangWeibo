//
//  HYCardContentView.m
//  YangWeibo
//
//  Created by He yang on 16/5/28.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYCardContentView.h"
#import "HYWeiboLayout.h"


@interface HYCardContentView ()

@property (nonatomic,strong)YYLabel *contentLabel;

@end

@implementation HYCardContentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _contentLabel = YYLabel.new;
        _contentLabel.font = kContentFont;
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
    }
    return self;
}


-(void)setModel:(HYWeiboModel *)model{
    _model = model;
    self.frame = CGRectMake(0, _model.layout.headerHeight, ScreeW, _model.layout.contendHeight);
    _contentLabel.text = model.text;
    _contentLabel.frame = model.layout.contentRect;
    
}

@end
