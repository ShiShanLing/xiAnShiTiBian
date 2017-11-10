//
//  SrosswiseSlipTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "SrosswiseSlipTVCell.h"
#import "GoodsShowCViewCell.h"
#import "VendorStoreCVCell.h"
@interface SrosswiseSlipTVCell()  <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching, UICollectionViewDelegate, UIScrollViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic, copy)NSMutableArray *storeArray;

@end

@implementation SrosswiseSlipTVCell {

    NSMutableArray *dataArray;
}

- (NSMutableArray *)storeArray {
    if (_storeArray) {
        _storeArray = [NSMutableArray array];
    }
    return _storeArray;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CreatingControls];
    }
    return self;
    
}
- (void)CreatingControls {
    
    UILabel *segmentationLabel = [UILabel new];
    segmentationLabel.backgroundColor = MColor(238, 238, 238);
    [self.contentView addSubview:segmentationLabel];
    segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, kFit(0)).rightSpaceToView(self.contentView, 0).heightIs(kFit(10));
    
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"经销商";
    titleLabel.textColor = MColor(51, 51, 51);
    titleLabel.font = MFont( kFit(17));
    [self.contentView addSubview:titleLabel];
    titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(segmentationLabel, kFit(17.5)).widthIs(kFit(100)).heightIs(kFit(17));

        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(kFit(135), kFit(130));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kFit(60), kScreen_widht,kFit(130)) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[VendorStoreCVCell class] forCellWithReuseIdentifier:@"VendorStoreCVCell"];
        
        [self.contentView addSubview:_collectionView];
    
   
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"section%ld  self.storeArray%@", self.storeArray.count,  self.storeArray);
    return dataArray.count;
    
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VendorStoreCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VendorStoreCVCell" forIndexPath:indexPath];
    cell.model = dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(ClickStoreIndex:)]) {
        [_delegate ClickStoreIndex:indexPath.row];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

//在这个方法里面给cell赋值

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

}
- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition {


}

- (void)handleLeftBtn{
    
  
    
}

- (void)handleRightBtn {



}

- (void)deliveryData:(NSArray *)array {

    self.storeArray = [NSMutableArray arrayWithArray:array];
    dataArray = [NSMutableArray arrayWithArray:array];
   // NSLog(@"model.listStore%@  dataArray%@", _storeArray, dataArray);
    
    [self.collectionView reloadData];
}


@end
