
//
//  SearchVendorVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/14.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SearchVendorVC.h"
#import "SCSNAView.h"//搜索
#import "SearchVendorTVCell.h"

@interface SearchVendorVC ()<SCSNAViewDelegate, UITableViewDelegate, UITableViewDataSource, SearchVendorTVCellDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)SCSNAView *navigationView;

/**
 *codedata所需的对象
 */
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)AppDelegate *delegate;

@property (nonatomic, strong)NSMutableArray *vendorArray;

@end

@implementation SearchVendorVC
- (NSMutableArray *)vendorArray {
    if (!_vendorArray) {
        _vendorArray = [NSMutableArray array];
    }
    return _vendorArray;
}
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self parsingFactoryData];
    self.view.backgroundColor = MColor(238, 238, 238);
    [self setCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:YES];
}

- (void)parsingFactoryData{
    NSLog(@"self.searchResultArray%@", self.searchResultArray);
    for (NSDictionary *dic in self.searchResultArray) {
        NSEntityDescription *des = [NSEntityDescription entityForName:@"FactoryDataModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        FactoryDataModel *model = [[FactoryDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        for (NSString *key in dic) {
            if ([key isEqualToString:@"listStore"]) {
                NSArray *storeArray = dic[key];
                NSMutableArray *storeAddArray = [NSMutableArray array];
                for (NSDictionary *storeDic in storeArray) {
                    NSEntityDescription *des = [NSEntityDescription entityForName:@"SellerDataModel" inManagedObjectContext:self.managedContext];
                    //根据描述 创建实体对象
                    SellerDataModel *storeModel = [[SellerDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                    
                    for (NSString *storeKey in storeDic) {
                        [storeModel setValue:storeDic[storeKey] forKey:storeKey];
                    }
                    [storeAddArray addObject:storeModel];
                }
                [model setValue:storeAddArray forKey:key];
            }else if([key isEqualToString:@"listGoods"]){
                
                NSArray *goodsArray = dic[key];
                NSMutableArray *goodsAddArray = [NSMutableArray array];
                for (NSDictionary *goodsDic in goodsArray) {
                    NSEntityDescription *des = [NSEntityDescription entityForName:@"GoodsDetailsModel" inManagedObjectContext:self.managedContext];
                    //根据描述 创建实体对象
                    GoodsDetailsModel *goodsModel = [[GoodsDetailsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                    
                    for (NSString *goodsKey in goodsDic) {
                        [goodsModel setValue:goodsDic[goodsKey] forKey:goodsKey];
                    }
                    [goodsAddArray addObject:goodsModel];
                }
                [model setValue:goodsAddArray forKey:key];
                
            
            }else{
                [model setValue:dic[key] forKey:key];
            }
        }
        [self.vendorArray addObject:model];
    }
    [self.tableView reloadData];
}


- (void)setCollectionView {
    self.navigationView = [[SCSNAView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, 64)];
    self.navigationView.delegate = self;
    [self.view addSubview:_navigationView];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreen_widht, kScreen_heigth -64) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = MColor(238, 238, 238);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SearchVendorTVCell class] forCellReuseIdentifier:@"SearchVendorTVCell"];
    [self.view addSubview:self.tableView];
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
    return self.vendorArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchVendorTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchVendorTVCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = self.vendorArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VendorViewController *VC = [[VendorViewController alloc] init];
    VC.vendorArray = self.vendorArray;
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
