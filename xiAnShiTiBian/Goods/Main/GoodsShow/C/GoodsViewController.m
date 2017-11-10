 //
//  GoodsViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/21.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "GoodsViewController.h"
#import "TitleCViewCell.h"//展示图片
#import "GoodsShowCViewCell.h"//竖向cell
#import "HGSCViewCell.h"//横向cell
#import "SearchBoxView.h"
#import "RankingCVCell.h"//排行榜
#import "CXSearchController.h"

@interface GoodsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching, HGSCViewCellDelegate, SearchBoxViewDelegate, RankingCVCellDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)UIView *TopView;//自定义导航条

@property (nonatomic, strong)CAGradientLayer *gradientLayer;
//搜搜框样式
@property (nonatomic, strong)SearchBoxView * searchBoxView;

/**
 *推荐商品数据数组
 */
@property (nonatomic, strong)NSMutableArray *recommendGoodsArray;
/**
 *店铺排行数据数组
 */
@property (nonatomic, strong)NSMutableArray *storeRankingArray;

@end

@implementation GoodsViewController


- (NSMutableArray *)recommendGoodsArray {
    if (!_recommendGoodsArray) {
        _recommendGoodsArray = [NSMutableArray array];
    }
    return _recommendGoodsArray;
}

- (NSMutableArray *)storeRankingArray {
    if (!_storeRankingArray) {
        _storeRankingArray = [NSMutableArray array];
    }
    return _storeRankingArray;
}

