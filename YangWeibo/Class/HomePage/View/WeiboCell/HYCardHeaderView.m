//
//  HYCardHeaderView.m
//  YangWeibo
//
//  Created by He yang on 16/5/20.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYCardHeaderView.h"
#import "HYWeiboLayout.h"
#import "UIImageView+HYImageDownloader.h"

@interface HYCardHeaderView ()

@property (nonatomic,strong)UIImageView *avatarView;

@property (nonatomic,strong)UIImageView *vView;

@property (nonatomic,strong)YYLabel *nickNameLabel;

@property (nonatomic,strong)YYLabel *timeLabel;

@property (nonatomic,strong)YYLabel *soureLabel;@end

@implementation HYCardHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _avatarView = UIImageView.new;
        _vView = UIImageView.new;
        _nickNameLabel = YYLabel.new;
        _timeLabel = YYLabel.new;
        _soureLabel = YYLabel.new;
        _nickNameLabel.font = kCommonFont;
        _timeLabel.font = kSmallerFont;
        _soureLabel.font = kSmallerFont;
        [self addSubview:_avatarView];
        [self addSubview:_vView];
        [self addSubview:_nickNameLabel];
        [self addSubview:_timeLabel];
        [self addSubview:_soureLabel];
    }
    return self;
}

#define kCellTopPadding 8
-(void)setModel:(HYWeiboModel *)model{
    _model = model;
   self.frame = CGRectMake(0, kCellTopPadding, ScreeW,model.layout.headerHeight);
    _avatarView.frame = model.layout.avatarRect;
    _vView.frame = model.layout.vRect;
    _nickNameLabel.frame = model.layout.nickNameRect;
    _timeLabel.frame = model.layout.timeRect;
    _soureLabel.frame = model.layout.sourceRect;
    [_avatarView hy_setImageWithURLString:_model.user.profile_image_url placeHolder:[UIImage imageNamed:@"timeline_image_placeholder"]     options:HYImageDowloaderOptionRoundedRect|HYImageDowloaderOptionFadeAnimation];
    _nickNameLabel.text = model.user.screen_name;
    _timeLabel.text = model.created_at_str;
    _soureLabel.text = model.source;
    
    
}



@end
