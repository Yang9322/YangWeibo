//
//  FriendCircleCell.m
//  YangWeibo
//
//  Created by He yang on 16/5/15.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "FriendCircleCell.h"

@implementation FriendCircleCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self =  [super initWithFrame:frame]) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.opaque = YES;
        [self addSubview:_titleLabel];
        UIImageView *imageView = [[UIImageView alloc] init];
        _likeImageView = imageView;
        [self addSubview:_likeImageView];
        
        UIView *selectedBackgroundView = [[UIView alloc] init];
        selectedBackgroundView.backgroundColor = HYColor(149, 149, 149);
        self.selectedBackgroundView = selectedBackgroundView;
    }
    return self;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    [_likeImageView sizeToFit];
    
    _titleLabel.left = 10;
    _titleLabel.centerY = self.height / 2;
    _likeImageView.left = _titleLabel.right + 4;
    _likeImageView.centerY = self.height / 2;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected) {
        self.titleLabel.textColor = HYColor(255, 130, 0);
    }else{
        self.titleLabel.textColor = [UIColor whiteColor];
    }
    
        [super setSelected:selected animated:animated];

}




@end