//店铺排行展示数据请求
- (void)storeRankingDataRequest:(NSInteger)index{
    __weak GoodsViewController *VC = self;
    
   // [self performSelector:@selector(indeterminateExample)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  //  [self performSelector:@selector(delayMethod)];
    [_collectionView.mj_header endRefreshing];
    });
    NSString *URL_Str;
    if (index == 0) {
        URL_Str = [NSString stringWithFormat:@"%@/storeapi/findStoreList", kSHY_100];
    }
    if (index == 1) {
        URL_Str = [NSString stringWithFormat:@"%@/storeapi/findStoreList?credit=0", kSHY_100];
    }
    URL_Str=[URL_Str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //NSLog(@"storeRankingDataRequest%@", str);
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:URL_Str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *stateStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
      //  NSLog(@"task%@responseObject%@",task, responseObject);
      //  [VC performSelector:@selector(delayMethod)];
        [_collectionView.mj_header endRefreshing];
        if ([stateStr isEqualToString:@"1"]) {
            [self.storeRankingArray removeAllObjects];
            [VC AnalyticalStoreRankingDataData:responseObject];
        }else {
            [VC showAlert:@"店铺排行信息获取失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      //  [VC performSelector:@selector(delayMethod)];
        NSLog(@"error%@",error);
        
        [VC showAlert:@"数据请求失败,请重试!"];
    }];
}
//店铺排行数据解析
- (void)AnalyticalStoreRankingDataData:(NSDictionary *)data {
    [self.storeRankingArray removeAllObjects];
    NSArray *dataArray = data[@"data"];
    NSMutableArray *StorList = [NSMutableArray array];
    for (NSDictionary *storeDic in dataArray) {
    
        NSEntityDescription *des = [NSEntityDescription entityForName:@"StoreRankingListModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        StoreRankingListModel *GDModel = [[StoreRankingListModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        
        for (NSString *key in storeDic) {
            [GDModel setValue:storeDic[key] forKey:key];
        }
        [self.storeRankingArray addObject:GDModel];
    }
    [self.collectionView reloadData];
}
//商品推荐数据请求
- (void)goodsRecommendDataRequest{

    NSString *str=[NSString stringWithFormat:@"%@/goods/api/findRecommendGoods", kSHY_100];
    NSLog(@"goodsRecommendDataRequest%@", str);
    __block GoodsViewController *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //[VC performSelector:@selector(delayMethod)];
        NSString *stateStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([stateStr isEqualToString:@"1"]) {
        [VC AnalyticalRecommendGoodsData:responseObject];
        }else {
            [VC showAlert:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       // [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"网络有问题请重试!"];
    }];
}
//商品推荐数据解析
- (void)AnalyticalRecommendGoodsData:(NSDictionary *)data {
    [self.recommendGoodsArray removeAllObjects];
    NSArray *array = data[@"data"];
   // [self managedContext];
    
    for (NSDictionary *dataDic in array) {//获取商品
        NSEntityDescription *des = [NSEntityDescription entityForName:@"GoodsDetailsModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        GoodsDetailsModel *GDModel = [[GoodsDetailsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        
        NSDictionary *goodsDetailsDic = dataDic[@"goods"];
        
        for (NSString *key in goodsDetailsDic) {//获取商品里面参数
          //   NSLog(@"goodsDetailsDic%@--------%@", goodsDetailsDic[key], key);
            if ([key isEqualToString:@"provinceName"]||[key isEqualToString:@"goodsShow"]||[key isEqualToString:@"provinceId"]||[key isEqualToString:@"goodsStoreState"]||[key isEqualToString:@"updateTimeStr"]||[key isEqualToString:@"esPrice"]||[key isEqualToString:@"goodsClick"]||[key isEqualToString:@"goodsColImg"]||[key isEqualToString:@"specId"]||[key isEqualToString:@"goodsSerial"]) {
            }else {
                [GDModel setValue:goodsDetailsDic[key] forKey:key];
            }
        }
        [self.recommendGoodsArray addObject:GDModel];
    }
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.translucent = YES;
    [super.navigationController setNavigationBarHidden:YES];
    [self goodsRecommendDataRequest];
    [self storeRankingDataRequest:0];
}

-(void)viewWillDisappear:(BOOL)animated {

    [self performSelector:@selector(delayMethod)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化我们需要改变背景色的UIView，并添加在视图上
    [self setCollectionView];
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"bgtouming"];
    [self.view addSubview:imageView];
    imageView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view , 0).rightSpaceToView (self.view, 0).heightIs(64);
    UIButton *scanningBtn = [UIButton new];
    [scanningBtn setImage:[UIImage imageNamed:@"sis"] forState:(UIControlStateNormal)];
    [scanningBtn addTarget:self action:@selector(handleScanningBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:scanningBtn];
    scanningBtn.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, 22).widthIs(kFit(41)).heightIs(34);
    
    UIButton *messageBtn = [UIButton new];
  //  [messageBtn setImage:[UIImage imageNamed:@"more"] forState:(UIControlStateNormal)];
   // [messageBtn addTarget:self action:@selector(handleMessageBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:messageBtn];
    messageBtn.sd_layout.rightSpaceToView(self.view, 0).topSpaceToView(self.view, 22).widthIs(kFit(41)).heightIs(34);
    
    self.searchBoxView = [SearchBoxView new];
    _searchBoxView.Delegate = self;
    [self.view addSubview:_searchBoxView];
    _searchBoxView.sd_layout.leftSpaceToView(scanningBtn, kFit(3)).topSpaceToView(self.view, 22).rightSpaceToView(messageBtn, kFit(3)).heightIs(kFit(34));
    
}
//扫一扫按钮
- (void)handleScanningBtn {
    
    ScanViewController *VC = [[ScanViewController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
}
//消息按钮
- (void)handleMessageBtn {

    
    
}
//搜索框点击事件
- (void)SearchJump {
    
    CXSearchController  *VC = [[CXSearchController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)setCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //添加页眉
     // [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.sectionInset = UIEdgeInsetsMake(-20, 10, 0, 10);//设置页眉的高度
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    layout.headerReferenceSize = CGSizeMake(kScreen_widht, 60);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) collectionViewLayout:layout];
    _collectionView .dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
    [self.collectionView registerClass:[GoodsShowCViewCell class] forCellWithReuseIdentifier:@"GoodsShowCViewCell"];
    [self.collectionView registerClass:[TitleCViewCell class] forCellWithReuseIdentifier:@"TitleCViewCell"];
    [self.collectionView registerClass:[HGSCViewCell class] forCellWithReuseIdentifier:@"HGSCViewCell"];
    [self.collectionView registerClass:[RankingCVCell class] forCellWithReuseIdentifier:@"RankingCVCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];//注册也页眉视图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];//注册页脚视图
    
    
    NSMutableArray * arrayM = [NSMutableArray array];
    for (int i = 0; i < 13; i ++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d",i + 1]];
        [arrayM addObject:image];
    }
    __weak GoodsViewController *VC = self;
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [VC refresh];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    
    // 设置普通状态下的动画图片  -->  静止的一张图片
    NSArray * normalImagesArray = @[[UIImage imageNamed:@"refresh1"]];
    [header setImages:normalImagesArray forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片
    [header setImages:arrayM forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:arrayM forState:MJRefreshStateRefreshing];
    
    // 设置header
    self.collectionView.mj_header = header;
    
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_footer endRefreshing];
            self.collectionView.mj_footer.automaticallyHidden = YES;
        });
    }];

    
    [footer setImages:arrayM forState:MJRefreshStatePulling];
    [footer setImages:arrayM forState:MJRefreshStateRefreshing];
    // 设置header
    self.collectionView.mj_footer = footer;

    
}
- (void)refresh {
    
    [self goodsRecommendDataRequest];
    [self storeRankingDataRequest:0];

}
- (UIStatusBarStyle)preferredStatusBarStyle { //改变状态条颜色
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0 || section == 1|| section == 2) {
        return 1;
    } else {
        return 5;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        TitleCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TitleCViewCell" forIndexPath:indexPath];
        
        return cell;
    }else if (indexPath.section == 1){
        
        RankingCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RankingCVCell" forIndexPath:indexPath];
        cell.storeArray = self.storeRankingArray;
        cell.delegate = self;
        return cell;
        
    } if (indexPath.section == 2) {
        HGSCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HGSCViewCell" forIndexPath:indexPath];
        cell.dataArray = self.recommendGoodsArray;
        cell.delegate = self;
        return cell;
    }
    else {

        GoodsShowCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsShowCViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor ];
        return cell;
        
    }
}
//横向滑动cell 的单击事件 跳转商品详情界面
- (void)CellOption:(NSInteger)index {
    
    GoodsDetailsVController *VC = [[GoodsDetailsVController alloc] init];
    
    GoodsDetailsModel *model = self.recommendGoodsArray[index];
    
    VC.goodsID =  model.goodsId;
    [VC setHidesBottomBarWhenPushed:YES];//隐藏分栏
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 || indexPath.section == 0) {
    }else {
        
    GoodsDetailsVController *VC = [[GoodsDetailsVController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
    }
}
//返回页眉 页脚
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
       if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        if (indexPath.section == 2) {
               titleLabel.text = @"推荐商品";
        }else if(indexPath.section == 3) {
               titleLabel.text = @"热门商品";
    }
        [headerView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(headerView, kFit(10)).topSpaceToView(headerView, kFit(20)).widthIs(kScreen_widht).heightIs(kFit(20));
        return headerView;
       }else {
           UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
           footerview.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
           return footerview;
       
       }
}
//单独返回每一个页眉视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    if (section == 0 || section == 1) {
        return CGSizeMake(0, 0);
        } else {
        return CGSizeMake(kScreen_widht, kFit(60));
    }
}
//单独返回每一个页脚视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section==3) {
        return CGSizeMake(0, 0);
    }else {
        return CGSizeMake(kScreen_widht, kFit(10));
    }
}
//返回每个cell的布局左右上下间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(-kFit(20), 0, 0, 0);
    } else if (section == 1){
        return  UIEdgeInsetsMake(0, 0, kFit(20), 0);
    } if (section == 2) {
        return  UIEdgeInsetsMake(0, 0, kFit(10), 0);
    } else {
        return  UIEdgeInsetsMake(0, kFit(10), 0, kFit(10));
    }
}
//单独返回每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(kScreen_widht, kScreen_widht *0.5333);
    }if (indexPath.section == 1) {
        return CGSizeMake(kScreen_widht, kFit(190));
    } if (indexPath.section == 2) {
        return CGSizeMake(kScreen_widht, kFit(240));
    } else {
        return CGSizeMake(kScreen_widht/2-12, kFit(260));
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark -- RankingCVCellDelegate  店铺排行的代理
//跳转至店铺界面/
- (void)ChooseRankingStores:(int)index {
    
    StoreRankingListModel *model = self.storeRankingArray[index];
    StoreViewController *VC = [[StoreViewController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    VC.storeStr = model.storeId;
    [self.navigationController pushViewController:VC animated:YES];
}
//选择店铺排行类型
- (void)RankingStoreType:(int)StoreType {
    
    [self storeRankingDataRequest:StoreType];
    
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



//显示网络加载指示器
- (void)indeterminateExample {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
}
//隐藏网络加载指示器
- (void)delayMethod{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
}
 
@end
