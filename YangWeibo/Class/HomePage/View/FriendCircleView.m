//
//  FriendCircleView.m
//  YangWeibo
//
//  Created by He yang on 16/5/15.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "FriendCircleView.h"
#import "FriendCircleCell.h"

@interface FriendCircleView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)NSMutableArray *cellTextArray;
@property (nonatomic,copy)NSArray *sectionTitleArray;
@end
@implementation FriendCircleView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        [self addSubview:self.tableView];
        
        self.backgroundColor = [UIColor clearColor];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"userinfo_relationship_indicator_arrow_up"];
        [_imageView sizeToFit];
        _imageView.bottom = self.tableView.top ;
        _imageView.centerX = self.tableView.centerX;
        [self addSubview:_imageView];
        
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, self.width, self.height - 10) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor blackColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

-(NSMutableArray *)cellTextArray{
    
    if (!_cellTextArray) {
        _cellTextArray = [NSMutableArray array];
        NSArray *array1 = [NSArray arrayWithObjects:@"首页",@"好友圈",@"群微博",nil];
        NSArray *array2 = [NSArray arrayWithObjects:@"特别关注",@"同学",@"名人明星",nil];
        NSArray *arrar3 = [NSArray arrayWithObject:@"周边微博"];
        [_cellTextArray addObject:array1];
        [_cellTextArray addObject:array2];
        [_cellTextArray addObject:arrar3];

    }
    
    return _cellTextArray;
}

-(NSArray *)sectionTitleArray{
    if (!_sectionTitleArray) {
        
        _sectionTitleArray = [NSArray arrayWithObjects:@"",@"我的分组",@"其他",nil];
    }
    return _sectionTitleArray;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        default:
            return 0;
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"FriendCircleCell";
    FriendCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FriendCircleCell alloc] init];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSArray *tmpArray = self.cellTextArray[indexPath.section];
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.likeImageView.image =  [UIImage imageNamed:@"friendcircle_compose_friendcirclebutton"];
    }else{
        cell.likeImageView.image = nil;
    }
    
    cell.titleLabel.text = tmpArray[indexPath.row];
    [cell layoutIfNeeded];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return section == 0 ? 0.1 : 20;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.sectionTitleArray[section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
