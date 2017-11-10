
//
//  SearchGoodsVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/28.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "SearchGoodsVC.h"
#import "VendorAllGoodsCVCell.h"
#import "SCSNAView.h"//搜索
#import "SearchGoodsSortingView.h"
@interface SearchGoodsVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching, SCSNAViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)SCSNAView *navigationView;

@property (nonatomic, strong)SearchGoodsSortingView *sortingView;
@property (nonatomic, strong)NSMutableArray *goodsArray;
/**
 *codedata所需的对象
 */
@end

@implementation SearchGoodsVC

- (NSMutableArray *)goodsArray {
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}


- (NSArray *)searchResultArray {
    if (!_searchResultArray) {
        _searchResultArray = [NSArray array];
    }
    return _searchResultArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCollectionView];
    [self parsingStoreData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:YES];
}

- (void)parsingStoreData{
    
    for (NSDictionary *dic in self.searchResultArray) {

        NSEntityDescription *des = [NSEntityDescription entityForName:@"GoodsDetailsModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        GoodsDetailsModel *model = [[GoodsDetailsModel  alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        
            for (NSString *key in dic) {
                NSLog(@"dic.key%@  key%@",dic[key], key);
                [model setValue:dic[key] forKey:key];
            }
    
        [self.goodsArray addObject:model];
    }
    [self.collectionView reloadData];
}

- (void)setCollectionView {
    
    self.navigationView = [[SCSNAView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, 64)];
    self.navigationView.delegate = self;
    [self.view addSubview:_navigationView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //添加页眉
    // [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.sectionInset = UIEdgeInsetsMake(-20, 10, 0, 10);//设置页眉的高度
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(kScreen_widht, kFit(15));
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + kFit(43), kScreen_widht, kScreen_heigth-64) collectionViewLayout:layout];
    _collectionView .dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[VendorAllGoodsCVCell class] forCellWithReuseIdentifier:@"VendorAllGoodsCVCell"];
    [self.view addSubview:_collectionView];
    
    self.sortingView = [[SearchGoodsSortingView alloc] initWithFrame:CGRectMake(0, 64, kScreen_widht, kFit(43))];
    [self.view addSubview:_sortingView];
    NSArray *sortRuleArray=@[@"全部",@"价格",@"评分",@"最新", @"测试"];
    self.sortingView.menuDataArray = [NSMutableArray arrayWithObjects:sortRuleArray, nil];
//_sortingView
    //__weak typeof(self) _self = self;
    
    [self.sortingView setHandleSelectDataBlock:^(NSString *selectTitle, NSUInteger selectIndex, NSUInteger selectButtonTag) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"selectTitle = %@\n selectIndex = @%lu\n selectButtonTag = @%lu",selectTitle,selectIndex,selectButtonTag]);
        
    }];

    
}

#pragma mark SCSNAViewDelegate  导航条代理
- (void)SelectedObjects:(int)index {
    if (index != 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        MessageViewController *VC = [[MessageViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VendorAllGoodsCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VendorAllGoodsCVCell" forIndexPath:indexPath];
    cell.model = self.goodsArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailsModel *model = self.goodsArray[indexPath.row];
    GoodsDetailsVController *VC = [[GoodsDetailsVController alloc] init];
    VC.goodsID = model.goodsId;
    [self.navigationController pushViewController:VC animated:YES];
}
//返回每个cell的布局左右上下间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return  UIEdgeInsetsMake(0, 12, 0, 12);
}
//单独返回每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreen_widht-kFit(29))/2, kFit(260));
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
