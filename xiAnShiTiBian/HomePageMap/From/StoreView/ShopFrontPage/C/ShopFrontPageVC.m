
//
//  ShopFrontPageVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/27.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShopFrontPageVC.h"
#import "GoodsShowCViewCell.h"
#import "SZCirculationImageView.h"
@interface ShopFrontPageVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching>
/**
 *店铺首页CollectionView;
 */
@property (nonatomic, strong)UICollectionView *ShopFrontPageCView;

@end

@implementation ShopFrontPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTCView];
}
/**
 *创建店铺首页
 */
- (void)setTCView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //添加页眉
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    layout.headerReferenceSize = CGSizeMake(kScreen_widht, 40);
    self.ShopFrontPageCView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth-64-40.5) collectionViewLayout:layout];
    _ShopFrontPageCView .dataSource = self;
    
    _ShopFrontPageCView.delegate = self;
    _ShopFrontPageCView.showsVerticalScrollIndicator = NO;
    self.ShopFrontPageCView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_ShopFrontPageCView];
    [self.ShopFrontPageCView registerClass:[GoodsShowCViewCell class] forCellWithReuseIdentifier:@"GoodsShowCViewCell"];
    [self.ShopFrontPageCView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.ShopFrontPageCView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];//注册也页眉视图
    [self.ShopFrontPageCView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];//注册页脚视图
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
        return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        if (section == 0) {
            return 1;
        }else {
            return 10;
        }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.section == 0) {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
            NSArray *pathArray = @[
                                   @"http://i4.cqnews.net/news/attachement/jpg/site82/2016-08-23/9143505007648195979.jpg",
                                   @"http://www.people.com.cn/mediafile/pic/20160830/95/17946987410935083075.jpg",
                                   @"http://p.nanrenwo.net/uploads/allimg/160912/8388-160912092346-50.jpg",
                                   @"http://upload.cbg.cn/2016/0728/1469695681806.jpg",
                                   @"http://image.cnpp.cn/upload/images/20160905/09380421552_400x300.jpg",
                                   @"http://cnews.chinadaily.com.cn/img/attachement/jpg/site1/20160729/0023ae82c931190560502f.jpg",
                                   ];
            SZCirculationImageView *imageView2 = [[SZCirculationImageView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height) andImageURLsArray:pathArray andTitles:nil];
            imageView2.titleViewStatus = SZTitleViewBottomOnlyPageControl;
            imageView2.pauseTime = 1.0;
            
            [cell addSubview:imageView2];
            return cell;
        }else {
            GoodsShowCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsShowCViewCell" forIndexPath:indexPath];
            return cell;
        }
}

//cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailsVController *VC = [[GoodsDetailsVController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
    NSLog(@"你点我干嘛");
}

//返回每个cell的布局左右上下间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
        if (section == 0) {
            return  UIEdgeInsetsMake(0 , 0, 0, 0);
        }else {
            return  UIEdgeInsetsMake(kFit(10), kFit(10), 0, kFit(10));
        }
}
//单独返回每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section == 0) {
            return CGSizeMake(kScreen_widht, kFit(127));
        }else {
            return CGSizeMake(kScreen_widht/2-12, kFit(260));
        }
}
//单独返回每一个页眉视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
        if (section == 0) {
            return CGSizeMake(0, 0);
        }else {
            return CGSizeMake(kScreen_widht, 40);
        }
}

//返回页眉 页脚
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"热门商品";
        [headerView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(headerView, 10).centerYEqualToView(headerView).widthIs(kScreen_widht).heightIs(20);
        return headerView;
    }else {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerview.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
        return footerview;
        
    }
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
