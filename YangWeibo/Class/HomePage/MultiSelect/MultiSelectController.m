//
//  MultiSelectController.m
//  YangWeibo
//
//  Created by heyang on 16/7/24.
//  Copyright © 2016年 He yang. All rights reserved.
//

#import "MultiSelectController.h"
#import "UIView+YT.h"
#import "MultiSelectHeadView.h"
#import "MultiSelectCell.h"
@interface MultiSelectController ()<UITableViewDelegate,UITableViewDataSource,MultiSelectCellProtocol,MultiSelectHeadViewProtocol>
@property (nonatomic,strong)MultiSelectHeadView *headView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *selectedArray; //被选中的数组
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *sectionArray; //section数组
@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;//标题数组
@end

@implementation MultiSelectController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self genDataWithCount:30];
    [self configureHeadView];
    [self configureTableView];
    _selectedArray = [NSMutableArray array];
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[[UIImage imageNamed:@"navigationbar_icon_radar@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:@"navigationbar_icon_radar_highlighted@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(refreshData:model:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChooseSearchResult:) name:@"DidChooseSearchResult" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configureHeadView{
    MultiSelectHeadView *headView = [[MultiSelectHeadView alloc] initWithFrame:CGRectMake(0, 64, ScreeW, 60)];
    headView.shouldCornerRadius = _shouldCornerRadius;
    headView.headViewDelegate = self;
    headView.dataArray = self.dataArray;
    [self.view addSubview:headView];
    _headView = headView;
    
}


- (void)configureTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headView.bottom, ScreeW, ScreeH - _headView.bottom) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)refreshData:(BOOL)state model:(MultiSelectModel *)model{
     [_headView refreshSubviewsWithState:state model:model];
}


- (void)DidChooseSearchResult:(NSNotification *)notification{
    
    MultiSelectModel *model = notification.object;
       model.selectedState = YES;
    [_selectedArray addObject:model];
    [self refreshData:YES model:model];

}


#pragma mark - Setter
-(void)setShouldCornerRadius:(BOOL)shouldCornerRadius{
    _shouldCornerRadius = shouldCornerRadius;
}


#pragma mark - Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_headView.searchBar resignFirstResponder];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSMutableArray *array = self.dataSource[section];
    return [self.sectionArray[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitlesArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"MultiSelectCell";
    MultiSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MultiSelectCell" owner:nil options:nil] lastObject];
        cell.cellDelegate = self;
    }
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    MultiSelectModel *model = self.sectionArray[section][row];
    cell.model = model;
    cell.model.cellIndexPath = indexPath;
    cell.shouldCornerRadius = _shouldCornerRadius;
    cell.stateButton.selected = model.selectedState;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    MultiSelectModel *model = self.sectionArray[section][row];
    model.selectedState = !model.selectedState;
    MultiSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.stateButton.selected = model.selectedState;
    if (model.selectedState) {
        [_selectedArray addObject:cell.model];
    }else{
        [_selectedArray removeObject:cell.model];
    }
    [self refreshData:model.selectedState model:cell.model];

    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitlesArray objectAtIndex:section];
}


- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionTitlesArray;
}

#pragma mark - MultiSelectCellDelegate

-(void)didClickCell:(MultiSelectCell *)cell state:(BOOL)state{
    if (state) {
        cell.model.selectedState = YES;
        [_selectedArray addObject:cell.model];
    }else{
        cell.model.selectedState = NO;
        [_selectedArray removeObject:cell.model];
    }
    
    [self refreshData:state model:cell.model];
    
}

#pragma mark - HeadViewDelegate
-(void)didClickedWithModel:(MultiSelectModel *)model{
    MultiSelectCell *cell = [_tableView cellForRowAtIndexPath:model.cellIndexPath];
    cell.model.selectedState = NO;
    cell.stateButton.selected = NO;
    [_selectedArray removeObject:model];
  
    
}


