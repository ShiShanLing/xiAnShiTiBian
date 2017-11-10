//
//  RankingCVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/27.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "RankingCVCell.h"
#import "RankingSingleCVCell.h"
@interface RankingCVCell ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching, UICollectionViewDelegate, UIScrollViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
/**
 *让用知道在第几页的指示条
 */
@property(nonatomic,strong)UIScrollView*guideSV;

@property(nonatomic, strong)NSMutableArray *modelArray;

@end

@implementation RankingCVCell{
    UIButton*tembtn;
    NSMutableArray*btnArr;
}
- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
  return  _modelArray;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
        if (self) {
        [self CreatingControls];
        }
    return self;
}
- (void)CreatingControls {
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"排行";
    titleLabel.textColor = MColor(51, 51, 51);
    titleLabel.font = MFont( kFit(17));
    [self.contentView addSubview:titleLabel];
    titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(10)).widthIs(kFit(100)).heightIs(kFit(17));
    
    UIView *rankingView = [UIView new];
    
    [self.contentView addSubview:rankingView];
    rankingView.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(titleLabel, kFit(3)).widthIs(kFit(187)).heightIs(kFit(24));
    btnArr = [NSMutableArray array];
    NSArray *titleArray = @[@"销量排行", @"信誉排行", @"积分排行"];
    for (int i=0; i<3; i++) {
        UIButton*btn=[[UIButton alloc] initWithFrame:CGRectMake(i*kFit(187)/3, 0, kFit(187)/3, kFit(22))];
        btn.tag=i;
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:kFit(14)];
        [btnArr addObject:btn];
        if (i==0) {
            [btn setTitleColor:MColor(255, 140, 34) forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:MColor(136, 136, 136) forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(btn_clicked:) forControlEvents:UIControlEventTouchUpInside];
        [rankingView addSubview:btn];
    }
    
    self.guideSV=[[UIScrollView alloc] initWithFrame:CGRectMake(kFit(13), kFit(53), kFit(60), 2)];
    _guideSV.backgroundColor=MColor(255, 140, 34);
    _guideSV.delegate=self;
    _guideSV.contentSize=CGSizeMake(187*2, 2);
    _guideSV.showsHorizontalScrollIndicator=NO;
    _guideSV.showsVerticalScrollIndicator=NO;
    [self.contentView addSubview:_guideSV];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(kFit(135), kFit(130));
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 5;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kFit(120), kScreen_widht,kFit(130)) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[RankingSingleCVCell class] forCellWithReuseIdentifier:@"RankingSingleCVCell"];
    [self.contentView addSubview:_collectionView];
    _collectionView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(_guideSV,kFit(15)).rightSpaceToView(self.contentView, 0).heightIs(kFit(130));
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"numberOfItemsInSection%lu", (unsigned long)self.modelArray.count);
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RankingSingleCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RankingSingleCVCell" forIndexPath:indexPath];
    
    [cell configureRanking:indexPath.row];
    StoreRankingListModel *model = self.modelArray[indexPath.row];
    cell.model = model;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(ChooseRankingStores:)]) {
        [_delegate ChooseRankingStores:indexPath.row];
    }
}

- (void)setStoreArray:(NSMutableArray *)storeArray {
    self.modelArray = [NSMutableArray arrayWithArray:storeArray];
    [self.collectionView reloadData];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

//在这个方法里面给cell赋值

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    
}

- (void)btn_clicked:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            _guideSV.frame = CGRectMake(kFit(14), kFit(53), kFit(60), 2);
            if ([_delegate respondsToSelector:@selector(RankingStoreType:)]) {
                [_delegate RankingStoreType:0];
            }
            break;
        case 1:
            _guideSV.frame = CGRectMake(kFit(76), kFit(53), kFit(60), 2);
            if ([_delegate respondsToSelector:@selector(RankingStoreType:)]) {
                [_delegate RankingStoreType:1];
            }
            break;
        case 2:
           _guideSV.frame = CGRectMake(kFit(139), kFit(53), kFit(60), 2);
            if ([_delegate respondsToSelector:@selector(RankingStoreType:)]) {
                [_delegate RankingStoreType:2];
            }
            break;
        default:
            break;
    }
    
    for (int i = 0; i < btnArr.count; i ++) {
        UIButton *btn = btnArr[i];
        [btn setTitleColor:MColor(136, 136, 136) forState:UIControlStateNormal];
    }
    [sender setTitleColor:MColor(255, 140, 34) forState:UIControlStateNormal];
//    if ([_delegate respondsToSelector:@selector(ChooseRankingStores:)]) {
//        [_delegate ChooseRankingStores:sender.tag];
//    }
}
@end
