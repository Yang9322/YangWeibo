//
//  HYFPSLabel.m
//  NIM
//
//  Created by He yang on 16/5/1.
//  Copyright © 2016年 He yang. All rights reserved.
//


#import "HYFPSLabel.h"

@implementation HYFPSLabel{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size = CGSizeMake(70, 20);
    }
    self = [super initWithFrame:frame];
    
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    
    _font = [UIFont fontWithName:@"Menlo" size:13];
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return self;
}

- (void)dealloc {
    [_link invalidate];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(70, 20);;
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    
    self.text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
}

@end
