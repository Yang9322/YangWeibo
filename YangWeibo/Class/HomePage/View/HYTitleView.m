//
//  HYTitleView.m
//  YangWeibo
//
//  Created by He yang on 16/5/15.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "HYTitleView.h"

#define kImageViewWidth 20

@interface HYTitleView ()

@property (nonatomic,strong)UILabel *textLabel;

@property (nonatomic,strong)UIImageView *markImageView;

@end

@implementation HYTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.text = @"好友圈";
        [_textLabel sizeToFit];
        
        [self addSubview:_textLabel];
        _markImageView = [[UIImageView alloc] init];
        _markImageView.contentMode = UIViewContentModeCenter;
        _markImageView.image = [UIImage imageNamed:@"navigationbar_arrow_down@2x"];
        [_markImageView sizeToFit];
        [self addSubview:_markImageView];
     

        [self addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
        
    
    }
    return self;
}


#pragma mark - Actions

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = HYColor(230, 230, 230);
    } completion:^(BOOL finished) {
        self.backgroundColor = [UIColor clearColor];
    }];
}




- (void)tapped{

    self.selected = !self.selected;
 
    _markImageView.image = self.selected ? [UIImage imageNamed:@"navigationbar_arrow_up@2x"] : [UIImage imageNamed:@"navigationbar_arrow_down"];
    
    
    if (_tappedBlock) {
        _tappedBlock(self.selected);
    }
    
    
    
}


#pragma mark -----


-(void)layoutSubviews{
    
    CGFloat totalWith = _textLabel.width + _markImageView.width;
    _textLabel.origin = CGPointMake(self.width / 2 - totalWith / 2, self.height / 2 - _textLabel.height / 2);
    _markImageView.center = CGPointMake(_textLabel.right + _markImageView.width / 2 + 5, self.height / 2);
    [super layoutSubviews];

    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
