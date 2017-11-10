//
//  RankingSingleCVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/27.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *排行榜的单个cell
 */
@interface RankingSingleCVCell : UICollectionViewCell

/**
 *商品图片
 */
@property (nonatomic, strong)UIImageView *storeImage;
/**
 *商品名称
 */
@property (nonatomic, strong)UILabel *storeName;
- (void)configureRanking:(NSInteger)index;

@property (nonatomic, strong)StoreRankingListModel *model;

@end
