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
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.size = CGSizeMake(10, 10);
        _imageView.bottom = self.tableView.top + 3 ;
        _imageView.centerX = self.tableView.centerX;
        _imageView.backgroundColor = [UIColor clearColor];
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
        _tableView.backgroundColor = HYColor(111, 111, 111);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.contentInset = UIEdgeInsetsMake(0, 10, 0, -10);
        
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


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DIDSelectFriendRelationCellNotification object:nil];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return nil;
            break;
        case 1:{
            return [self configureHeaderViewWithTitle:@"我的分组"];
        }
            break;
        case 2:{
            return [self configureHeaderViewWithTitle:@"其他"];

        }
            break;
        default:
            break;
    }
    return nil;

    
}


- (UIView *)configureHeaderViewWithTitle:(NSString *)title{

    CGColorRef color = HYColor(30, 30, 30).CGColor;;
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
    CALayer *layer1 = [CALayer layer];
    layer1.backgroundColor = color;
    layer1.frame = CGRectMake(0, view.height / 2, 20, 1/[UIScreen mainScreen].scale);
    [view.layer addSublayer:layer1];
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:10];
    [label sizeToFit];
    label.center = CGPointMake(20+label.width / 2, view.height / 2);
    [view addSubview:label];
    CALayer *layer2 = [CALayer layer];
    layer2.backgroundColor = color;
    layer2.frame = CGRectMake(label.right, view.height / 2, self.width- label.right, 1/[UIScreen mainScreen].scale);
    [view.layer addSublayer:layer2];
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
