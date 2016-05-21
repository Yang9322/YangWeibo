//
//  HYWeiboLayoutManager.m
//  YangWeibo
//
//  Created by He yang on 16/5/20.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYWeiboLayoutManager.h"
#import "NSString+YYAdd.h"

@interface HYWeiboLayoutManager()
@property (nonatomic,strong)HYWeiboModel *model;

@end
@implementation HYWeiboLayoutManager

-(instancetype)initWithModel:(HYWeiboModel *)model{
    if (self = [super init]) {
        _model = model;
        
    }
    
    return self;
}


#define kTopPadding 8    //顶部灰边宽度
#define kInnerPadding 14 //头像距离顶部白边距离
#define kNickNamePadding 10 
#define kCommonPadding 5

#define kAvatarHeight 36
#define kNickNameLabelHeight 17
#define kLeveiViewSize CGSizeMake(17,17)
#define kTimeLabelHeight 13
#define kSourceLabeleHeight 15
#define kModeButtonSize CGSizeMake(20,20)

- (void)layout{
   
    CGRect avatarRect = CGRectMake(kInnerPadding, kInnerPadding + kTopPadding, kAvatarHeight, kAvatarHeight);
    
    _avatarRect = avatarRect;
    
    CGSize nickNameSize = [_model.user.screen_name sizeForFont:[UIFont systemFontOfSize:12] size:CGSizeZero mode:NSLineBreakByWordWrapping];
    
    CGRect nickNameRect = CGRectMake(CGRectGetMaxX(_avatarRect) + kNickNamePadding,kInnerPadding,nickNameSize.width,nickNameSize.height);
    
    _nickNameRect = nickNameRect;
    
    
    
}

@end
