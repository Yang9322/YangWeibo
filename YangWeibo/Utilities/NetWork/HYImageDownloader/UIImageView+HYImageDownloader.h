//
//  UIImageView+HYImageDownloader.h
//  HYImageDownloader
//
//  Created by He yang on 16/5/1.
//  Copyright © 2016年 He yang. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSInteger,HYImageDowloaderOptions) {
    HYImageDowloaderOptionNone = 1 << 0,//Default no option
    HYImageDowloaderOptionFadeAnimation = 1 << 1,//When download image successfully,add a fade animation to image
    HYImageDowloaderOptionRoundedRect = 1 << 2, //When download image successfully,clip the imageView with cornerRadius
   //To be continued ...
};

@interface UIImageView (HYImageDownloader)


- (void)hy_setImageWithURLString:(NSString *)URLString;


- (void)hy_setImageWithURLString:(NSString *)URLString placeHolder:(UIImage *)placeHolder options:(HYImageDowloaderOptions) options;


- (void)hy_setImageWithRequest:(NSURLRequest *)request placeHolder:(UIImage *)placeHolder options:(HYImageDowloaderOptions) options;

- (void)cancelImageDownloadTask;

@end
