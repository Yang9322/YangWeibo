//
//  HYWeiboCell.m
//  YangWeibo
//
//  Created by He yang on 16/5/20.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYWeiboCell.h"
#import "UIImageView+HYImageDownloader.h"
@interface HYWeiboCell()

@property (nonatomic,strong)UIImageView *avatarView;

@property (nonatomic,strong)UIImageView *vView;

@property (nonatomic,strong)UILabel *nickNameLabel;

@property (nonatomic,strong)UILabel *timeLabel;

@property (nonatomic,strong)UILabel *soureLabel;


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
    _avatarView = UIImageView.new;
    _vView = UIImageView.new;
    _nickNameLabel = UILabel.new;
    _timeLabel = UILabel.new;
    _soureLabel = UILabel.new;
    _nickNameLabel.font = kCommenFont;
    _timeLabel.font = kSmallerFont;
    _soureLabel.font = kSmallerFont;
    [self.contentView addSubview:_avatarView];
    [self.contentView addSubview:_vView];
    [self.contentView addSubview:_nickNameLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_soureLabel];
}


-(void)setModel:(HYWeiboModel *)model{
    _model = model;
    _avatarView.frame = model.layout.avatarRect;
    _vView.frame = model.layout.vRect;
    _nickNameLabel.frame = model.layout.nickNameRect;
    _timeLabel.frame = model.layout.timeRect;
    _soureLabel.frame = model.layout.sourceRect;
    
    [_avatarView hy_setImageWithURLString:_model.user.profile_image_url placeHolder:[UIImage imageNamed:@"timeline_image_placeholder"]     options:HYImageRoundedRectOption|HYImageFadeAnimationOption];
//    _vView.image = [UIImage imageNamed:@"friendcircle_compose_friendcirclebutton@2x"];
    _nickNameLabel.text = model.user.screen_name;
    _timeLabel.text = model.created_at_str;
    _soureLabel.text = model.source;
    
    
}



@end
