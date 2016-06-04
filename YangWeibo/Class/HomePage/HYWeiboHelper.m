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
#import "NSAttributedString+YYText.h"
#import "YYTextAttribute.h"
#import "NSObject+YYModel.h"
#import "NSString+YYAdd.h"
#import "NSBundle+YYAdd.h"
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


+ (NSMutableAttributedString *) arrtributeStringWithModel:(HYWeiboModel *)model fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor{
    if (!model) return nil;
    NSMutableString *string = model.text.mutableCopy;
    if (string.length == 0) {
        return nil;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
   
    text.font = font;
    text.color = textColor;
    NSArray *emotionResults = [[self regexEmoticon] matchesInString:text.string options:kNilOptions range:text.rangeOfAll];
    
    NSUInteger emoClipLength = 0;
    for (NSTextCheckingResult *emo in emotionResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) {
            continue;
        }
        NSRange range = emo.range;
        // ???
        range.location -= emoClipLength;
        if ([text attribute:YYTextHighlightAttributeName atIndex:range.location]) continue;
        if ([text attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [text.string substringWithRange:range];
        NSString *imagePath = [self emoticonDic][emoString];
        UIImage *image = [self imageWithPath:imagePath];
        if (!imagePath) continue;
        NSAttributedString *emoText = [NSAttributedString attachmentStringWithEmojiImage:image fontSize:fontSize];
        [text replaceCharactersInRange:range withAttributedString:emoText];
        emoClipLength += range.length - 1;
    }
    
    
    return text;
}


+ (NSRegularExpression *)regexEmoticon {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[^ \\[\\]]+?\\]" options:kNilOptions error:NULL];
    });
    return regex;
}




+ (NSDictionary *)emoticonDic {
    static NSMutableDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *emoticonBundlePath = [[NSBundle mainBundle] pathForResource:@"EmoticonWeibo" ofType:@"bundle"];
        dic = [self _emoticonDicFromPath:emoticonBundlePath];
    });
    return dic;
}

+ (NSMutableDictionary *)_emoticonDicFromPath:(NSString *)path {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    WBEmoticonGroup *group = nil;
    NSString *jsonPath = [path stringByAppendingPathComponent:@"info.json"];
    NSData *json = [NSData dataWithContentsOfFile:jsonPath];
    if (json.length) {
        group = [WBEmoticonGroup modelWithJSON:json];
    }
    if (!group) {
        NSString *plistPath = [path stringByAppendingPathComponent:@"info.plist"];
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        if (plist.count) {
            group = [WBEmoticonGroup modelWithJSON:plist];
        }
    }
    for (WBEmoticon *emoticon in group.emoticons) {
        if (emoticon.png.length == 0) continue;
        NSString *pngPath = [path stringByAppendingPathComponent:emoticon.png];
        if (emoticon.chs) dic[emoticon.chs] = pngPath;
        if (emoticon.cht) dic[emoticon.cht] = pngPath;
    }
    
    NSArray *folders = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *folder in folders) {
        if (folder.length == 0) continue;
        NSDictionary *subDic = [self _emoticonDicFromPath:[path stringByAppendingPathComponent:folder]];
        if (subDic) {
            [dic addEntriesFromDictionary:subDic];
        }
    }
    return dic;
}
                          
                          
+ (UIImage *)imageWithPath:(NSString *)path {
      if (!path) return nil;
          UIImage *image;
      if (path.pathScale == 1) {
          // 查找 @2x @3x 的图片
          NSArray *scales = [NSBundle preferredScales];
          for (NSNumber *scale in scales) {
              image = [UIImage imageWithContentsOfFile:[path stringByAppendingPathScale:scale.floatValue]];
              if (image) break;
          }
      } else {
          image = [UIImage imageWithContentsOfFile:path];
      }

      return image;
  }


@end
