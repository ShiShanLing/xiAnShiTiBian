//
//  RankingCVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/27.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *店铺排行cell 点击代理
 */
@protocol RankingCVCellDelegate <NSObject>
/**
 *判断点击的第几个cell
 */
- (void)ChooseRankingStores:(int)index;
/**
 *判断点击的第几种排行
 */
- (void)RankingStoreType:(int)StoreType;
@end

/**
 *排行榜cell UICollectionViewCell里面放了一个横向滑动的UICollectionView
 */
@interface RankingCVCell : UICollectionViewCell

@property (nonatomic, assign)id<RankingCVCellDelegate>delegate;
/**
 *店铺排行的model数组
 */
@property (nonatomic, copy)NSMutableArray *storeArray;

@end
