//
//  ShopGoodsListVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/27.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShopGoodsListVC.h"
#import "ClassificationView.h"
#import "GoodsShowCViewCell.h"
#import "AllGoodsCViewCell.h"
#import "StoreEmptyCVCell.h"
static int layout;

@interface ShopGoodsListVC ()<ClassificationViewDelegate, UICollectionViewDataSourcePrefetching, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

/**
 *店铺所有商品tableView;
 */
@property (nonatomic, strong)UICollectionView *AllGoodsCView;
/**
 *商品分类
 */
@property (nonatomic, strong)ClassificationView *classificationView;

@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@property (nonatomic, strong)AppDelegate *delegate;
@property (readonly, strong, nonatomic)NSManagedObjectContext *menagedObjectContext;
/**
 *存放商品的数组
 */
@property (nonatomic, strong)NSMutableArray *goodsArray;

@end

@implementation ShopGoodsListVC

- (NSMutableArray *)goodsArray {
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}
- (AppDelegate *)delegate {
    if (!_delegate) {
        _delegate = [[AppDelegate alloc] init];
    }
    return _delegate;
}

- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedContext =  delegate.managedObjectContext;
    }
    return _managedContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self storeGoodsDataRequest];
    [self setAllGoodsView];
}

//店铺商品数据请求
- (void)storeGoodsDataRequest{
    
    NSString * URL_Str = [NSString stringWithFormat:@"%@/storeapi/storegoods",kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"storeId"] = self.storeID;
    __block ShopGoodsListVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"storeGoodsDataRequest%@", responseObject);
        NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([str isEqualToString:@"1"]) {
            [VC AnalyticalstoreGoodsData:responseObject];
        }else {
            [VC showAlert:@"商品请求失败,请重试"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"网络请求超时请重试"];
    }];
}

- (void)AnalyticalstoreGoodsData:(NSDictionary *)data {
    
    NSArray *DataArray = data[@"data"];
    //NSLog(@"DataArray%@", DataArray);
    for (NSDictionary *goodsDic in DataArray) {
        NSEntityDescription *des = [NSEntityDescription entityForName:@"GoodsDetailsModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        GoodsDetailsModel *model = [[GoodsDetailsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        
        for (NSString *key in goodsDic) {
            
         
            [model setValue:goodsDic[key] forKey:key];
         
        }
        [self.goodsArray addObject:model];
    }
    
    [self.AllGoodsCView reloadData];
}

- (void)setAllGoodsView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //添加页眉
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    self.AllGoodsCView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth-40.5-64)collectionViewLayout:layout];//43是规格选择view 40.5是分页选择view 64 是导航条
    _AllGoodsCView.showsVerticalScrollIndicator = NO;
    _AllGoodsCView.showsHorizontalScrollIndicator = NO;
    _AllGoodsCView.dataSource = self;
    _AllGoodsCView.delegate = self;
    _AllGoodsCView.showsVerticalScrollIndicator = NO;
    self.AllGoodsCView.backgroundColor = MColor(238, 238, 238);
    [self.view addSubview:_AllGoodsCView];
    [self.AllGoodsCView registerClass:[GoodsShowCViewCell class] forCellWithReuseIdentifier:@"GoodsShowCViewCell"];
    [self.AllGoodsCView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.AllGoodsCView registerNib:[UINib nibWithNibName:@"StoreEmptyCVCell" bundle:nil] forCellWithReuseIdentifier:@"StoreEmptyCVCell"];
    [self.AllGoodsCView registerClass:[AllGoodsCViewCell class] forCellWithReuseIdentifier:@"AllGoodsCViewCell"];
    [self.AllGoodsCView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AllHeader"];//注册也页眉视图
    [self.AllGoodsCView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AllFooterView"];//注册页脚视图
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_goodsArray.count == 0) {
        return 3;
    }else {
        if (_goodsArray.count<4) {
            return 4;
        }else {
            return _goodsArray.count;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_goodsArray.count == 0) {
        if (indexPath.row == 0) {
            StoreEmptyCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreEmptyCVCell" forIndexPath:indexPath];
            
            return cell;

        }else {//因为我写的界面有bug 所以在商品为空时这段必须要有
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
            return cell;
        }
    }else {
        NSInteger row = _goodsArray.count;
        if (indexPath.row<row) {
             GoodsDetailsModel *model = _goodsArray[indexPath.row];
            GoodsShowCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsShowCViewCell" forIndexPath:indexPath];
            cell.model = model;
            return cell;
        }else {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
            return cell;
        }
    }
}

//cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailsVController *VC = [[GoodsDetailsVController alloc] init];
    GoodsDetailsModel *model = self.goodsArray[indexPath.row];
    VC.goodsID = model.goodsId;
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
}

//返回每个cell的布局左右上下间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (_goodsArray.count == 0) {
        return  UIEdgeInsetsMake(0, 0, 0, 0);
    }else {
        return  UIEdgeInsetsMake(10, 10, 0, 10);
    }
    
}
//单独返回每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_goodsArray.count == 0) {
        if (indexPath.row == 0) {
        return CGSizeMake(kScreen_widht, kScreen_widht);
        }else {
        return CGSizeMake(kScreen_widht/2-12, kFit(260));
        }
        
    }else {
        return CGSizeMake(kScreen_widht/2-12, kFit(260));
    }
}
//单独返回每一个页眉视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
        return CGSizeMake(0, 0);
}

//返回页眉 页脚
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"热门商品";
        [headerView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(headerView, 10).topSpaceToView(headerView, 20).widthIs(kScreen_widht).heightIs(20);
        
        return headerView;
    }else {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerview.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
        return footerview;
    }
}

#pragma mark -- ClassificationViewDelegate

- (void)btn_classification:(UIButton *)btn {
    if (btn.tag == 11004) {
        
        if (layout == 0) {
            layout = 1;
        }else {
            layout = 0;
        }
        [self.AllGoodsCView reloadData];
        
    }
}
//系统提示的弹出窗
- (void)timerFireMethod:(NSTimer*)theTimer {//弹出框
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}


@end
