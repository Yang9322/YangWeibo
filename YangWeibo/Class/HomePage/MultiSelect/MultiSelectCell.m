//
//  MultiSelectCell.m
//  YangWeibo
//
//  Created by heyang on 16/7/25.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "MultiSelectCell.h"


@interface MultiSelectCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MultiSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)stateButtonClicked:(id)sender {
    UIButton *button = sender;
    button.selected = !button.selected;
    if (_cellDelegate && [_cellDelegate respondsToSelector:@selector(didClickCell:state:)]) {
        
        [_cellDelegate didClickCell:self state:button.selected];
    }
    
}

-(void)setModel:(MultiSelectModel *)model{
    _model = model;
    _avatarView.image = model.image;
    _nameLabel.text = model.name;
}

-(void)setShouldCornerRadius:(BOOL)shouldCornerRadius{
    _shouldCornerRadius = shouldCornerRadius;
    
    if (_shouldCornerRadius) {
        _avatarView.layer.cornerRadius = _avatarView.width / 2;
        _avatarView.layer.masksToBounds = YES;
    }
}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    
////     NSLog(@"begin---%@---end",[NSValue valueWithCGPoint:point]);
//    CGRect rect = self.contentView.bounds;
//    
//    if (CGRectContainsPoint(rect, point) ) {
//        return _stateButton;
//    }
//    
//    return nil;
//
//}

@end
