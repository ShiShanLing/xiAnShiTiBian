//
//  VendorAllGoodsVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/27.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "VendorAllGoodsVC.h"
#import "VendorAllGoodsCVCell.h"
@interface VendorAllGoodsVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching>
@property (nonatomic, strong)UICollectionView *collectionView;
@end

@implementation VendorAllGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurationNavigationBar];
    self.view.backgroundColor = [UIColor orangeColor];
    [self setCollectionView];
}
- (void)configurationNavigationBar {
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.title = @"全部产品";
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.navigationController.navigationBar.barTintColor = kNavigation_Color;//导航条颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//去除导航条上图片的渲染色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];
}
- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)setCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //添加页眉
    // [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.sectionInset = UIEdgeInsetsMake(-20, 10, 0, 10);//设置页眉的高度
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(kScreen_widht, kFit(15));
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) collectionViewLayout:layout];
    _collectionView .dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[VendorAllGoodsCVCell class] forCellWithReuseIdentifier:@"VendorAllGoodsCVCell"];
    [self.view addSubview:_collectionView];
  }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VendorAllGoodsCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VendorAllGoodsCVCell" forIndexPath:indexPath];
        return cell;
}
//cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
//返回每个cell的布局左右上下间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
        return  UIEdgeInsetsMake(0, kFit(12), 0, kFit(12));
}
//单独返回每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreen_widht-kFit(29))/2, kFit(260));
    
}

@end
