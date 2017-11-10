//
//  HGSCViewCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/1.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HGSCViewCellDelegate <NSObject>


- (void)CellOption:(NSInteger)index;

@end

/**
 *横向滑动的推荐商品展示
 */
@interface HGSCViewCell : UICollectionViewCell

@property (nonatomic, assign)id<HGSCViewCellDelegate>delegate;

@property (nonatomic, strong)GoodsDetailsModel *model;

@property (nonatomic, strong)NSMutableArray *dataArray;

@end
