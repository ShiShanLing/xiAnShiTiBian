//
//  MessageViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/7.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCViewCell.h"
@interface MessageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching>

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color,NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];
    self.navigationController.navigationBar.barTintColor = kNavigation_whrColor;//导航条颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color}];//导航条标题颜色
    self.navigationItem.title = @"商城";//导航条标题
    
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //添加页眉
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 10;
    layout.headerReferenceSize = CGSizeMake(kScreen_widht, 42);

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = kDark;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[MessageCViewCell class] forCellWithReuseIdentifier:@"MessageCViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
}
- (void)handleReturn {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MessageCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MessageCViewCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.showImage.image = [UIImage imageNamed:@"12344.jpg"];
    }else {
    
    cell.showImage.image = [UIImage imageNamed:@"12345.jpg"];
    }
    return cell;
}
//返回每个cell的布局左右上下间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return  UIEdgeInsetsMake(10, 12, 0, 12);
}
//单独返回每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreen_widht-24, 165);
}
//单独返回每一个页眉视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeMake(kScreen_widht, 32);
    
}

//返回页眉 页脚
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"12:25";
        titleLabel.backgroundColor = [UIColor colorWithRed:161/256.0 green:161/256.0 blue:161/256.0 alpha:1];
        titleLabel.layer.cornerRadius = 3;
        titleLabel.layer.masksToBounds = YES;
        titleLabel.textColor = [UIColor colorWithRed:255/256.0 green:255/256.0 blue:255/256.0 alpha:1];
        [headerView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(headerView, (kScreen_widht-52)/2).topSpaceToView(headerView, 10).widthIs(52).heightIs(22);
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
