//
//  HYWeiboHelper.m
//  YangWeibo
//
//  Created by He yang on 16/5/21.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYWeiboHelper.h"
#import "NSDate+YYAdd.h"
#import "HYWeiboModel.h"
@implementation HYWeiboHelper
+ (NSString *)stringWithTimelineDate:(NSString  *)dateStr {
    
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *date = [formatter dateFromString:dateStr];

    if (!date) return @"";
    
    static NSDateFormatter *formatterYesterday;
    static NSDateFormatter *formatterSameYear;
    static NSDateFormatter *formatterFullDate;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterYesterday = [[NSDateFormatter alloc] init];
        [formatterYesterday setDateFormat:@"昨天 HH:mm"];
        [formatterYesterday setLocale:[NSLocale currentLocale]];
        
        formatterSameYear = [[NSDateFormatter alloc] init];
        [formatterSameYear setDateFormat:@"M-d"];
        [formatterSameYear setLocale:[NSLocale currentLocale]];
        
        formatterFullDate = [[NSDateFormatter alloc] init];
        [formatterFullDate setDateFormat:@"yy-M-dd"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
    });
    
    NSDate *now = [NSDate new];
    NSTimeInterval delta = now.timeIntervalSince1970 - date.timeIntervalSince1970;
    if (delta < -60 * 10) { // 本地时间有问题
        return [formatterFullDate stringFromDate:date];
    } else if (delta < 60 * 10) { // 10分钟内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%d分钟前", (int)(delta / 60.0)];
    } else if (date.isToday) {
        return [NSString stringWithFormat:@"%d小时前", (int)(delta / 60.0 / 60.0)];
    } else if (date.isYesterday) {
        return [formatterYesterday stringFromDate:date];
    } else if (date.year == now.year) {
        return [formatterSameYear stringFromDate:date];
    } else {
        return [formatterFullDate stringFromDate:date];
    }
}


+ (NSMutableAttributedString *) arrtributeStringWithModel:(HYWeiboModel *)model fontSize:(CGFloat)fontSize textColor:(UIColor *)color{
    NSMutableAttributedString *string = nil;
    if (!model) return nil;
    NSMutableString *text = model.text.mutableCopy;
    if (text.length == 0) {
        return nil;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    
    
    
    return string;
}




@end
