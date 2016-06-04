//
//  HYWeiboHelper.h
//  YangWeibo
//
//  Created by He yang on 16/5/21.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HYWeiboModel;
@interface HYWeiboHelper : NSObject


+ (NSString *)stringWithTimelineDate:(NSString *)date ;


+ (NSDictionary *)emoticonDic;

+ (NSMutableAttributedString *) arrtributeStringWithModel:(HYWeiboModel *)model fontSize:(CGFloat)fontSize textColor:(UIColor *)textColo;
@end
