//
//  SearchStoreVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/3.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SearchStoreVC.h"
#import "SCSNAView.h"//搜索
#import "SearchStoreTVCell.h"
#import "SearchStoreSortingView.h"
@interface SearchStoreVC ()<SCSNAViewDelegate, UITableViewDelegate, UITableViewDataSource, SearchStoreTVCellDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)SCSNAView *navigationView;
@property (nonatomic, strong)SearchStoreSortingView *sortingView;
@property (nonatomic, strong)NSMutableArray *storeArray;
/**
 *codedata所需的对象
 */
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)AppDelegate *delegate;
@end

@implementation SearchStoreVC

- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {

        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedContext =  delegate.managedObjectContext;
    }
    return _managedContext;
}

- (AppDelegate *)delegate {
    if (!_delegate) {
        _delegate = [[AppDelegate alloc] init];
    }
    return _delegate;
}

- (NSArray *)searchResultArray {
    if (!_searchResultArray) {
        _searchResultArray = [NSArray array];
    }
    return _searchResultArray;
}
- (NSMutableArray *)storeArray {
    if (!_storeArray) {
        _storeArray = [NSMutableArray array];
    }
    return _storeArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)parsingStoreData{
    
    for (NSDictionary *dic in self.searchResultArray) {

        NSEntityDescription *des = [NSEntityDescription entityForName:@"SellerDataModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        SellerDataModel *model = [[SellerDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        
        for (NSString *key in dic) {
            
                [model setValue:dic[key] forKey:key];
        }
        [self.storeArray addObject:model];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self parsingStoreData];
    self.view.backgroundColor = MColor(238, 238, 238);
    
     [self setCollectionView];
}
- (void)viewWillAppear:(BOOL)animated {

    [super.navigationController setNavigationBarHidden:YES];
    
}



- (void)setCollectionView {
    
    self.navigationView = [[SCSNAView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, 64)];
    self.navigationView.delegate = self;
    [self.view addSubview:_navigationView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kFit(43 )+ 64, kScreen_widht, kScreen_heigth - kFit(43)-64) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = MColor(238, 238, 238);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SearchStoreTVCell class] forCellReuseIdentifier:@"SearchStoreTVCell"];
    [self.view addSubview:self.tableView];
    
    self.sortingView = [[SearchStoreSortingView alloc] initWithFrame:CGRectMake(0, 64, kScreen_widht, kFit(43))];
    
    [self.view addSubview:_sortingView];
    NSArray *sortRuleArray=@[@"全部",@"销量",@"点击率",@"打折", @"测试"];
    self.sortingView.menuDataArray = [NSMutableArray arrayWithObjects:sortRuleArray, nil];
    
    [self.sortingView setHandleSelectDataBlock:^(NSString *selectTitle, NSUInteger selectIndex, NSUInteger selectButtonTag) {
        NSLog(@"%@",[NSString stringWithFormat:@"selectTitle = %@\n selectIndex = @%lu\n selectButtonTag = @%lu",selectTitle,(unsigned long)selectIndex,selectButtonTag]);
    }];
}
#pragma mark SCSNAViewDelegate
- (void)SelectedObjects:(int)index {
    if (index != 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        MessageViewController *VC = [[MessageViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.storeArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchStoreTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchStoreTVCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = self.storeArray[indexPath.row];
    [cell ToControlGiveTag:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//进入商店
- (void)entranceStore:(OrderBtn *)sender {
    SellerDataModel *model = self.storeArray[sender.indexPath.section];
    StoreViewController *VC = [[StoreViewController alloc] init];
    VC.storeStr = model.storeId;
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerDataModel *model = self.storeArray[indexPath.section];
    StoreViewController *VC = [[StoreViewController alloc] init];
    VC.storeStr = model.storeId;
    [self.navigationController pushViewController:VC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return kFit(220);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return kFit(10);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kFit(10))];
    view.backgroundColor = MColor(238, 238, 238);
    return view;
    


}


@end
