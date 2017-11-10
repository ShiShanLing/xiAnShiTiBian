//
//  HGSCViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/1.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "HGSCViewCell.h"
#import "GoodsShowCViewCell.h"

@interface HGSCViewCell ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching>

@property(nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSMutableArray *modelArray;

@end

@implementation HGSCViewCell

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self CreatingControls];
        
    }
    return self;
    
}
- (void)CreatingControls {
    
    _collectionView = ({
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake((kScreen_widht/2)-12, kFit(240));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[GoodsShowCViewCell class] forCellWithReuseIdentifier:@"GoodsShowCViewCell"];
        [self addSubview:collectionView];
        collectionView;
    });
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _modelArray.count;
}


- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     GoodsDetailsModel *model = _modelArray[indexPath.row];
    
    GoodsShowCViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsShowCViewCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(CellOption:)]) {
        [_delegate CellOption:indexPath.row];
    }
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    //NSLog(@"setDataArray%@", dataArray);
    self.modelArray = dataArray;
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDelegateFlowLayout


@end
