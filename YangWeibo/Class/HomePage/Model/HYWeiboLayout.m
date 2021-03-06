//
//  HYWeiboLayout.m
//  YangWeibo
//
//  Created by He yang on 16/5/21.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYWeiboLayout.h"
#import "NSString+YYAdd.h"
#import "HYWeiboHelper.h"
#import "NSDate+YYAdd.h"

@implementation HYWeiboLayout


-(instancetype)initWithModel:(HYWeiboModel *)model{
    if (self = [super init]) {
        _model = model;
        [self layout];
    }
    return self;
}





- (void)layout{
    
    
    [self layoutHeader];
    
    [self layoutCardContent];

    
}

#define kTopPadding 8    //顶部灰边宽度
#define kInnerPadding 8 //头像距离顶部白边距离
#define kNickNamePadding 10
#define kCommonPadding 5

#define kAvatarHeight 36
#define kNickNameLabelHeight 17
#define kLeveiViewSize CGSizeMake(17,17)
#define kTimeLabelHeight 13
#define kSourceLabeleHeight 15
#define kModeButtonSize CGSizeMake(20,20)

#define kVRectHeight 12  //v视图尺寸

- (void)layoutHeader{
    _height = 0;
    // 头像
    CGRect avatarRect = CGRectMake(kInnerPadding, kInnerPadding + kTopPadding, kAvatarHeight, kAvatarHeight);
    
    _avatarRect = avatarRect;
    
    // v
    CGRect vRect = _model.user.verified ? CGRectMake(CGRectGetMaxX(avatarRect) - kVRectHeight, CGRectGetMaxY(avatarRect) - kVRectHeight, kVRectHeight, kVRectHeight) : CGRectZero;
    
    _vRect = vRect;
    
    
    // 昵称
    CGSize nickNameSize = [_model.user.screen_name sizeForFont:kCommonFont size:CGSizeZero mode:NSLineBreakByWordWrapping];
    
    CGRect nickNameRect = CGRectMake(CGRectGetMaxX(_avatarRect) + kNickNamePadding,kInnerPadding + kTopPadding,nickNameSize.width,nickNameSize.height);
    
    _nickNameRect = nickNameRect;
    
    // 时间
    
    
    NSString *createTime = [HYWeiboHelper stringWithTimelineDate:_model.created_at];
    
    _model.created_at_str = createTime;
    
    CGSize timeSize = [createTime sizeForFont:kSmallerFont size:CGSizeZero mode:NSLineBreakByWordWrapping];
    
    CGRect timeRect = CGRectMake(nickNameRect.origin.x, CGRectGetMaxY(nickNameRect) + kCommonPadding, timeSize.width, timeSize.height);
    _timeRect = timeRect;
    
    
    // 来源
    _sourceRect = CGRectZero;
    if (_model.source.length) {
        
        static NSRegularExpression *hrefRegex, *textRegex;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            hrefRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=href=\").+(?=\" )" options:kNilOptions error:NULL];
            textRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=>).+(?=<)" options:kNilOptions error:NULL];
        });
        NSTextCheckingResult *hrefResult, *textResult;
        NSString *href = nil, *text = nil;
        hrefResult = [hrefRegex firstMatchInString:_model.source options:kNilOptions range:NSMakeRange(0, _model.source.length)];
        textResult = [textRegex firstMatchInString:_model.source options:kNilOptions range:NSMakeRange(0, _model.source.length)];
        if (hrefResult && textResult && hrefResult.range.location != NSNotFound && textResult.range.location != NSNotFound) {
            href = [_model.source substringWithRange:hrefResult.range];
            text = [_model.source substringWithRange:textResult.range];
        }
        if (href && text) {
            _model.source = [NSString stringWithFormat:@"来自：%@",text];
            CGSize sourceSize = [_model.source sizeForFont:kSmallerFont size:CGSizeZero mode:NSLineBreakByWordWrapping];
            CGRect sourceRect = CGRectMake(CGRectGetMaxX(timeRect) + kCommonPadding, timeRect.origin.y, sourceSize.width, sourceSize.height);
            _sourceRect = sourceRect;
            
        }
    }
    _headerHeight = CGRectGetMaxY(_avatarRect) + 2 * kTopPadding;
    
    _height += _headerHeight;
    
    
}


#define kContentPadding 10
#define kWBCellTextNormalColor HYColor(55, 55, 55) // 一般文本色

- (void)layoutCardContent{
    
    NSMutableAttributedString *text = [HYWeiboHelper arrtributeStringWithModel:_model fontSize:12 textColor:kWBCellTextNormalColor];
    
    _model.attributeText = text;
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(ScreeW - 2 * kContentPadding, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];

    CGRect contentRect = CGRectMake(kContentPadding, kContentPadding, rect.size.width, rect.size.height +kContentPadding);
    
    _contentRect = contentRect;
    
    _contendHeight =  CGRectGetMaxY(contentRect) + 2 * kContentPadding;
    
    _height += _contendHeight;
    
    
}

@end