#pragma mark - Generate DataSource
-(NSMutableArray<MultiSelectModel *> *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i <4; i ++) {
            NSMutableArray *arry = [NSMutableArray array];
            for (int i = 0; i < 5; i ++) {
                MultiSelectModel *model = [[MultiSelectModel alloc] init];
                model.name = @"yang";
                model.image = [UIImage imageNamed:@"tabbar_profile@2x"];
                [arry addObject:model];
            }
            [_dataSource addObject:arry];
        }
        
    }
    return _dataSource;
}


- (void)genDataWithCount:(NSInteger)count
{
    _dataArray = [NSMutableArray array];
    NSArray *xings = @[@"赵",@"钱",@"孙",@"李",@"周",@"吴",@"郑",@"王",@"冯",@"陈",@"楚",@"卫",@"蒋",@"沈",@"韩",@"杨"];
    NSArray *ming1 = @[@"大",@"美",@"帅",@"应",@"超",@"海",@"江",@"湖",@"春",@"夏",@"秋",@"冬",@"上",@"左",@"有",@"纯"];
    NSArray *ming2 = @[@"强",@"好",@"领",@"亮",@"超",@"华",@"奎",@"海",@"工",@"青",@"红",@"潮",@"兵",@"垂",@"刚",@"山"];
    NSArray *pinyin1 = @[@"a",@"b",@"c",@"d",@"e",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q"];
    NSArray *pinyin2 = @[@"a",@"b",@"c",@"d",@"e",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q"];

    for (int i = 0; i < count; i++) {
        NSString *name = xings[arc4random_uniform((int)xings.count)];
        NSString *ming = ming1[arc4random_uniform((int)ming1.count)];
        NSString *pin1 = pinyin1[arc4random_uniform((int)pinyin1.count)];
        NSString *pin2 = pinyin2[arc4random_uniform((int)pinyin2.count)];
        pin1 = [pin1 stringByAppendingString:pin2];
        name = [name stringByAppendingString:ming];
        if (arc4random_uniform(10) > 3) {
            NSString *ming = ming2[arc4random_uniform((int)ming2.count)];
            name = [name stringByAppendingString:ming];
        }
        MultiSelectModel *model = [[MultiSelectModel alloc] init];
        model.name = name;
        model.pinyinName = pin1;
        model.abbreviationName = @"uw";
        model.image = [UIImage imageNamed:@"tabbar_profile@2x"];
        [self.dataArray addObject:model];
    }
    
    
    
    [self setUpTableSection];
}


- (void) setUpTableSection {
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    //create a temp sectionArray
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray =  [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index<numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc]init]];
    }
    
    // insert Persons info into newSectionArray
    for (MultiSelectModel *model in self.dataArray) {
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(name)];
        [newSectionArray[sectionIndex] addObject:model];
    }
    
    //sort the person of each section
    for (NSUInteger index=0; index<numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(name)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    self.sectionTitlesArray = [NSMutableArray new];
    
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        } else {
            [self.sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [newSectionArray removeObjectsInArray:temp];
    
//    NSMutableArray *operrationModels = [NSMutableArray new];
//    NSArray *dicts = @[@{@"name" : @"新的朋友", @"imageName" : @"plugins_FriendNotify"},
//                       @{@"name" : @"群聊", @"imageName" : @"add_friend_icon_addgroup"},
//                       @{@"name" : @"标签", @"imageName" : @"Contact_icon_ContactTag"},
//                       @{@"name" : @"公众号", @"imageName" : @"add_friend_icon_offical"}];
//    for (NSDictionary *dict in dicts) {
//        MultiSelectModel *model = [SDContactModel new];
//        model.name = dict[@"name"];
//        model.imageName = dict[@"imageName"];
//        [operrationModels addObject:model];
//    }
//    
//    [newSectionArray insertObject:operrationModels atIndex:0];
//    [self.sectionTitlesArray insertObject:@"" atIndex:0];
    
    self.sectionArray = newSectionArray;
    
}

@end
